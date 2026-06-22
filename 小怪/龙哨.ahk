#Include "..\lib.ahk"

maxPoints := 19
#HotIf WinActive("ahk_class UnityWndClass")
$Tab:: {
    global pointIndex, maxPoints
    static busy := false
    if busy
        return
    busy := true
    BlockInput(true)
    try {
        OpenMapQuick(pointIndex)
        if (pointIndex == 1) {
            Sleep(360)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            MouseMove(1036, 1219, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1036, 1219, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            MouseMove(2118, 1019, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2118, 1019, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2118, 1019, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            MouseMove(1450, 522, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1450, 522, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1450, 522, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            MouseMove(1490, 268, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1490, 268, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1490, 268, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(350)
            MouseMove(60, 666, 0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            MouseMove(2174, 971, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2174, 971, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(280)
            MouseMove(1209, 804, 0)
            Click()
            Sleep(220)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1209, 804, 0)
            Click()
            Sleep(220)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1209, 804, 0)
            Click()
            Sleep(220)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(350)
            MouseMove(60, 927, 0)
            Click()
            Sleep(20)
            MouseMove(1832, 337, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1832, 337, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(280)
            MouseMove(2278, 1005, 0)
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1530, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2278, 1005, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1530, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(2278, 1005, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 9) {
            Sleep(280)
            MouseMove(1073, 531, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1073, 531, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1073, 531, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 10) {
            Sleep(280)
            MouseMove(1150, 214, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1150, 214, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1150, 214, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 11) {
            Sleep(280)
            MouseMove(1036, 990, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1036, 990, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1036, 990, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 12) {
            Sleep(280)
            MouseMove(934, 564, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(934, 564, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(934, 564, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 13) {
            Sleep(280)
            MouseMove(1027, 768, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1027, 768, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1027, 768, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 14) {
            Sleep(280)
            MouseMove(643, 1012, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(643, 1012, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(643, 1012, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 15) {
            Sleep(350)
            MouseMove(60, 666, 0)
            Click()
            Sleep(20)
            MouseMove(1420, 1202, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1180, 752, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 16) {
            Sleep(340)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(2300, 511, 0)
            Click()
            Sleep(90)
            MouseMove(60, 927, 0)
            Click()
            Sleep(32)
            MouseMove(138, 492, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(70)
            MouseMove(138, 492, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(138, 492, 0)
            Click()
            Sleep(580)
            MouseMove(1821, 1117, 0)
            Click()
            Sleep(20) 
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 17) {
            Sleep(280)
            MouseMove(1642, 475, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1642, 475, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1642, 475, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 18) {
            Sleep(280)
            MouseMove(1289, 0, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1289, 0, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1289, 0, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 19) {
            Sleep(280)
            MouseMove(669, 370, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(669, 370, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(669, 370, 0)
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
        ButtonsUp()
        BlockInput(false)
    }
    KeyWait "Tab"
    busy := false
}
#HotIf