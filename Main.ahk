#Requires AutoHotkey v2.0
#SingleInstance Force

; 弹界面时按住Alt(原神大世界要按Alt才出鼠标)，关界面/退出时松开
; 必须在 CheckUpdate() 之前初始化：更新弹窗会用到 g_altHeld
global g_altHeld := false

CheckUpdate()

LaunchRoute(filepath, *) {
    ReleaseAlt()   ; 启动路线前先松开Alt(否则新脚本会带着Alt按住的状态)
    Run(A_ScriptDir "\" filepath)
    ExitApp()
}

HoldAlt() {
    global g_altHeld
    if (!g_altHeld && WinExist("ahk_class UnityWndClass")) {   ; 只有原神在运行时才按
        Send("{Alt down}")
        g_altHeld := true
    }
}
ReleaseAlt() {
    global g_altHeld
    if (g_altHeld) {
        Send("{Alt up}")
        g_altHeld := false
    }
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
        ["百级月铁",   "精英怪\百级月铁.ahk"],
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
    "测试用", [
        ["双码头侧键1", "其他\侧键1.ahk"],
        ["双码头侧键2", "其他\侧键2.ahk"],
        ["双码头F10", "其他\F10.ahk"],
    ],
)
catOrder := ["精英怪", "传奇", "小怪", "狗粮路线", "食材", "测试用"]

myGui := Gui("+AlwaysOnTop -Resize +E0x08000000", "原神锄地脚本")  ; WS_EX_NOACTIVATE：点路线按钮也不抢焦点/不切回桌面
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

; =============== 以下为热键功能预览 ===============
myGui.Add("Text", "x535 y0 w2 h" yPos " Background404060")
myGui.SetFont("s12 cFFD700 w700", "Microsoft YaHei")
myGui.Add("Text", "x550 y10 w250 h24 BackgroundTrans", "热键功能预览")
myGui.SetFont("s11 cE0E0E0 w400", "Microsoft YaHei")
notes := "
(

Tab: 执行当前点位
←: 后退一个点位
→: 前进一个点位
F3: 暂停/开启脚本
F4: 重新选择路线
F7: 圣遗物自动拾取 (默认开启 且只对-6生效)
F12: 调整地图大小 (建议连按两次)

══════ 吃药功能 ══════
~/``: 回复体力药 (饭团)
F10: 恰 (小美) 背包里第2个和第3个的位置
-/—: 夜兰 (乆刄)
=/+: 火神 (乆刄)

)"
myGui.Add("Text", "x550 y40 w250 BackgroundTrans", notes)
myGui.Show("NoActivate w820 h" yPos)
HoldAlt()   ; 界面显示后按住Alt，让原神大世界露出鼠标，方便点按钮

myGui.OnEvent("Close", (*) => ExitApp())
OnExit((*) => ReleaseAlt())   ; 兜底：任何退出路径(退出按钮/关闭/异常)都松开Alt，防止卡键

CheckUpdate() {
    static base := "https://raw.githubusercontent.com/dzhao735-cloud/Genshin-qzd/main/"
    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", base "version.txt", false)
        whr.SetTimeouts(5000, 5000, 10000, 10000)
        whr.Send()
        remoteVer := Trim(whr.ResponseText)
    } catch {
        return
    }
    localVerFile := A_ScriptDir "\version.txt"
    localVer := FileExist(localVerFile) ? Trim(FileRead(localVerFile)) : "0"
    if (remoteVer = localVer || remoteVer = "")
        return
    if MsgNoActivate("发现新版本 v" remoteVer "  （当前 v" localVer ")`n是否立即更新?",
              "脚本更新", "YesNo") != "Yes"
        return
    try {
        whr.Open("GET", base "filelist.txt", false)
        whr.Send()
        fileList := whr.ResponseText
    } catch {
        MsgNoActivate("获取文件列表失败，请检查网络。", "更新失败")
        return
    }
    
    ; ===== 新增：统计需要下载的文件总数 =====
    totalFiles := 0
    for rawLine in StrSplit(fileList, "`n") {
        line := Trim(StrReplace(rawLine, "`r", ""))
        if (line != "" && SubStr(line, 1, 1) != ";" && line != "version.txt")
            totalFiles++
    }
    
    failed := []
    successCount := 0 ; 新增：成功下载的计数器
    
    for rawLine in StrSplit(fileList, "`n") {
        line := Trim(StrReplace(rawLine, "`r", ""))
        if (line = "" || SubStr(line, 1, 1) = ";")
            continue
        localPath := A_ScriptDir "\" StrReplace(line, "/", "\")
        SplitPath(localPath,, &dir)
        if (dir != "" && !FileExist(dir))
            DirCreate(dir)
        try {
            if (line = "version.txt")
                continue
                
            ; ===== 新增：在屏幕中央动态显示下载进度 =====
            currentProgress := successCount + failed.Length + 1
            ToolTip("正在全力同步中，请稍候...`n进度: (" currentProgress "/" totalFiles ")`n当前文件: " line, A_ScreenWidth/2 - 150, A_ScreenHeight/2)
            
            Download(base . EncodeUrl(line), localPath)
            successCount++
        } catch {
            failed.Push(line)
        }
    }
    
    ToolTip() ; ===== 新增：下载完成后，切断并移除屏幕中央的提示框 =====
    
    if (failed.Length > 0) {
        msg := ""
        for f in failed
            msg .= f "`n"
        MsgNoActivate("以下文件下载失败：`n" msg, "部分更新失败")
    } else {
        try {
            if FileExist(localVerFile)
                FileDelete(localVerFile)
            FileAppend(remoteVer, localVerFile, "UTF-8")
        }

        MsgNoActivate("✅ 更新完成！将重新启动。", "更新成功")
        Reload
    }
}

