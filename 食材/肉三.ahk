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
        OpenMapQuick(pointIndex)
        if (pointIndex == 1) {
            Sleep(390)
            MapMinimize(28)
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            SendInputDrag(1366,1462,1253,681,600)
            ShowClickMark(1332, 1267)
            MouseMove(1332, 1267, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(80)
            MouseMove(1332, 1267, 0)
            Click()
            Sleep(80)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(420)
            SendInputDrag(1559,1514,1004,24,700)
            ShowClickMark(1529, 1572)
            MouseMove(1529, 1572, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1529, 1572, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1529, 1572, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            ShowClickMark(1862, 444)
            MouseMove(1862, 444, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1250, 1000, 0)
            Click()

            Sleep(50)
            MouseMove(1862, 444, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1250, 1000, 0)
            Click()

            Sleep(50)
            MouseMove(1862, 444, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            ShowClickMark(1605, 1374)
            MouseMove(1605, 1374, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1605, 1374, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1605, 1374, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(280)
            ShowClickMark(2549, 168)
            MouseMove(2549, 168, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1300, 1300, 0)
            Click()

            Sleep(50)
            MouseMove(2549, 168, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1300, 1300, 0)
            Click()

            Sleep(50)
            MouseMove(2549, 168, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(280)
            ShowClickMark(1553, 1160)
            MouseMove(1553, 1160, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1553, 1160, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1553, 1160, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(280)
            ShowClickMark(490, 304)
            MouseMove(490, 304, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(490, 304, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(490, 304, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(420)
            SendInputDrag(1341,601,1103,1241,400)
            ShowClickMark(1170, 278)
            MouseMove(1170, 278, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
    
            Sleep(50)
            MouseMove(1170, 278, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(100)
            MouseMove(1170, 278, 0)
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