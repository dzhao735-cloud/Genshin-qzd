#Include "..\lib.ahk"

maxPoints := 16
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
            Sleep(420)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 511, 0)
            Click()
            Sleep(250)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1749, 1000)
            MouseMove(1749, 1000, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(140)
            MouseMove(1749, 1000, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            ShowClickMark(760, 1503)
            MouseMove(760, 1503, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(760, 1503, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(760, 1503, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(420)
            SendInputDrag(998, 193, 1382, 1599, 300)
            ShowClickMark(991, 11)
            MouseMove(991, 11, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(991, 11, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(991, 11, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            ShowClickMark(1799, 809)
            MouseMove(1799, 809, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1799, 809, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1799, 809, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(280)
            ShowClickMark(861, 129)
            MouseMove(861, 129, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(861, 129, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(861, 129, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(420)
            SendInputDrag(113, 800, 2493, 703, 250)
            ShowClickMark(3, 579)
            MouseMove(3, 579, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(3, 579, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(3, 579, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(280)
            ShowClickMark(1155, 799)
            MouseMove(1155, 799, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1155, 799, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1155, 799, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(280)
            ShowClickMark(1283, 186)
            MouseMove(1283, 186, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1283, 186, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1283, 186, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 9) {
            Sleep(280)
            ShowClickMark(1166, 823)
            MouseMove(1166, 823, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1166, 823, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1166, 823, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 10) {
            Sleep(280)
            ShowClickMark(825, 778)
            MouseMove(825, 778, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(825, 778, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(825, 778, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 11) {
            Sleep(280)
            ShowClickMark(1167, 904)
            MouseMove(1167, 904, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1167, 904, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1167, 904, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 12) {
            Sleep(280)
            ShowClickMark(1692, 1360)
            MouseMove(1692, 1360, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1692, 1360, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1692, 1360, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 13) {
            Sleep(280)
            ShowClickMark(1237, 917)
            MouseMove(1237, 917, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1237, 917, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1237, 917, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 14) {
            Sleep(280)
            ShowClickMark(1424, 819)
            MouseMove(1424, 819, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1424, 819, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1424, 819, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 15) {
            Sleep(280)
            ShowClickMark(1163, 600)
            MouseMove(1163, 600, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1163, 600, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1163, 600, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 16) {
            Sleep(280)
            ShowClickMark(1180, 752)
            MouseMove(1180, 752, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1180, 752, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1180, 752, 0)
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