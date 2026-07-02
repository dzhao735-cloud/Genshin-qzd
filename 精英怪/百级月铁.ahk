#Include "..\lib.ahk"

maxPoints := 2
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
            MapMaximize()
            Sleep(180)
            SendInputDrag(315, 851, 2092, 847, 200)
            SendInputDrag(315, 851, 2092, 847, 200)
            MouseMove(60,666,0)
            Loop 3 {
                Click()
                Sleep(32)
            }
            Sleep(170)
            MouseMove_Click_Sleep(529, 1102, 20)
            MouseMove_Click_Sleep(2249, 1503, 40)
            MouseMove_Click_Sleep(529, 1102, 20)
            MouseMove_Click_Sleep(2249, 1503)
        }
        else if (pointIndex == 2) {
            Sleep(330)
            MouseMove_Click_Sleep(909, 803, 580)
            MouseMove_Click_Sleep(1809, 1141, 20)
            MouseMove_Click_Sleep(2249, 1503)
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