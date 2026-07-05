; ============================================================
;  圣遗物拾取模块（供路线脚本 #Include 使用）
; ------------------------------------------------------------
;  用法：路线脚本顶部加  #Include "..\检测圣遗物\圣遗物拾取模块.ahk"
;        并在自执行段(第一个热键之前)调用一次  AP_Start()  即自动开启
;  按 F7 手动开关
;
;  依赖：同目录下的 OCR.ahk
;
;  工作原理：
;   1. 列表是否开启 = 两段式检测：
;        先 GDI 快速找 F 白框(~3ms)；找不到再 OCR 兜底看有没有文字。
;        这样正常情况快，>6条且F不可见的情况也能靠OCR确认列表存在。
;   2. 圣遗物识别 = OCR 文字 + 套装特征字匹配(命中任一特征字即圣遗物)。
;   3. 定位 = OCR整列表算圣遗物在第几行、F在第几行，智能选方向滚过去，
;        按F前再OCR确认当前行确实是圣遗物(防捡错)。
;
;  所有像素操作用绝对屏幕坐标(GDI/OCR)，不依赖也不修改全局CoordMode。
;  坐标按 2560x1600 + DPI150% 校准；换环境需用区域检测器重新校准。
; ============================================================
#Include "OCR.ahk"

; ---------- 可调参数 ----------
global AP_ON := false               ; 开关状态(由 AP_Start()/F7 控制,勿手改)
global AP_IDLE_INTERVAL := 40       ; 空闲检测间隔(没列表时,ms)
global AP_ACTIVE_INTERVAL := 20     ; 列表出现后的快速检测间隔(ms)
global AP_CUR_INTERVAL := 50        ; 当前实际间隔(内部用)
global AP_WHEEL_DELAY := 5          ; 滚轮中间步等待(ms);最后一步不等待
global AP_PICK_WAIT := 100          ; 按F后等待列表刷新(ms)
global AP_PROCESS_TIMEOUT := 1000   ; 单轮最长执行时间(ms),超时强制结束防卡死
global AP_ProcessStart := 0         ; 内部:本轮开始时间戳
global AP_SCROLL_COOLDOWN := 200    ; 两次"带回F"滚动的最小间隔(ms),防滚太快连滚两次
global AP_LastScrollTime := 0       ; 内部:上次带回F滚动的时间戳
global AP_LIST_MIN_CHARS := 3       ; 兜底确认列表时,OCR至少要读到几个字(配合Enter检测双保险)

; ---------- 坐标参数(2560x1600 / DPI150%) ----------
; F白框检测区(列表里带"F"的白色方块所在竖条)
global AP_FBOX_X1 := 1458
global AP_FBOX_X2 := 1515
global AP_FBOX_TOP := 500
global AP_FBOX_BOT := 1060

; OCR识别区(跳过图标,覆盖6行文字)
global AP_OCR_X := 1610
global AP_OCR_Y := 500
global AP_OCR_W := 180
global AP_OCR_H := 560

; 列表布局(把F框y换算成第几行)
global AP_LIST_CENTER_Y := 798      ; ≤6条居中时的列表中心y(恒定)
global AP_LIST_FULLTOP_Y := 558     ; >6条顶部排时第1条中心y
global AP_ITEM_SPACING := 96        ; 条目间距

; 圣遗物套装特征字(材料名里没有这些字,命中任一即判定圣遗物)
; 精英怪掉落:游医/流放者/教官/战狂。增删套装时改这里，官 字删掉了，因为其他普通材料也很容易出现这个字。
global AP_KEYWORDS := ["游", "医", "流", "放", "者", "教", "战", "狂"]

; ============================================================
;  开关与启动
; ============================================================
F7:: {
    global AP_ON, AP_IDLE_INTERVAL, AP_CUR_INTERVAL
    AP_ON := !AP_ON
    if AP_ON {
        AP_CUR_INTERVAL := AP_IDLE_INTERVAL
        SetTimer(AP_MainLoop, AP_IDLE_INTERVAL)
        ShowToast("✦ 圣遗物自动拾取：已开启")
    } else {
        SetTimer(AP_MainLoop, 0)
        ShowToast("✦ 圣遗物自动拾取：已关闭")
    }
}

