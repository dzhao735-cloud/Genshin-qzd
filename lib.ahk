#Requires AutoHotkey v2.0
#SingleInstance Force

; ============== 系统初始化 ==============
TraySetIcon("shell32.dll", 127)
A_MenuMaskKey := "vkE8"
CoordMode "Mouse", "Window"
SendMode "Input"
SetMouseDelay -1
SetKeyDelay -1, -1
SetWinDelay -1
ProcessSetPriority "High"
DllCall("winmm.dll\timeBeginPeriod", "UInt", 1)
OnExit((*) => DllCall("winmm.dll\timeEndPeriod", "UInt", 1))

; =============== 公共函数 ===============
ShowClickMark(x, y) {
    try {
        WinGetPos(&wx, &wy, , , "ahk_class UnityWndClass")
    } catch {
        return
    }
    screenX := wx + x
    screenY := wy + y
    sz := 16
    mark := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    mark.BackColor := "FF4444"
    mark.Show("x" (screenX - sz//2) " y" (screenY - sz//2) " w" sz " h" sz " NoActivate")
    WinSetRegion("0-0 W" sz " H" sz " E", mark.Hwnd)
    WinSetTransparent(220, mark.Hwnd)
    opacity := 220
    FadeTimer := () => ((opacity -= 7),(opacity <= 0) ? (SetTimer(FadeTimer, 0), mark.Destroy()) : WinSetTransparent(opacity, mark.Hwnd))
    SetTimer(FadeTimer, 40)
}

SendInputDrag(xS, yS, xE, yE, maxDeltaPerStep := 50) {
    MouseMove(xS, yS, 0)
    Sleep(32)
    SendInput("{LButton Down}")
    Sleep(60)
    totalDX := xE - xS
    totalDY := yE - yS
    steps := Max(1, Ceil(Max(Abs(totalDX), Abs(totalDY)) / maxDeltaPerStep))
    Loop steps {
        curX := Round(xS + totalDX * A_Index / steps)
        curY := Round(yS + totalDY * A_Index / steps)
        MouseMove(curX, curY, 0)
        Sleep(32)
    }
    Sleep(60)
    SendInput("{LButton Up}")
    Sleep(32)
}

ShowToast(msg, duration := 2000) {
    static g := ""
    try g.Destroy()
    g := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    
    ;===================== 背景&字体 颜色 ====================
    ; g.BackColor := "2c2c2c"
    ; g.SetFont("s14 c8325f6 Bold", "Microsoft YaHei")
    
    ; g.BackColor := "1A1A2E"   ; 深蓝黑
    ; g.SetFont("s14 cFFD700 Bold", "Microsoft YaHei")  ; 金色
    
    ; g.BackColor := "0D0D0D"   ; 纯黑
    ; g.SetFont("s14 c00FFD1 Bold", "Microsoft YaHei")  ; 青绿
    
    ; g.BackColor := "1C1C1C"   ; 深灰黑
    ; g.SetFont("s14 cFF6B35 Bold", "Microsoft YaHei")  ; 橙红
    
    ; g.BackColor := "1E0A2E"   ; 深紫黑
    ; g.SetFont("s14 cCFA8FF Bold", "Microsoft YaHei")  ; 淡紫
    
    g.BackColor := "050E1A"
    g.SetFont("s14 c60C8FF Bold", "Microsoft YaHei")
    
    ;=========================================================
    g.Add("Text", "xm ym", msg)
    DllCall("dwmapi\DwmSetWindowAttribute", "ptr", g.Hwnd,"uint", 33, "int*", 2, "uint", 4)  ; 圆角
    g.Show("NoActivate x0 y0")
    g.GetPos(, , &w, &h)
    g.Move(A_ScreenWidth // 2 - w // 2, A_ScreenHeight // 2 - h // 2)
    SetTimer(() => (g.Destroy(), g := ""), -duration)
}

; =============== 只能游戏里触发 ================
#HotIf WinActive("ahk_class UnityWndClass")
;饭团自己的号吃的体力药
$`:: {
    static busy := false
    if busy
        return
    busy := true

    BlockInput(true)
    try {
        Send "b"
        Sleep(780)
        MouseMove(1150, 68, 0)
        Click()
        Sleep(330)
        MouseMove(237, 264, 0)
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        Send "{Esc}"
    } finally {
        BlockInput(false)
    }
    KeyWait "``"
    busy := false
}

;我的号 夜兰吃的药
$-:: {
    static busy := false
    if busy
        return
    busy := true
    
    BlockInput(true)
    try {
        Send "b"
        ShowToast("✦ 正在吃>夜兰<的药", 1300)
        Sleep(780)
        MouseMove(1150, 68, 0)
        Click()
        Sleep(330)
        MouseMove(1200, 730, 0) ;第1个药的位置
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        MouseMove(430, 1000, 0) ;第2个药的位置
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        MouseMove(600, 1200, 0) ;第3个药的位置
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        MouseMove(824, 494, 0) ;第4个药的位置
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        Send "{Esc}"
    } finally {
        BlockInput(false)
    }
    KeyWait "-"
    busy := false
}

;我的号 火神吃的药
$=:: {
    static busy := false
    if busy
        return
    busy := true
    
    BlockInput(true)
    try {
        Send "b"
        ShowToast("✦ 正在吃>火神<的药", 1200)
        Sleep(780)
        MouseMove(1150, 68, 0)
        Click()
        Sleep(330)
        
        MouseMove(240, 730, 0) ;第1个药的位置
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        
        MouseMove(432, 1188, 0) ;第2个药的位置
        Click()
        Sleep(32)
        MouseMove(2218, 1500, 0)
        Click()
        Sleep(20)
        
        Send "{Esc}"
    } finally {
        BlockInput(false)
    }
    KeyWait "="
    busy := false
}

#HotIf
; =============================================

F4:: {
    Run('"' . A_AhkPath . '" "' . A_ScriptDir . "\..\Main.ahk" . '"')
    ExitApp
}

#SuspendExempt True
F3:: {
    Suspend
    ShowToast(A_IsSuspended ? "脚本已暂停" : "脚本已开启", 2000)
}
#SuspendExempt False