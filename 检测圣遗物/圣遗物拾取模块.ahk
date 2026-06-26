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
global AP_WHEEL_DELAY := 2          ; 滚轮中间步等待(ms);最后一步不等待
global AP_PICK_WAIT := 75           ; 按F后等待列表刷新(ms)
global AP_PROCESS_TIMEOUT := 1000   ; 单轮最长执行时间(ms),超时强制结束防卡死
global AP_ProcessStart := 0         ; 内部:本轮开始时间戳
global AP_SCROLL_COOLDOWN := 200    ; 两次"带回F"滚动的最小间隔(ms),防滚太快连滚两次
global AP_LastScrollTime := 0       ; 内部:上次带回F滚动的时间戳
global AP_MAP_COOLDOWN := 800       ; 检测到地图后,保持"地图开启"判定的时长(ms)
                                    ; 让齿轮↔cross切换的空窗期不会误触滚轮
global AP_LastMapTime := 0          ; 内部:上次检测到地图的时间戳
global AP_MKEY_GRACE := 1200        ; 按M开/关地图后,这段时间内直接认定在地图(ms)
                                    ; 解决"地图刚打开、齿轮还没出现,但已读到文字"的误滚
global AP_LastMKeyTime := 0         ; 内部:上次按M的时间戳
global AP_LIST_MIN_CHARS := 4       ; 兜底确认列表时,OCR至少要读到几个字(配合彩色检测双保险)

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

; 监视M键(开/关地图):记录时间戳,给地图检测一个提前量。
; ~ 表示不拦截,M键照常传给游戏。这样"地图刚打开、齿轮还没出现"时也能提前判定在地图。
~m:: {
    global AP_LastMKeyTime
    AP_LastMKeyTime := A_TickCount
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

    ; ---- 两段式检测列表是否开启 ----
    fy := AP_GetFBoxY()
    if (fy = 0) {
        ; F白框看不见。可能是 >6条且F在不可见位置 → 确认列表存在再滚一格把F带回。
        ; 三重防误触: 1)非地图  2)品质彩色文字够多  3)OCR确认有≥N个字
        ; 再加滚动冷却,防止滚太快导致游戏连滚两格。
        if (!AP_IsMapOpen() && AP_HasColoredText() && AP_ListHasText()) {
            if (A_TickCount - AP_LastScrollTime >= AP_SCROLL_COOLDOWN) {
                Send "{WheelDown}"
                AP_LastScrollTime := A_TickCount
            }
            AP_SetInterval(AP_ACTIVE_INTERVAL)
            return                  ; 下一轮F应可见,正常处理
        }
        ; 没列表(或在看地图)
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
; 保险1a: 检测OCR区域是否有"品质彩色文字"(GDI数彩色像素,~3ms)
; 拾取列表物品名是品质色(青/蓝/紫/绿,三通道差大);角色详情白数字、地图白地名不算彩色
AP_HasColoredText() {
    global AP_OCR_X, AP_OCR_Y, AP_OCR_W, AP_OCR_H
    cap := AP_CaptureRect(AP_OCR_X, AP_OCR_Y, AP_OCR_W, AP_OCR_H)
    data := cap.data
    colored := 0
    Loop AP_OCR_H {
        ry := A_Index - 1
        Loop AP_OCR_W {
            rx := A_Index - 1
            off := (ry * AP_OCR_W + rx) * 4
            b := NumGet(data, off, "uchar")
            g := NumGet(data, off + 1, "uchar")
            r := NumGet(data, off + 2, "uchar")
            mx := Max(r, g, b)
            mn := Min(r, g, b)
            if (mx > 150 && (mx - mn) > 60)     ; 够亮 且 三通道差大=品质彩色
                colored++
        }
    }
    return (colored > 800)                       ; 彩色文字像素够多
}

; 保险1b: OCR确认区域里确实有足够文字内容(配合彩色检测,双保险防误触)
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

; 检测地图是否打开(用 ImageSearch 找左下角地图特征图标)
; 防止地图上的文字被误当成拾取列表而触发滚轮缩放地图
; 依赖图片: ..\其他\images\ismapopen.png (相对于主脚本-6.ahk所在的精英怪目录)
; 检测地图是否打开:找地图界面的齿轮图标(比滑块菱形稳定,位置/形状固定)
; 容错*30即可。齿轮检测区坐标需按实际位置校准。
; 检测地图是否打开:齿轮 OR cross 任一匹配即地图开着。
;  - 齿轮(ismapopen_gear):地图常驻左下角设置图标,大多数时候靠它
;  - cross(ismapopen_cross):选锚点准备传送时齿轮会消失,用四向箭头兜底
; 冷却机制:每次都先实检图标,检测到就刷新时间戳;没检测到时若仍在冷却窗口内也算开着。
; 这样齿轮↔cross切换的空窗期(某一帧两个都没匹配上)由冷却桥接,不会漏判而误触滚轮;
; 且因每次命中都续期,连续点锚点再返回也不会出现"冷却到期撞空窗"的漏判。
AP_IsMapOpen() {
    global AP_MAP_COOLDOWN, AP_LastMapTime, AP_MKEY_GRACE, AP_LastMKeyTime
    ; 提前量:刚按过M(开/关地图),这段时间直接认定在地图。
    ; 覆盖"地图刚打开、齿轮还没渲染出来、但OCR已读到文字"的瞬间,防误滚。
    if (A_TickCount - AP_LastMKeyTime < AP_MKEY_GRACE)
        return true
    ; 每次都【实际检测】齿轮/cross。检测到就刷新时间戳。
    gearPath := A_ScriptDir "\..\其他\images\ismapopen_gear.png"
    crossPath := A_ScriptDir "\..\其他\images\ismapopen_cross.png"
    try {
        ; 齿轮在左下角; cross(选锚点时)在右上角 — 两个区域不同
        if ImageSearch(&mx, &my, 41, 1484, 108, 1556, "*30 " gearPath)
            or ImageSearch(&mx, &my, 2454, 6, 2535, 87, "*30 " crossPath) {
            AP_LastMapTime := A_TickCount        ; 检测到,刷新时间戳
            return true
        }
    }
    ; 没检测到图标:若仍在上次检测后的冷却窗口内,仍认定开着(桥接齿轮↔cross空窗)。
    ; 这里【不刷新】时间戳,所以地图真正关闭后冷却会自然过期,不会永久误判。
    ; 关键:因为每次"检测到"都会刷新,只要地图开着、图标交替出现,窗口就持续滚动,
    ;       不会出现旧逻辑"冷却期内不检测→到期正好撞空窗"的漏判。
    if (A_TickCount - AP_LastMapTime < AP_MAP_COOLDOWN)
        return true
    return false
}

; OCR单行(F框那条),判断是否圣遗物
AP_IsArtifactAtRow(fy) {
    global
    try {
        result := OCR.FromRect(AP_OCR_X, fy - 35, AP_OCR_W, 70, {lang:"zh-Hans-CN", scale:2})
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
AP_GetFBoxY() {
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