; 在路线脚本自执行段调用,自动开启
AP_Start() {
    global AP_ON, AP_CUR_INTERVAL, AP_IDLE_INTERVAL
    AP_ON := true
    AP_CUR_INTERVAL := AP_IDLE_INTERVAL
    SetTimer(AP_MainLoop, AP_IDLE_INTERVAL)
}

; ============================================================
;  主循环(定时器调用)
; ============================================================
AP_MainLoop() {
    global
    static busy := false
    if busy
        return
    if !WinActive("ahk_class UnityWndClass") {
        AP_SetInterval(AP_IDLE_INTERVAL)
        return
    }

    ; ---- 检测列表是否开启 ----
    fy := AP_GetFBoxY()
    if (fy = 0) {
        ; F白框看不见。可能是 >6条且F在不可见位置 → 确认列表存在再滚一格把F带回。
        ; 双重确认: 1)在大世界(能搜到Enter标志,排除地图/角色详情/对话等)
        ;          2)OCR确认列表有≥N个字
        ; 再加滚动冷却,防止滚太快导致游戏连滚两格。
        if (AP_IsWorldOpen() && AP_ListHasText()) {
            if (A_TickCount - AP_LastScrollTime >= AP_SCROLL_COOLDOWN) {
                Send "{WheelDown}"
                AP_LastScrollTime := A_TickCount
            }
            AP_SetInterval(AP_ACTIVE_INTERVAL)
            return                  ; 下一轮F应可见,正常处理
        }
        ; 没列表(或不在大世界)
        AP_SetInterval(AP_IDLE_INTERVAL)
        return
    }

    ; F白框可见 → 列表开着,加快检测并进入拾取
    AP_SetInterval(AP_ACTIVE_INTERVAL)
    busy := true
    AP_ProcessStart := A_TickCount
    try AP_ProcessPickup()
    finally busy := false
}

; 动态调整定时器间隔(仅在变化时重设)
AP_SetInterval(ms) {
    global AP_CUR_INTERVAL
    if (AP_CUR_INTERVAL != ms) {
        AP_CUR_INTERVAL := ms
        SetTimer(AP_MainLoop, ms)
    }
}

; ============================================================
;  拾取核心：算位置 → 智能滚动 → 确认 → 按F
; ============================================================
AP_ProcessPickup() {
    global
    Loop 6 {                        ; 最多处理6个圣遗物/轮
        if (A_TickCount - AP_ProcessStart > AP_PROCESS_TIMEOUT)
            return

        items := AP_ScanList()      ; OCR整列表
        total := items.Length
        if total = 0
            return

        ; 找第一个圣遗物在第几行
        targetRow := 0
        for i, it in items {
            if it.isArtifact {
                targetRow := i
                break
            }
        }
        if targetRow = 0
            return                  ; 没有圣遗物了

        ; 算F当前在第几行
        curRow := AP_GetCurrentRow(total)
        if curRow = 0
            return

        ; 决定方向和步数:往上更近且不经过顶部就往上,否则往下(循环必达)
        downSteps := Mod(targetRow - curRow + total, total)
        upSteps := curRow - targetRow
        dir := "down"
        steps := downSteps
        if (upSteps > 0 && curRow > 1 && upSteps <= downSteps) {
            dir := "up"
            steps := upSteps
        }

        ; 执行滚动(中间步带delay,最后一步不带,靠后面OCR耗时自然等待)
        if (steps > 0) {
            key := (dir = "up") ? "{WheelUp}" : "{WheelDown}"
            Loop steps {
                Send key
                if (A_Index < steps)
                    Sleep AP_WHEEL_DELAY
            }
        }

        ; 按F前确认:等画面稳定→OCR当前行→是圣遗物才按F
        Sleep 30
        if AP_ConfirmAndPick()
            continue                ; 成功,列表刷新,下一轮
        ; 第一次没确认到,再等一下重试一次(防滚动残影误判)
        Sleep 40
        if AP_ConfirmAndPick()
            continue
        return                      ; 仍不对,本轮放弃,下次定时器再来
    }
}

