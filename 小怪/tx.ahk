#Include "..\lib.ahk"

maxPoints := 17
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
            Sleep(390)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            MouseMove_Click_Sleep(1522, 1516, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 2) {
            Sleep(330)
            MouseMove_Click_Sleep(2300, 1500, 24)
            MouseMove_Click_Sleep(1932, 648, 120)

            MouseMove_Click_Sleep(1191, 394, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1191, 394, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 3) {
            Sleep(280)
            MouseMove_Click_Sleep(1642, 344, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1642, 344, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 4) {
            Sleep(340)
            MouseMove_Click_Sleep(1130, 690, 20)
            Loop 3 {
                Send "f"
                Sleep(30)
            }
            Sleep(470)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 5) {
            Sleep(340)
            MouseMove_Click_Sleep(1241, 781, 20)
            Loop 3 {
                Send "f"
                Sleep(30)
            }
            Sleep(470)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 6) {
            Sleep(280)
            MouseMove_Click_Sleep(1179, 819, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1179, 819, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 7) {
            Sleep(280)
            MouseMove_Click_Sleep(1217, 877, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1217, 877, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 8) {
            Sleep(280)
            MouseMove_Click_Sleep(1235, 872, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1235, 872, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 9) {
            Sleep(280)
            MouseMove_Click_Sleep(1165, 548, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1165, 548, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 10) {
            Sleep(280)
            MouseMove_Click_Sleep(1472, 391, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1472, 391, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 11) {
            Sleep(330)
            MouseMove_Click_Sleep(1350, 800, 20)
            MouseMove_Click_Sleep(2300, 1500, 110)

            MouseMove_Click_Sleep(1278, 820, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 12) {
            Sleep(330)
            MouseMove_Click_Sleep(1515, 989, 20)
            MouseMove_Click_Sleep(2300, 1500, 110)

            MouseMove_Click_Sleep(1589, 971, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 13) {
            Sleep(280)
            MouseMove_Click_Sleep(1204, 718, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1204, 718, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 14) {
            Sleep(280)
            MouseMove_Click_Sleep(1455, 728, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1455, 728, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 15) {
            Sleep(280)
            MouseMove_Click_Sleep(1327, 1022, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1327, 1022, 20)
            MouseMove_Click_Sleep(2300, 1500)

        }
        else if (pointIndex == 16) {
            Sleep(340)
            MouseMove_Click_Sleep(1246, 1005, 24)
            Loop 3 {
                Send "f"
                Sleep(30)
            }
            Sleep(470)
            MouseMove_Click_Sleep(1809, 1141, 90)
            MouseMove_Click_Sleep(2300, 1500)

        }
        else if (pointIndex == 17) {
            Sleep(340)
            MouseMove_Click_Sleep(1225, 779, 24)
            Loop 3 {
                Send "f"
                Sleep(30)
            }
            Sleep(470)
            MouseMove_Click_Sleep(1809, 1141, 90)
            MouseMove_Click_Sleep(2300, 1500)
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