; ============================================================
;  圣遗物拾取模块（供路线脚本 #Include 使用）
;  用法：路线脚本顶部加  #Include "..\检测圣遗物\圣遗物拾取模块.ahk"
;  本模块不含 #Requires / #SingleInstance（由主脚本提供）
;  所有像素操作用绝对屏幕坐标(GDI/OCR)，不依赖也不修改全局CoordMode
;  按 F9 开关
;  依赖：同目录下的 OCR.ahk
;
;  识别逻辑：
;   - 列表是否开启：检测F白框(列表里带"F"的白色方块)
;   - 圣遗物识别：OCR文字 + 套装特征字匹配
;   - 定位：OCR整列表算位置 → 智能选方向滚动 → 按F前OCR确认
; ============================================================
#Include "OCR.ahk"

; ---------- 可调参数 ----------
global AP_IDLE_INTERVAL := 50     ; 空闲时检测间隔(没列表,ms)
global AP_ACTIVE_INTERVAL := 30    ; 检测到列表后的快速间隔(ms)
global AP_CUR_INTERVAL := 150      ; 当前实际间隔(内部用,勿手动改)
global AP_PROCESS_TIMEOUT := 1500  ; 单轮最长执行时间(ms),超时强制结束防卡死
global AP_ProcessStart := 0        ; 内部:本轮开始时间
global AP_ON := false               ; 由 AP_Start() 启动,不要改这里
global AP_WHEEL_DELAY := 1        ; 中间每步滚轮后等待(ms);最后一步不等待
global AP_PICK_WAIT := 50          ; 按F后等待(ms)

; F白框检测区(屏幕绝对坐标)
global AP_FBOX_X1 := 1458
global AP_FBOX_X2 := 1515
global AP_FBOX_TOP := 500
global AP_FBOX_BOT := 1060


; OCR识别区
global AP_OCR_X := 1610
global AP_OCR_Y := 500
global AP_OCR_W := 180
global AP_OCR_H := 560

; 列表布局(用于一次定位算第几行)
global AP_LIST_CENTER_Y := 798     ; ≤6条居中时的列表中心y(恒定)
global AP_LIST_FULLTOP_Y := 558    ; >6条时第1条中心y(固定从顶部排)
global AP_ITEM_SPACING := 96       ; 条目间距

; 圣遗物特征字(材料名里没有的字,命中任一即判定圣遗物)
global AP_KEYWORDS := ["游", "医", "流", "放", "者", "教", "官", "战", "狂"]

; ---------- 开关 F7 ----------
F7:: {
    global AP_ON, AP_IDLE_INTERVAL, AP_CUR_INTERVAL
    AP_ON := !AP_ON
    if AP_ON {
        AP_CUR_INTERVAL := AP_IDLE_INTERVAL
        SetTimer(AP_MainLoop, AP_IDLE_INTERVAL)
        ShowToast("圣遗物自动拾取：已开启")
    } else {
        SetTimer(AP_MainLoop, 0)
        ShowToast("圣遗物自动拾取：已关闭")
    }
}

; ---------- 启动函数：在路线脚本的自执行段调用 AP_Start() 即可自动开启 ----------
AP_Start() {
    global AP_ON, AP_CUR_INTERVAL, AP_IDLE_INTERVAL
    AP_ON := true
    AP_CUR_INTERVAL := AP_IDLE_INTERVAL
    SetTimer(AP_MainLoop, AP_IDLE_INTERVAL)
}

AP_MainLoop() {
    global
    static busy := false
    if busy
        return
    if !WinActive("ahk_class UnityWndClass") {
        AP_SetInterval(AP_IDLE_INTERVAL)    ; 窗口非激活,回到慢检测
        return
    }
    if AP_GetFBoxY() = 0 {
        AP_SetInterval(AP_IDLE_INTERVAL)    ; 没列表,回到慢检测(150ms)
        return
    }
    ; 检测到列表 → 加快检测频率(50ms)
    AP_SetInterval(AP_ACTIVE_INTERVAL)

    busy := true
    AP_ProcessStart := A_TickCount          ; 记录开始时间(用于超时保护)
    try AP_ProcessPickup()
    finally busy := false
}

; 动态调整定时器间隔(只在变化时重设,避免频繁SetTimer)
AP_SetInterval(ms) {
    global AP_CUR_INTERVAL
    if (AP_CUR_INTERVAL != ms) {
        AP_CUR_INTERVAL := ms
        SetTimer(AP_MainLoop, ms)
    }
}

