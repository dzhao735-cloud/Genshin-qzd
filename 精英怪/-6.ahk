#Include "..\lib.ahk"
#Include "..\检测圣遗物\圣遗物拾取模块.ahk"

maxPoints := 27
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
        OpenMapQuick(pointIndex, ,",1,21,25,")
        if (pointIndex == 1) {
            Sleep(390)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(24)
            }
            MouseMove_Click_Sleep(1425, 790, 16)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1425, 790, 16)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 2) {
            Sleep(370)
            ClickRegion(5, 170)
            loop 2 {
                MouseMove_Click_Sleep(759, 1351, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 3) {
            Sleep(370)
            ClickRegion(5, 150)
            loop 2{
                MouseMove_Click_Sleep(759, 1351, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 4) {
            Sleep(390)
            SendInputDrag(2216, 1251, 761, 551, 700)

            MouseMove_Click_Sleep(2397, 1417, 16)
            MouseMove_Click_Sleep(2300, 1500, 32)

            MouseMove_Click_Sleep(1531, 1207)
        }
        else if (pointIndex == 5) {
            Sleep(390)
            MouseMove_Click_Sleep(2448, 633, 16)
            Loop 4 {
                Send "f"
                Sleep(20)
            }
            Sleep(300)
            MouseMove_Click_Sleep(1809, 1141, 16)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 6) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(653, 154, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 7) { 
            Sleep(370) 
            ClickRegion(4, 150)
            loop 2 {
                MouseMove_Click_Sleep(273, 1109, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 8) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(189, 640, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 9) {
            Sleep(390)
            SendInputDrag(2205, 1403, 1010, 397, 600)
            MouseMove_Click_Sleep(2016, 1519, 16)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 10) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(2178, 290, 16)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1305, 1215, 50)
            }
        }
        else if (pointIndex == 11) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(2024, 338, 16)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1495, 450, 50)
            }
        }
        else if (pointIndex == 12) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(1420, 535, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 13) { ;去稻妻
            Sleep(370)
            ClickRegion(3, 200)
            MouseMove_Click_Sleep(206, 1531, 400)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 14) {
            Sleep(390)
            MouseMove_Click_Sleep(1909, 1172, 580)
            MouseMove_Click_Sleep(1809, 1141, 16)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1600, 1550, 50)

            MouseMove_Click_Sleep(1733, 1145, 580)
            MouseMove_Click_Sleep(1809, 1141, 16)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 15) { ;去至东
            Sleep(370)
            ClickRegion(8, 150)
            loop 2 {
                MouseMove_Click_Sleep(294, 969, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 16) {
            Sleep(370)
            MouseMove_Click_Sleep(1811, 1180, 80)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 17) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(1468, 954, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 18) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(1691, 777, 16)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 19) {
            Sleep(330)
            loop 2 {
                MouseMove_Click_Sleep(2215, 243, 16)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1552, 507, 50)
            }
        }
        else if (pointIndex == 20) {
            Sleep(370)
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
        else if (pointIndex == 21) {
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
        else if (pointIndex == 22) {
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
        else if (pointIndex == 23) {
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
        else if (pointIndex == 24) {
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
        else if (pointIndex == 25) {
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
        else if (pointIndex == 26) {
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
        else if (pointIndex == 27) {
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