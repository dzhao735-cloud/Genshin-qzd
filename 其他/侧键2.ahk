#Requires AutoHotkey v2.0
#SingleInstance Force
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

#HotIf WinActive("ahk_class UnityWndClass")
;火神双码头
global fireOn := false
global scriptBusy := false
XButton2:: {
    global fireOn
    fireOn := !fireOn
    if fireOn {
        SetTimer FireLoop, -1
    } else {
        fireOn := false
        Send "{LButton Up}{RButton Up}"
    }
}
FireLoop() {
    global fireOn, scriptBusy
    while fireOn {
        if scriptBusy {
            Sleep 100
            continue
        }
        Send "{LButton Down}"
        Sleep 205
        Send "{RButton Down}"
        Sleep 200
        Send "{LButton Up}"
        Sleep 2
        Send "{RButton Up}"
        Sleep 2
        Send "{LButton Down}"
        Sleep 160
        Send "{RButton Down}"
        Sleep 110
        Send "{RButton Up}"
        Sleep 1050
        Send "{LButton Up}"
        Sleep 560
    }
    Send "{LButton Up}{RButton Up}"
}
#HotIf