; ============================================================
;  核心：纯"边滚边测"——不算第几条，F指着哪就测哪
;  先确认列表有圣遗物 → 逐格遍历：OCR当前F行,是圣遗物就按F,不是就往下滚
;  完全不依赖列表布局/居中公式，最鲁棒
; ============================================================
AP_ProcessPickup() {
    global
    Loop 8 {
        if (A_TickCount - AP_ProcessStart > AP_PROCESS_TIMEOUT)
            return

        ; OCR整列表,拿到有序条目
        items := AP_ScanList()
        total := items.Length
        if total = 0
            return

        ; 找第一个圣遗物是第几行(1-based)
        targetRow := 0
        for i, it in items {
            if it.isArtifact {
                targetRow := i
                break
            }
        }
        if targetRow = 0
            return                  ; 没有圣遗物了

        ; 算当前F在第几行
        curRow := AP_GetCurrentRow(total)
        if curRow = 0
            return

        ; 计算往下滚的步数(只往下,循环一定能到)
        steps := Mod(targetRow - curRow + total, total)
        if (steps > 0) {
            Loop steps {
                Send "{WheelDown}"
                if (A_Index < steps)
                    Sleep AP_WHEEL_DELAY
            }
        }

        ; 到位后等画面稳定,OCR确认当前行确实是圣遗物再按F
        Sleep 20
        fy := AP_GetFBoxY()
        if (fy != 0 && AP_IsArtifactAtRow(fy)) {
            Send "f"
            Sleep AP_PICK_WAIT
            ; 成功,继续下一轮(重新OCR,因为列表刷新了)
            continue
        }
        ; 确认没通过(定位偏了),重测一次当前行
        Sleep 30
        fy := AP_GetFBoxY()
        if (fy != 0 && AP_IsArtifactAtRow(fy)) {
            Send "f"
            Sleep AP_PICK_WAIT
            continue
        }
        ; 还是不对,本轮放弃(下次定时器再来,避免死循环)
        return
    }
}

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
        if RegExMatch(clean, "^\d+$")
            continue
        items.Push({ text: clean, isArtifact: AP_IsArtifactText(clean) })
    }
    return items
}

; 算F当前在第几行(1-based)。用列表布局:
;  ≤6条 → 垂直居中(中心恒定 AP_LIST_CENTER_Y)
;  >6条 → 固定从顶部排(第1条在 AP_LIST_FULLTOP_Y)
AP_GetCurrentRow(total) {
    global AP_LIST_CENTER_Y, AP_LIST_FULLTOP_Y, AP_ITEM_SPACING
    fy := AP_GetFBoxY()
    if fy = 0
        return 0
    if (total <= 6) {
        ; 居中: 第k条y = 中心 + (k-(total+1)/2)*spacing
        row := Round((fy - AP_LIST_CENTER_Y) / AP_ITEM_SPACING + (total + 1) / 2)
    } else {
        ; 顶部排: 第k条y = 顶部 + (k-1)*spacing
        row := Round((fy - AP_LIST_FULLTOP_Y) / AP_ITEM_SPACING) + 1
    }
    if (row < 1)
        row := 1
    if (row > total)
        row := total
    return row
}

; 整列表OCR一次，判断有没有任何圣遗物
AP_HasAnyArtifact() {
    global
    try {
        result := OCR.FromRect(AP_OCR_X, AP_OCR_Y, AP_OCR_W, AP_OCR_H, {lang:"zh-Hans-CN", scale:2})
    } catch {
        return false
    }
    return AP_IsArtifactText(StrReplace(StrReplace(result.Text, " "), "`t"))
}

; ============================================================
;  OCR整列表,返回有序条目 [{text, isArtifact}, ...]
; ============================================================

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

AP_IsArtifactText(txt) {
    global AP_KEYWORDS
    for kw in AP_KEYWORDS {
        if InStr(txt, kw)
            return true
    }
    return false
}

; ============================================================
;  F白框检测(GDI快速截图)
; ============================================================
AP_CaptureRect(x, y, w, h) {
    hdcScreen := DllCall("GetDC", "ptr", 0, "ptr")
    hdcMem := DllCall("CreateCompatibleDC", "ptr", hdcScreen, "ptr")
    hbm := DllCall("CreateCompatibleBitmap", "ptr", hdcScreen, "int", w, "int", h, "ptr")
    obm := DllCall("SelectObject", "ptr", hdcMem, "ptr", hbm, "ptr")
    DllCall("BitBlt", "ptr", hdcMem, "int", 0, "int", 0, "int", w, "int", h
        , "ptr", hdcScreen, "int", x, "int", y, "uint", 0x00CC0020)
    bi := Buffer(40, 0)
    NumPut("uint", 40, bi, 0)
    NumPut("int", w, bi, 4)
    NumPut("int", -h, bi, 8)
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

AP_GetFBoxY() {
    global AP_FBOX_X1, AP_FBOX_X2, AP_FBOX_TOP, AP_FBOX_BOT
    capW := AP_FBOX_X2 - AP_FBOX_X1 + 1
    capH := AP_FBOX_BOT - AP_FBOX_TOP + 1
    cap := AP_CaptureRect(AP_FBOX_X1, AP_FBOX_TOP, capW, capH)
    data := cap.data
    rowWhite := Map()
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
        rowWhite[ry] := cnt
    }
    threshold := capW * 0.5
    top := -1, bot := -1
    Loop capH {
        ry := A_Index - 1
        if (rowWhite[ry] >= threshold) {
            if (top = -1)
                top := ry
            bot := ry
        }
    }
    if (top = -1)
        return 0
    return AP_FBOX_TOP + Round((top + bot) / 2)
}
