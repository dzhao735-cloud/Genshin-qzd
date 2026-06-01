;自己的脚本与此脚本的区别：
; tab键触发(不是caps lock)
;最低sleep为20
;sleep高很多
;每个脚本多一个功能`

#Requires AutoHotkey v2.0
#SingleInstance Force

LaunchRoute(filepath, *) {
    Run(A_ScriptDir "\" filepath)
    ExitApp()
}

categories := Map(
    "精英怪", [
        ["守护者", "精英怪\守护者.ahk"],
        ["KSY",   "精英怪\KSY.ahk"],
        ["RXM",   "精英怪\RXM.ahk"],
        ["山鼬",  "精英怪\山鼬.ahk"],
        ["魔像",  "精英怪\魔像.ahk"],
        ["深邃",  "精英怪\深邃.ahk"],
        ["使徒",  "精英怪\使徒.ahk"],
        ["役人",  "精英怪\役人.ahk"],
        ["钓客",  "精英怪\钓客.ahk"],
        ["浊水",  "精英怪\浊水.ahk"],
        ["-6",   "精英怪\-6.ahk"],
    ],
    "传奇", [
        ["传3", "传奇\传3v2.ahk"],
    ],
    "小怪", [
        ["发条", "小怪\发条.ahk"],
        ["龙哨", "小怪\龙哨.ahk"],
        ["船员", "小怪\船员.ahk"],
    ],
    "狗粮路线", [
        ["狗粮路线A", "狗粮路线\狗粮路线A.ahk"],
        ["狗粮路线B", "狗粮路线\狗粮路线B.ahk"],
    ],
    "食材", [
        ["肉三", "食材\肉三.ahk"],
    ],
)
catOrder := ["精英怪", "传奇", "小怪", "狗粮路线", "食材"]

myGui := Gui("+AlwaysOnTop -Resize", "原神锄地脚本")
myGui.BackColor := "1a1a2e"
myGui.SetFont("s13 cE0E0E0 w600", "Microsoft YaHei")
myGui.Add("Text", "x0 y0 w520 h50 +0x200 BackgroundTrans Center", "原神锄地启动器")
myGui.SetFont("s13 cE0E0E0 w400", "Microsoft YaHei")

yPos := 55
btnW := 150
btnH := 45
gap := 10
leftPad := 15

for _, catName in catOrder {
    routes := categories[catName]

    myGui.SetFont("s11 cFFD700 w700", "Microsoft YaHei")
    myGui.Add("Text", "x" leftPad " y" yPos " w490 h24 BackgroundTrans", catName)
    yPos += 28

    myGui.SetFont("s12 c1a1a2e w700", "Microsoft YaHei")
    xPos := leftPad
    colCount := 0
    maxCols := 3

    for _, route in routes {
        routeName := route[1]
        routePath := route[2]

        btn := myGui.Add("Button", "x" xPos " y" yPos " w" btnW " h" btnH, routeName)
        btn.OnEvent("Click", LaunchRoute.Bind(routePath))

        colCount++
        if (colCount >= maxCols) {
            colCount := 0
            xPos := leftPad
            yPos += btnH + gap
        } else {
            xPos += btnW + gap
        }
    }

    if (colCount > 0)
        yPos += btnH + gap

    yPos += 8
}

myGui.SetFont("s11 cAAAAAA w400", "Microsoft YaHei")
exitBtn := myGui.Add("Button", "x" leftPad " y" yPos " w490 h38", "退出")
exitBtn.OnEvent("Click", (*) => ExitApp())
yPos += 38 + 15

myGui.Show("w520 h" yPos)
myGui.OnEvent("Close", (*) => ExitApp())