; 确认当前F行是圣遗物则按F,返回是否成功
AP_ConfirmAndPick() {
    global
    fy := AP_GetFBoxY()
    if (fy != 0 && AP_IsArtifactAtRow(fy)) {
        Send "f"
        Sleep AP_PICK_WAIT
        return true
    }
    return false
}

; ============================================================
;  OCR 相关
; ============================================================

; OCR整列表,返回有序条目 [{text, isArtifact}, ...]
AP_ScanList() {
    global
    items := []
    try {
        result := OCR.FromRect(AP_OCR_X, AP_OCR_Y, AP_OCR_W, AP_OCR_H, {lang:"zh-Hans-CN", scale:2})
    } catch {
        return items
    }
    for line in result.Lines {
        clean := StrReplace(StrReplace(line.Text, " "), "`t")
        if (clean = "")
            continue
        if RegExMatch(clean, "^\d+$")       ; 跳过纯数字(堆叠数量)
            continue
        items.Push({ text: clean, isArtifact: AP_IsArtifactText(clean) })
    }
    return items
}

; OCR整个列表区域,只要识别到任何文字就算"列表存在"(用于F不可见时兜底)
; 检测OCR区域是否有"品质彩色文字"(拾取列表特征)
; 用GDI数彩色像素,不读文字内容,所以比OCR快(~3ms vs 16ms)
; 原理:拾取列表物品名是品质色(青/蓝/紫/绿,三通道差大);
;       角色详情数字是白色、地图地名是白/浅色(三通道接近) → 不算彩色 → 排除
; 保险: OCR确认区域里确实有足够文字内容(识别列表用)
AP_ListHasText() {
    global AP_OCR_X, AP_OCR_Y, AP_OCR_W, AP_OCR_H, AP_LIST_MIN_CHARS
    try {
        result := OCR.FromRect(AP_OCR_X, AP_OCR_Y, AP_OCR_W, AP_OCR_H, {lang:"zh-Hans-CN", scale:2})
    } catch {
        return false
    }
    clean := StrReplace(StrReplace(result.Text, " "), "`t")
    return (StrLen(clean) >= AP_LIST_MIN_CHARS)
}

; 检测是否在大世界:搜左下角"Enter"标志(大世界独有,地图/角色详情/对话界面都没有)。
; 用两个模板覆盖Enter的两种位置/大小状态(有无对话气泡图标会左右移位),OR匹配。
; 这是【正向确认】:搜到Enter=在大世界=允许拾取/滚动;搜不到=不在大世界=禁止。
; 比之前"排除地图+排除角色详情"的反向逻辑更干净、更稳,且无需冷却。
AP_IsWorldOpen() {
    enterPath := A_ScriptDir "\..\其他\images\enter.png"
    enterPath2 := A_ScriptDir "\..\其他\images\enter2.png"
    try {
        if ImageSearch(&ex, &ey, 50, 1520, 210, 1570, "*30 " enterPath)
            or ImageSearch(&ex, &ey, 50, 1520, 210, 1570, "*30 " enterPath2)
            return true
    }
    return false
}

; OCR单行(F框那条),判断是否圣遗物
AP_IsArtifactAtRow(fy) {
    global
    try {
        ; 确认区域:F中心上下各48(高96,约一个条目高),完整框住一行避免切字;scale3更清晰
        result := OCR.FromRect(AP_OCR_X, fy - 48, AP_OCR_W, 96, {lang:"zh-Hans-CN", scale:3})
    } catch {
        return false
    }
    return AP_IsArtifactText(StrReplace(StrReplace(result.Text, " "), "`t"))
}

; 文字是否含任一圣遗物特征字
AP_IsArtifactText(txt) {
    global AP_KEYWORDS
    for kw in AP_KEYWORDS {
        if InStr(txt, kw)
            return true
    }
    return false
}

; 算F当前在第几行(1-based)。≤6条居中,>6条顶部排。找不到返回0
AP_GetCurrentRow(total) {
    global AP_LIST_CENTER_Y, AP_LIST_FULLTOP_Y, AP_ITEM_SPACING
    fy := AP_GetFBoxY()
    if fy = 0
        return 0
    if (total <= 6)
        row := Round((fy - AP_LIST_CENTER_Y) / AP_ITEM_SPACING + (total + 1) / 2)
    else
        row := Round((fy - AP_LIST_FULLTOP_Y) / AP_ITEM_SPACING) + 1
    if (row < 1)
        row := 1
    if (row > total)
        row := total
    return row
}

