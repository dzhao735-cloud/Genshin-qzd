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
            Sleep(360)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(36)
            }
            MouseMove_Click_Sleep(1388, 305, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 2) {
            Sleep(300)
            MouseMove_Click_Sleep(1433, 908, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1433, 908, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1433, 908, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 3) {
            Sleep(300)
            MouseMove_Click_Sleep(1587, 1000, 220)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1587, 1000, 220)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 4) {
            Sleep(300)
            MouseMove_Click_Sleep(1272, 1081, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1272, 1081, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1272, 1081, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 5) {
            Sleep(300)
            MouseMove_Click_Sleep(1555, 671, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1555, 671, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1555, 671, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 6) {
            Sleep(300)
            MouseMove_Click_Sleep(1524, 583, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1524, 583, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1524, 583, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 7) {
            Sleep(300)
            loop 2 {
                MouseMove_Click_Sleep(2253, 958, 20)
                MouseMove_Click_Sleep(2300, 1500, 32)

                MouseMove_Click_Sleep(1636, 1072, 50)
            }
        }
        else if (pointIndex == 8) {
            Sleep(320)
            ClickRegion(8, 150)
            MouseMove_Click_Sleep(1137, 1176, 220)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1137, 1176, 220)
            MouseMove_Click_Sleep(2300, 1500, 50)
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