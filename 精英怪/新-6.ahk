#Include "..\lib.ahk"
#Include "..\检测圣遗物\圣遗物拾取模块.ahk"

maxPoints := 28
AP_Start()
#HotIf WinActive("ahk_class UnityWndClass")
$Tab:: {
    global pointIndex, maxPoints
    static busy := false
    if busy
        return
    busy := true
    BlockInput(true)
    try {
        OpenMapQuick(pointIndex, ,",1,22,26,")
        if (pointIndex == 1) {
            Sleep(360)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            MouseMove_Click_Sleep(1425, 790, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1425, 790, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 2) {
            Sleep(330)
            ClickRegion(5, 50)
            loop 2{
                MouseMove_Click_Sleep(759, 1351, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 3) {
            Sleep(330)
            ClickRegion(5, 50)
            loop 2{
                MouseMove_Click_Sleep(759, 1351, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 4) {
            Sleep(380)
            SendInputDrag(2216, 1251, 761, 551, 700)

            MouseMove_Click_Sleep(2397, 1417, 20)
            MouseMove_Click_Sleep(2300, 1500, 32)

            MouseMove_Click_Sleep(1531, 1207)
        }
        else if (pointIndex == 5) {
            Sleep(360)
            MouseMove_Click_Sleep(2455, 641, 20)
            Loop 3 {
                Send "f"
                Sleep(30)
            }
            Sleep(470)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 6) {
            Sleep(300)
            loop 2{
                MouseMove_Click_Sleep(653, 154, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 7) {
            Sleep(330)
            ClickRegion(4, 250)
            MouseMove_Click_Sleep(60, 666, 20)

            loop 2 {
                MouseMove_Click_Sleep(66, 560, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 8) {
            Sleep(330)
            MouseMove_Click_Sleep(60, 927, 20)
            loop 2 {
                MouseMove_Click_Sleep(222, 1016, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 9) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(2190, 925, 20)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1300, 1150, 50)
            }
        }
        else if (pointIndex == 10) {
            Sleep(380)
            SendInputDrag(1310, 1316, 1282, 521, 600)
            loop 2 {
                MouseMove_Click_Sleep(1588, 1534, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 11) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(2181, 285, 20)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1300, 1150, 50)
            }
        }
        else if (pointIndex == 12) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(2018, 332, 20)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1000, 1350, 50)
            }
        }
        else if (pointIndex == 13) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(1417, 530, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 14) { ;去稻妻
            Sleep(340)
            ClickRegion(3, 200)
            MouseMove_Click_Sleep(206, 1531, 580)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 15) {
            Sleep(190)
            MouseMove_Click_Sleep(1909, 1172, 580)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1600, 1550, 50)

            MouseMove_Click_Sleep(1733, 1145, 580)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 16) { ;去至东
            Sleep(340)
            ClickRegion(8, 150)
            loop 2 {
                MouseMove_Click_Sleep(294, 969, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 17) {
            Sleep(340)
            MouseMove_Click_Sleep(1804, 1194, 80)
            loop 4 {
                Send "f"
                Sleep(30)
            }
            Sleep(380)
            MouseMove_Click_Sleep(1809, 1141, 80)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 18) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(1473, 960, 8)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 19) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(1702, 790, 60)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 20) {
            Sleep(340)
            ClickRegion(8, 150)
            loop 2 {
                MouseMove_Click_Sleep(2053, 873, 20)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1538, 1182, 50)
            }
        }
        else if (pointIndex == 21) {
            Sleep(340)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(2300, 813, 0)
            Click()
            Sleep(200)
            MapMaximize()
            MouseMove(1280, 800, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(50)
            MouseMove(1280, 800, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1280, 800, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 22) {
            Sleep(250)
            MouseMove(1254, 1061, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1254, 1061, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1254, 1061, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1254, 1061, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 23) {
            Sleep(250)
            MouseMove(1379, 1141, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1379, 1141, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1379, 1141, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1379, 1141, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 24) {
            Sleep(250)
            MouseMove(1684, 899, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1684, 899, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1684, 899, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1684, 899, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 25) {
            Sleep(330)
            MouseMove(2300, 1500, 0)
            Click()
            Sleep(32)
            MouseMove(1900, 808, 0)
            Click()
            Sleep(180)
            MouseMove(986, 501, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
            
            Sleep(50)
            MouseMove(986, 501, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(986, 501, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 26) {
            Sleep(250)
            MouseMove(2119, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(32)
            MouseMove(1350, 500, 0)
            Click()

            Sleep(50)
            MouseMove(2119, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(32)
            MouseMove(1350, 500, 0)
            Click()

            Sleep(50)
            MouseMove(2119, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(80)
            MouseMove(1350, 500, 0)
            Click()

            Sleep(100)
            MouseMove(2119, 891, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 27) {
            Sleep(250)
            MouseMove(1384, 1031, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1384, 1031, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1384, 1031, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(1384, 1031, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 28) {
            Sleep(250)
            MouseMove(725, 1364, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(725, 1364, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(725, 1364, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(725, 1364, 0)
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