; ============================================================
;  F白框检测(GDI快速截图)
; ============================================================

; 截屏指定矩形到内存,返回 {w, h, data(BGRA Buffer)}
AP_CaptureRect(x, y, w, h) {
    hdcScreen := DllCall("GetDC", "ptr", 0, "ptr")
    hdcMem := DllCall("CreateCompatibleDC", "ptr", hdcScreen, "ptr")
    hbm := DllCall("CreateCompatibleBitmap", "ptr", hdcScreen, "int", w, "int", h, "ptr")
    obm := DllCall("SelectObject", "ptr", hdcMem, "ptr", hbm, "ptr")
    DllCall("BitBlt", "ptr", hdcMem, "int", 0, "int", 0, "int", w, "int", h
        , "ptr", hdcScreen, "int", x, "int", y, "uint", 0x00CC0020)  ; SRCCOPY
    bi := Buffer(40, 0)
    NumPut("uint", 40, bi, 0)
    NumPut("int", w, bi, 4)
    NumPut("int", -h, bi, 8)        ; 负高=自上而下
    NumPut("ushort", 1, bi, 12)
    NumPut("ushort", 32, bi, 14)
    data := Buffer(w * h * 4, 0)
    DllCall("GetDIBits", "ptr", hdcMem, "ptr", hbm, "uint", 0, "uint", h
        , "ptr", data, "ptr", bi, "uint", 0)
    DllCall("SelectObject", "ptr", hdcMem, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC", "ptr", hdcMem)
    DllCall("ReleaseDC", "ptr", 0, "ptr", hdcScreen)
    return { w: w, h: h, data: data }
}

; 找F白框中心y(GDI截图后内存扫描)。找不到返回0
; 找F白框中心y。双保险:先用ImageSearch找F图案(抗拾取特效干扰,主),
; 找不到再退回GDI数白像素(F可能被遮一半时兜底)。找不到返回0。
AP_GetFBoxY() {
    global AP_FBOX_X1, AP_FBOX_X2, AP_FBOX_TOP, AP_FBOX_BOT
    ; —— 主:ImageSearch找F图案 ——
    ; 检测区x放宽一点(F会左右小幅移动),y用原范围
    fboxPath := A_ScriptDir "\..\其他\images\fbox.png"
    try {
        if ImageSearch(&fx, &fy, AP_FBOX_X1 - 20, AP_FBOX_TOP, AP_FBOX_X2 + 20, AP_FBOX_BOT, "*20 " fboxPath) {
            ; fy是模板左上角,加半个模板高(fbox.png高39)得中心
            return fy + 19
        }
    }
    ; —— 兜底:GDI数白像素(F被特效/遮挡影响时) ——
    return AP_GetFBoxY_GDI()
}

; GDI数白像素找F白框中心y(兜底用)。找不到返回0。
AP_GetFBoxY_GDI() {
    global AP_FBOX_X1, AP_FBOX_X2, AP_FBOX_TOP, AP_FBOX_BOT
    capW := AP_FBOX_X2 - AP_FBOX_X1 + 1
    capH := AP_FBOX_BOT - AP_FBOX_TOP + 1
    cap := AP_CaptureRect(AP_FBOX_X1, AP_FBOX_TOP, capW, capH)
    data := cap.data
    threshold := capW * 0.5         ; 一行过半是白才算白行
    top := -1, bot := -1
    Loop capH {
        ry := A_Index - 1
        cnt := 0
        Loop capW {
            rx := A_Index - 1
            off := (ry * capW + rx) * 4
            b := NumGet(data, off, "uchar")
            g := NumGet(data, off + 1, "uchar")
            r := NumGet(data, off + 2, "uchar")
            if (r > 200 && g > 200 && b > 200)
                cnt++
        }
        if (cnt >= threshold) {
            if (top = -1)
                top := ry
            bot := ry
        }
    }
    if (top = -1)
        return 0
    return AP_FBOX_TOP + Round((top + bot) / 2)
}
