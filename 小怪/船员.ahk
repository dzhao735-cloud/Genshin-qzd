#Include "..\lib.ahk"

maxPoints := 8
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
            ShowClickMark(1900, 1599)
            MouseMove(1900, 1599, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(40)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(110)
            MouseMove(1900, 1599, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(330)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(1900, 511, 0)
            Click()
            Sleep(200)
            ShowClickMark(1561, 1357)
            MouseMove(1561, 1357, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1561, 1357, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            ShowClickMark(1039, 734)
            MouseMove(1039, 734, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1039, 734, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1039, 734, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            ShowClickMark(1079, 535)
            MouseMove(1079, 535, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1079, 535, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1079, 535, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(280)
            ShowClickMark(1691, 1507)
            MouseMove(1691, 1507, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1691, 1507, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1691, 1507, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(280)
            ShowClickMark(1259, 823)
            MouseMove(1259, 823, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1259, 823, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1259, 823, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(280)
            ShowClickMark(2248, 630)
            MouseMove(2248, 630, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2248, 630, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2248, 630, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(330)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(1900, 511, 0)
            Click()
            Sleep(170)
            ShowClickMark(2186, 749)
            MouseMove(2186, 749, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(32)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(32)
            MouseMove(2186, 749, 0)
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