; 不抢焦点的消息框：用 NoActivate 的 GUI 代替 MsgBox，弹出时不会夺走游戏键盘焦点
MsgNoActivate(text, title := "提示", buttons := "OK") {
    global g_altHeld
    result := ""
    g := Gui("+AlwaysOnTop -MinimizeBox +ToolWindow +E0x08000000", title)  ; E0x08000000=WS_EX_NOACTIVATE，点击按钮也不激活/不抢焦点
    g.MarginX := 22
    g.MarginY := 18
    g.SetFont("s11", "Microsoft YaHei")
    txt := g.Add("Text", "", text)
    txt.GetPos(&tx, &ty, &tw, &th)

    btnW := 88, btnH := 34, gap := 26
    blockW := (buttons = "YesNo") ? btnW * 2 + gap : btnW
    contentW := Max(tw, blockW)
    txt.Move(tx, ty, contentW)          ; 让文字宽度与整体一致，居中更协调
    bx := tx + (contentW - blockW) / 2
    by := ty + th + 18

    if (buttons = "YesNo") {
        b1 := g.Add("Button", "x" bx " y" by " w" btnW " h" btnH " Default", "是")
        b2 := g.Add("Button", "x+" gap " yp w" btnW " h" btnH, "否")
        b1.OnEvent("Click", (*) => (result := "Yes", g.Destroy()))
        b2.OnEvent("Click", (*) => (result := "No", g.Destroy()))
        g.OnEvent("Close", (*) => (result := "No", g.Destroy()))
    } else {
        b1 := g.Add("Button", "x" bx " y" by " w" btnW " h" btnH " Default", "确定")
        b1.OnEvent("Click", (*) => (result := "OK", g.Destroy()))
        g.OnEvent("Close", (*) => (result := "OK", g.Destroy()))
    }
    needAlt := !g_altHeld           ; 仅当本函数自己按下Alt时才负责松开，避免误放别处按住的Alt
    if (needAlt)
        HoldAlt()                   ; 弹框时也按住Alt，让原神大世界露出鼠标，方便点 是/否
    g.Show("NoActivate AutoSize")
    while (result = "")
        Sleep(50)
    if (needAlt)
        ReleaseAlt()                ; 关框后立即松开(CheckUpdate在OnExit注册前运行，必须自己兜底)
    return result
}

EncodeUrl(str) {
    out := ""
    Loop Parse str {
        c := A_LoopField
        if RegExMatch(c, "[A-Za-z0-9_.~\-/]")
            out .= c
        else {
            buf := Buffer(4)
            n := DllCall("WideCharToMultiByte", "uint", 65001, "uint", 0,
                         "wstr", c, "int", 1, "ptr", buf, "int", 4,
                         "ptr", 0, "ptr", 0, "int")
            Loop n
                out .= "%" Format("{:02X}", NumGet(buf, A_Index-1, "UChar"))
        }
    }
    return out
}