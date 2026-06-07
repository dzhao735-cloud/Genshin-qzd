#Include "..\lib.ahk"

maxPoints := 12
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
            ShowClickMark(871, 551)
            MouseMove(871, 551, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(130)
            MouseMove(871, 551, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            ShowClickMark(1130, 1003)
            MouseMove(1130, 1003, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1130, 1003, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1130, 1003, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            ShowClickMark(1404, 798)
            MouseMove(1404, 798, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(50)
            MouseMove(1404, 798, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1404, 798, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(360)
            MouseMove(60, 666, 0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1178, 905)
            MouseMove(1178, 905, 0)
            Click()
            Sleep(220)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1178, 905, 0)
            Click()
            Sleep(220)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1178, 905, 0)
            Click()
            Sleep(220)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(330)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(1929, 503, 0)
            Click()
            Sleep(170)
            MouseMove(60, 927, 0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1783, 275)
            MouseMove(1783, 275, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1783, 275, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(280)
            ShowClickMark(1462, 256)
            MouseMove(1462, 256, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1462, 256, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1462, 256, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(280)
            ShowClickMark(785, 655)
            MouseMove(785, 655, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(785, 655, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(785, 655, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(330)
            MouseMove(60, 666, 0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1062, 1581)
            MouseMove(1062, 1581, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1062, 1581, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1062, 1581, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 9) {
            Sleep(280)
            ShowClickMark(251, 1060)
            MouseMove(251, 1060, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(251, 1060, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(251, 1060, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 10) {
            Sleep(280)
            ShowClickMark(1443, 986)
            MouseMove(1443, 986, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1443, 986, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1443, 986, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 11) {
            Sleep(280)
            ShowClickMark(1782, 898)
            MouseMove(1782, 898, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1782, 898, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()
            
            Sleep(50)
            MouseMove(1782, 898, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 12) {
            Sleep(280)
            ShowClickMark(778, 958)
            MouseMove(778, 958, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(778, 958, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(778, 958, 0)
            Click()
            Sleep(80)
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