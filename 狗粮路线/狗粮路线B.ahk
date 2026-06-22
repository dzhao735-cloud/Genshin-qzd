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
            Sleep(420)
            MouseMove(2300,1500,0)
            Click()
            Sleep(20)
            MouseMove(2000,388,0)
            Click()
            Sleep(250)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            MouseMove(407,1231,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(80)
            MouseMove(407,1231,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            MouseMove(1695,1543,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1695,1543,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1695,1543,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(330)
            MouseMove(2300,1500,0)
            Click()
            Sleep(20)
            MouseMove(1900,251,0)
            Click()
            Sleep(530)
            SendInputDrag(1007, 1013, 1343, 199, 300)
            MouseMove(745,1499,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(882,1197,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(882,1197,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 4) {
            Sleep(280)
            MouseMove(568,948,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(568,948,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(568,948,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 5) {
            Sleep(280)
            MouseMove(873,491,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(873,491,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(873,491,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 6) {
            Sleep(420)
            SendInputDrag(1266,993,1449,388,300)
            MapMinimize()
            MouseMove(1231,1389,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1231,1389,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1231,1389,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 7) {
            Sleep(330)
            MouseMove(60,927,0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            MouseMove(1849,1088,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1600,1550,0)
            Click()

            Sleep(50)
            MouseMove(1849,1088,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 8) {
            Sleep(280)
            MouseMove(207,1249,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(207,1249,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(207,1249,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 9) {
            Sleep(280)
            MouseMove(477,432,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(477,432,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(477,432,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 10) {
            Sleep(340)
            MouseMove(2300,1500,0)
            Click()
            Sleep(20)
            MouseMove(1900,525,0)
            Click()
            Sleep(540)
            SendInputDrag(1367, 305, 1355, 1263, 400)
            MouseMove(1344,164,0)
            Sleep(20)
	        MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1344,164,0)
            Click()
            Sleep(20)
	        MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1344,164,0)
            Click()
            Sleep(20)
	        MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 11) {
            Sleep(280)
            MouseMove(1153,1396,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1153,1396,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1153,1396,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 12) {
            Sleep(420)
            SendInputDrag(1401, 1185, 1276, 451, 400)
	        MouseMove(60,666,0)
            Click()
            Sleep(20)
            MouseMove(1649,1489,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1649,1489,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1649,1489,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 13) {
            Sleep(420)
            SendInputDrag(1826,1178,818,425,230)
            MouseMove(60,666,0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            MouseMove(1832,893,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1600,1550,0)
            Click()

            Sleep(50)
            MouseMove(1832,893,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 14) {
            Sleep(350)
            MapMaximize()
            SendInputDrag(614,1276,2330,179,600)
            MouseMove(60,666,0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            Sleep(170)
            MouseMove(1273,1014,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1273,1014,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 15) {
            Sleep(350)
            MapMaximize()
            SendInputDrag(1386,1389,1171,34,200)
            MouseMove(60,666,0)
            Loop 2 {
                Click()
                Sleep(32)
            }
            Sleep(170)
            MouseMove(1655,1338,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1655,1338,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 16) {
            Sleep(280)
            MouseMove(1406,956,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1406,956,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1406,956,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 17) {
            Sleep(280)
            MouseMove(1420,749,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1420,749,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1420,749,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 18) {
            Sleep(280)
            MouseMove(1380,739,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1380,739,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1380,739,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()
        }
        else if (pointIndex == 19) {
            Sleep(280)
            MouseMove(1265,869,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(50)
            MouseMove(1265,869,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
            Click()

            Sleep(100)
            MouseMove(1265,869,0)
            Click()
            Sleep(20)
            MouseMove(2300,1500,0)
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