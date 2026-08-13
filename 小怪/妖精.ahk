#Include "..\lib.ahk"

maxPoints := 7
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
            Sleep(380)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            MouseMove_Click_Sleep(1649, 861, 80)
            loop 4 {
                Send "f"
                Sleep(30)
            }
            Sleep(380)
            MouseMove_Click_Sleep(1809, 1141, 80)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 2) {
            Sleep(300)
            MouseMove_Click_Sleep(1670, 849, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1670, 849, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 3) {
            Sleep(300)
            MouseMove_Click_Sleep(1267, 902, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1267, 902, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 4) {
            Sleep(300)
            MouseMove_Click_Sleep(1494, 866, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1494, 866, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 5) {
            Sleep(300)
            MouseMove_Click_Sleep(1412, 910, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1412, 910, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 6) {
            Sleep(300)
            MouseMove_Click_Sleep(1371, 779, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1371, 779, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 7) {
            Sleep(300)
            MouseMove_Click_Sleep(1647, 511, 20)
            MouseMove_Click_Sleep(2300, 1500, 50)

            MouseMove_Click_Sleep(1647, 511, 20)
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