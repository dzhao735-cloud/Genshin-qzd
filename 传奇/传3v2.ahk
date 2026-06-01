#Include "..\lib.ahk"

#HotIf WinActive("ahk_class UnityWndClass")
$Tab:: {
    static busy := false
    if busy
        return
    busy := true
    static pointIndex := 1
    static maxPoints := 3
    SetCapsLockState "AlwaysOff"
    BlockInput(true)
    try {
        if (pointIndex == 1) {
            Send("{Alt Down}")
            Sleep(170)
            MouseMove(230, 166, 0)
            Click()
            Send "m"
            Send("{Alt Up}")

            Sleep(300)
            MouseMove(60, 927, 0)
            Loop 4 {
                Click()
                Sleep(32)
            }
            MouseMove(60, 666, 0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1330, 987)
            MouseMove(1330, 987, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
    
            Sleep(150)
            MouseMove(1330, 987, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(90)
            MouseMove(1330, 987, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Send("{F1}")
            Sleep(450)
            MouseMove(395, 809, 0)
            Click()
            Sleep(200)
            MouseMove(664, 765, 0)
            Click()
            Sleep(50)
            MouseMove(1932, 1202, 0)
            Click()
            Sleep(900)
            MouseMove(1404, 1268, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Send("{F2}")
            Sleep(350)
            MouseMove(2200, 1500, 0)
            Click()
            Sleep(50)
            MouseMove(2200, 1500, 0)
            Click()
            Sleep(50)
            MouseMove(2200, 1500, 0)
            Click()
            Sleep(50)
            MouseMove(2200, 1500, 0)
            Click()
            Sleep(150)
            MouseMove(2200, 1500, 0)
            Click()
        }
        pointIndex++
        if (pointIndex > maxPoints) {
            pointIndex := 1
            ShowToast("✦ 路线结束，已回到点位 1 (起点)")
        } else {
            ShowToast("✦ 已执行点位 " (pointIndex - 1) " --> 准备点位 " pointIndex)
        }
    } finally {
        Send "{LButton Up}"
        Send "{RButton Up}"
        Send "{w up}{a up}{s up}{d up}"
        Sleep(50)
        BlockInput(false)
    }
    KeyWait "Tab"
    busy := false
}
#HotIf