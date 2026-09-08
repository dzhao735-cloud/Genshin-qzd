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
            Sleep(360)
            MapMinimize()
            MouseMove(60, 927, 0)
            Loop 3 {
                Click()
                Sleep(36)
            }
            MouseMove_Click_Sleep(1352, 396, 20)
            MouseMove_Click_Sleep(2300, 1500)
        }
        else if (pointIndex == 2) {
            Sleep(300)
            loop 3 {
                MouseMove_Click_Sleep(1282, 844, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 3) {
            Sleep(320)
                MouseMove_Click_Sleep(1583, 997, 80)
                MouseMove_Click_Sleep(2300, 1500, 50)

                MouseMove_Click_Sleep(1583, 997, 80)
                send 'f'
                Sleep(25)
                send 'f'
                Sleep(25)
                send 'f'
        }
        else if (pointIndex == 4) {
            Sleep(300)
            loop 3 {
                MouseMove_Click_Sleep(1269, 1077, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 5) {
            Sleep(300)
            loop 3 {
                MouseMove_Click_Sleep(1553, 679, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 6) {
            Sleep(300)
            loop 3 {
                MouseMove_Click_Sleep(1528, 587, 20)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
        }
        else if (pointIndex == 7) {
            Sleep(320)
            loop 2 {
                MouseMove_Click_Sleep(1527, 911, 80)
                MouseMove_Click_Sleep(2300, 1500, 50)
            }
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