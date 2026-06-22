#Include "..\lib.ahk"

maxPoints := 3
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
            MouseMove(1181, 816, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(130)
            MouseMove(1181, 816, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 2) {
            Sleep(280)
            MouseMove(870, 1368, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(870, 1368, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(100)
            MouseMove(870, 1368, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()
        }
        else if (pointIndex == 3) {
            Sleep(280)
            MouseMove(1738, 847, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1738, 847, 0)
            Click()
            Sleep(20)
            MouseMove(2300, 1500, 0)
            Click()

            Sleep(50)
            MouseMove(1600, 1550, 0)
            Click()

            Sleep(50)
            MouseMove(1738, 847, 0)
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