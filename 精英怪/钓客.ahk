#Include "..\lib.ahk"

maxPoints := 3
#HotIf WinActive("ahk_class UnityWndClass")
$Tab:: {
    global pointIndex, maxPoints
    static busy := false
    if busy
        return
    busy := true
    BlockInput(true)
    try {
        Send("{Enter}")
        Sleep(InStr(",1,", "," pointIndex ",") ? 120 : 50)
        MouseMove(226, 170, 0)
        Send("{Escape}")
        Sleep(40)
        Click()
        Send "m"
        if (pointIndex == 1) {
            Sleep(360)
            MouseMove(53, 666, 0)
            Sleep(20)
            Click("Down")
            Sleep(24)
            MouseMove(66, 666, 0)
            Sleep(24)
            Click("Up")
            Sleep(24)
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            ShowClickMark(845, 805)
            MouseMove(845, 805, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(130)
            MouseMove(845, 805, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            ShowClickMark(1171, 826)
            MouseMove(1171, 826, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1171, 826, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1171, 826, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            ShowClickMark(1195, 776)
            MouseMove(1195, 776, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1195, 776, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1195, 776, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
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