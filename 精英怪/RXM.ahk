#Include "..\lib.ahk"

maxPoints := 10
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
        Sleep(InStr(",1,10,", "," pointIndex ",") ? 120 : 50)
        MouseMove(226, 170, 0)
        Send("{Escape}")
        Sleep(40)
        Click()
        Send "m"
        if (pointIndex == 1) {
            Sleep(370)
            MapMinimize(28)
            MouseMove(60, 927, 0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            ShowClickMark(1002, 506)
            MouseMove(1002, 506, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(80)
            MouseMove(1002, 506, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            ShowClickMark(1101, 938)
            MouseMove(1101, 938, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1101, 938, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1101, 938, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            ShowClickMark(927, 1143)
            MouseMove(927, 1143, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(927, 1143, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(927, 1143, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            ShowClickMark(679, 537)
            MouseMove(679, 537, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(679, 537, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(679, 537, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(280)
            ShowClickMark(1224, 871)
            MouseMove(1224, 871, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1224, 871, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1224, 871, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(340)
            MouseMove(60, 927, 0)
            Click()
            Sleep(32)
            SendInputDrag(427, 1251, 1425, 636, 600)
            ShowClickMark(163, 1377)
            MouseMove(163, 1377, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(80)
            MouseMove(163, 1377, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(280)
            ShowClickMark(1091, 530)
            MouseMove(1091, 530, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1091, 530, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1091, 530, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(280)
            ShowClickMark(918, 65)
            MouseMove(918, 65, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(918, 65, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(918, 65, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 9) {
            Sleep(330)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(2324, 958, 0)
            Click()
            Sleep(200)
            ShowClickMark(850, 1233)
            MouseMove(850, 1233, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(850, 1233, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(850, 1233, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 10) {
            Sleep(280)
            ShowClickMark(2191, 891)
            MouseMove(2191, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2000, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2191, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2000, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2191, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2000, 1500, 0)
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