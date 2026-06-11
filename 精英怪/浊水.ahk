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
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1750, 187)
            MouseMove(1750, 187, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1380, 860, 0)
            Click()

            Sleep(120)
            MouseMove(1750, 187, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            ShowClickMark(1372, 653)
            MouseMove(1372, 653, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1372, 653, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1372, 653, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            ShowClickMark(1664, 440)
            MouseMove(1664, 440, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1664, 440, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1664, 440, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            ShowClickMark(1692, 1545)
            MouseMove(1692, 1545, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1692, 1545, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1692, 1545, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(280)
            ShowClickMark(1300, 1159)
            MouseMove(1300, 1159, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1300, 1159, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1300, 1159, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(280)
            ShowClickMark(1569, 1263)
            MouseMove(1569, 1263, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1569, 1263, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1569, 1263, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(280)
            ShowClickMark(862, 1113)
            MouseMove(862, 1113, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(862, 1113, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(862, 1113, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(280)
            ShowClickMark(1371, 1093)
            MouseMove(1371, 1093, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1371, 1093, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1371, 1093, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 9) {
            Sleep(280)
            ShowClickMark(1030, 1193)
            MouseMove(1030, 1193, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1030, 1193, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1030, 1193, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 10) {
            Sleep(280)
            ShowClickMark(1158, 924)
            MouseMove(1158, 924, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1158, 924, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1158, 924, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 11) {
            Sleep(280)
            ShowClickMark(914, 524)
            MouseMove(914, 524, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(914, 524, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(914, 524, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 12) {
            Sleep(420)
            SendInputDrag(1281, 1518, 1333, 339, 700)
            ShowClickMark(1110, 1434)
            MouseMove(1110, 1434, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1110, 1434, 0)
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