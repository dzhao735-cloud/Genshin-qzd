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

; ==================== 原神风配色 ====================
C_WINBG  := "333A4A"    ; 窗口底·深石板蓝
C_TBAR   := "2A3040"    ; 标题栏
C_GOLD   := "D3BC8E"    ; 香槟金
C_CREAM  := "ECE5D8"    ; 米白(按钮文字/悬停填充)
C_INK    := "3D4556"    ; 悬停后的深色文字
C_BTNBG  := "3E4557"    ; 按钮底
C_BTNBD  := "6B6862"    ; 按钮细金边
C_LINE   := "6E6757"    ; 分类标题延长线
C_SEP    := "565759"    ; 左右分栏线
C_KEYBG  := "2A2F3C"    ; 键帽底
C_KEYBD  := "8B816F"    ; 键帽边
C_DESC   := "C9CDD8"    ; 热键说明文字
C_EXITBD := "837B6C"    ; 退出按钮描边
C_EXITHV := "4B4D54"    ; 退出按钮悬停底
C_XFG    := "8D94A5"    ; 关闭按钮
C_XHV    := "3A4152"    ; 关闭按钮悬停底

; ==================== 布局尺寸 ====================
WIN_W   := 860
TITLE_H := 40
PAD     := 18
RIGHT_W := 250
SEP_X   := WIN_W - RIGHT_W - 1        ; 分栏线x
LEFT_W  := SEP_X - PAD * 2            ; 左栏内容宽
BTN_W   := (LEFT_W - 18) // 3
BTN_H   := 42
GAP     := 9

global gButtons := Map()   ; hwnd -> 按钮的常态/悬停配色
global gHover := 0         ; 当前悬停按钮的hwnd

; 0x2000000=WS_CLIPCHILDREN: 父窗口不重绘控件区域, 配合控件的WS_CLIPSIBLINGS让圆角区域裁剪生效
myGui := Gui("+AlwaysOnTop -Caption +E0x08000000 +0x2000000", "原神锄地脚本")  ; WS_EX_NOACTIVATE：点路线按钮也不抢焦点/不切回桌面
myGui.BackColor := C_WINBG
myGui.MarginX := 0
myGui.MarginY := 0

; -------- 标题栏(无边框窗口自绘; 按住标题栏/空白处可拖动) --------
myGui.Add("Text", "x0 y0 w" WIN_W " h" TITLE_H " Background" C_TBAR)
myGui.SetFont("s12 w700 c" C_GOLD, "Microsoft YaHei")
myGui.Add("Text", "x16 y0 w240 h" TITLE_H " +0x200 Background" C_TBAR, "◆ 原神锄地启动器")
closeBtn := MakeBtn(myGui, WIN_W - 38, 7, 26, 26, 8, "✕", "s11", C_TBAR, C_XFG, C_XHV, C_CREAM)
closeBtn.OnEvent("Click", (*) => ExitApp())

; -------- 左栏: 分类标题 + 路线按钮 --------
yPos := TITLE_H + 16
for _, catName in catOrder {
    routes := categories[catName]

    ; 分类标题: ◆ 名称 ──── (WS_CLIPCHILDREN下父窗口不画控件底色, 文字控件用同色实底代替透明)
    myGui.SetFont("s7 c" C_GOLD, "Microsoft YaHei")
    myGui.Add("Text", "x" PAD " y" yPos " w14 h22 +0x200 Background" C_WINBG, "◆")
    myGui.SetFont("s11 w700 c" C_GOLD, "Microsoft YaHei")
    nameW := StrLen(catName) * 15 + 10
    myGui.Add("Text", "x" (PAD + 16) " y" yPos " w" nameW " h22 +0x200 Background" C_WINBG, catName)
    lineX := PAD + 16 + nameW
    myGui.Add("Text", "x" lineX " y" (yPos + 11) " w" (SEP_X - PAD - lineX) " h1 Background" C_LINE)
    yPos += 30

    xPos := PAD
    col := 0
    for _, route in routes {
        btn := MakeBtn(myGui, xPos, yPos, BTN_W, BTN_H, 12, route[1], "s12 w600", C_BTNBG, C_CREAM, C_CREAM, C_INK, C_BTNBD)
        btn.OnEvent("Click", LaunchRoute.Bind(route[2]))
        col++
        if (col >= 3) {
            col := 0
            xPos := PAD
            yPos += BTN_H + GAP
        } else {
            xPos += BTN_W + GAP
        }
    }
    if (col > 0)
        yPos += BTN_H + GAP
    yPos += 5
}

; -------- 退出按钮(胶囊形) --------
yPos += 8
exitBtn := MakeBtn(myGui, PAD, yPos, LEFT_W, 36, 36, "退　出", "s11 w600", C_WINBG, C_GOLD, C_EXITHV, C_GOLD, C_EXITBD)
exitBtn.OnEvent("Click", (*) => ExitApp())
winH := yPos + 36 + 20

; -------- 右栏: 热键功能(键帽样式) --------
myGui.Add("Text", "x" SEP_X " y" TITLE_H " w1 h" (winH - TITLE_H) " Background" C_SEP)
myGui.SetFont("s11 w700 c" C_GOLD, "Microsoft YaHei")
myGui.Add("Text", "x" (SEP_X + 19) " y" (TITLE_H + 16) " w200 h22 +0x200 Background" C_WINBG, "◆ 热键功能")

; [键名, 说明, 键帽宽, 说明行数]  ; "#SEC"=分组小标题
hotkeys := [
    ["Tab", "执行当前点位", 46, 1],
    ["←",   "后退一个点位", 34, 1],
    ["→",   "前进一个点位", 34, 1],
    ["F3",  "暂停/开启脚本", 34, 1],
    ["F4",  "重新选择路线", 34, 1],
    ["F7",  "圣遗物自动拾取`n(默认开启 且只对-6生效)", 34, 2],
    ["F12", "调整地图大小`n(建议连按两次)", 40, 2],
    ["#SEC", "吃药功能", 0, 0],
    ["~/``", "回复体力药 (饭团)", 46, 1],
    ["F10", "恰 (小美) 背包里`n第2个和第3个的位置", 40, 2],
    ["-/—", "夜兰 (乆刄)", 46, 1],
    ["=/+", "火神 (乆刄)", 46, 1],
]
hkY := TITLE_H + 52
for _, hk in hotkeys {
    if (hk[1] = "#SEC") {   ; 分组小标题: ◆ 名称 ────
        hkY += 6
        myGui.SetFont("s7 c" C_GOLD, "Microsoft YaHei")
        myGui.Add("Text", "x" (SEP_X + 18) " y" hkY " w12 h20 +0x200 Background" C_WINBG, "◆")
        myGui.SetFont("s10 w700 c" C_GOLD, "Microsoft YaHei")
        secW := StrLen(hk[2]) * 15 + 6
        myGui.Add("Text", "x" (SEP_X + 32) " y" hkY " w" secW " h20 +0x200 Background" C_WINBG, hk[2])
        secLineX := SEP_X + 32 + secW
        myGui.Add("Text", "x" secLineX " y" (hkY + 10) " w" (WIN_W - PAD - secLineX) " h1 Background" C_LINE)
        hkY += 30
        continue
    }
    keyW := hk[3]
    kbd := myGui.Add("Text", "x" (SEP_X + 18) " y" (hkY - 1) " w" (keyW + 2) " h26 +0x4000000 Background" C_KEYBD)
    RoundCtrl(kbd, keyW + 2, 26, 12)
    key := myGui.Add("Text", "x" (SEP_X + 19) " y" hkY " w" keyW " h24 Center +0x200 +0x4000000 Background" C_KEYBG, hk[1])
    key.SetFont("s10 c" C_GOLD, "Consolas")
    RoundCtrl(key, keyW, 24, 10)
    RaiseCtrl(key)   ; 提到键帽边框层之上
    myGui.SetFont("s10 c" C_DESC, "Microsoft YaHei")
    descX := SEP_X + 19 + keyW + 12
    myGui.Add("Text", "x" descX " y" (hkY + 3) " w" (WIN_W - PAD - descX) " Background" C_WINBG, hk[2])
    hkY += (hk[4] = 2) ? 50 : 32
}

; -------- 鼠标消息: 悬停变色 / 手型光标 / 拖动窗口 --------
OnMessage(0x200, OnMouseMove)    ; WM_MOUSEMOVE
OnMessage(0x2A3, OnMouseLeave)   ; WM_MOUSELEAVE
OnMessage(0x201, OnLButtonDown)  ; WM_LBUTTONDOWN
OnMessage(0x20, OnSetCursor)     ; WM_SETCURSOR

; Win11: 窗口圆角 + 淡金描边
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", myGui.Hwnd, "uint", 33, "int*", 2, "uint", 4)
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", myGui.Hwnd, "uint", 34, "uint*", 0x6F818B, "uint", 4)

myGui.Show("w" WIN_W " h" winH " NoActivate")
HoldAlt()   ; 界面显示后按住Alt，让原神大世界露出鼠标，方便点按钮

myGui.OnEvent("Close", (*) => ExitApp())
OnExit((*) => ReleaseAlt())   ; 兜底：任何退出路径(退出按钮/关闭/异常)都松开Alt，防止卡键

; ==================== 自绘按钮 ====================
; Text控件当按钮: 底下垫一层稍大的Text当细边框, 圆角用区域裁剪, 悬停配色记进gButtons
MakeBtn(guiObj, x, y, w, h, round, txt, fontOpt, bgN, fgN, bgH, fgH, borderColor := "", fontName := "Microsoft YaHei") {
    if (borderColor != "") {
        bd := guiObj.Add("Text", "x" (x - 1) " y" (y - 1) " w" (w + 2) " h" (h + 2) " +0x4000000 Background" borderColor)   ; 0x4000000=WS_CLIPSIBLINGS
        RoundCtrl(bd, w + 2, h + 2, round + 2)
    }
    btn := guiObj.Add("Text", "x" x " y" y " w" w " h" h " Center +0x200 +0x100 +0x4000000 Background" bgN, txt)   ; 0x100=SS_NOTIFY 让Text能收鼠标消息
    btn.SetFont(fontOpt " c" fgN, fontName)
    RoundCtrl(btn, w, h, round)
    RaiseCtrl(btn)   ; AHK先建的控件Z序更高, 开WS_CLIPSIBLINGS后会把内层裁掉, 需显式提到边框层之上
    gButtons[btn.Hwnd] := {ctrl: btn, fontOpt: fontOpt, fontName: fontName, bgN: bgN, fgN: fgN, bgH: bgH, fgH: fgH}
    return btn
}

; 控件圆角(区域裁剪按物理像素算, 要乘DPI缩放)
RoundCtrl(ctrl, w, h, d) {
    s := A_ScreenDPI / 96
    rgn := DllCall("CreateRoundRectRgn", "int", 0, "int", 0, "int", Round(w * s), "int", Round(h * s), "int", Round(d * s), "int", Round(d * s), "ptr")
    DllCall("SetWindowRgn", "ptr", ctrl.Hwnd, "ptr", rgn, "int", true)
}

; 把控件提到所有同级之上 (HWND_TOP, 不改位置大小不抢焦点)
RaiseCtrl(ctrl) {
    DllCall("SetWindowPos", "ptr", ctrl.Hwnd, "ptr", 0, "int", 0, "int", 0, "int", 0, "int", 0, "uint", 0x13)   ; SWP_NOSIZE|NOMOVE|NOACTIVATE
}

; 直接重绘控件自身: WS_CLIPCHILDREN下父窗口的重绘会剔除子控件区域,
; 所以AHK的ctrl.Redraw()(走父窗口)不会真正重画控件, 必须对控件窗口本身发RedrawWindow
RepaintCtrl(ctrl) {
    DllCall("RedrawWindow", "ptr", ctrl.Hwnd, "ptr", 0, "ptr", 0, "uint", 0x105)   ; RDW_INVALIDATE|RDW_ERASE|RDW_UPDATENOW
}

; ==================== 鼠标消息处理 ====================
OnMouseMove(wParam, lParam, msg, hwnd) {
    global gHover
    if (hwnd = gHover)
        return
    SetHover(gButtons.Has(hwnd) ? hwnd : 0)
}

SetHover(hwnd) {
    global gHover
    if (gHover && gButtons.Has(gHover)) {   ; 恢复上一个按钮的常态
        b := gButtons[gHover]
        b.ctrl.Opt("Background" b.bgN)
        b.ctrl.SetFont(b.fontOpt " c" b.fgN, b.fontName)
        RepaintCtrl(b.ctrl)
    }
    gHover := hwnd
    if (!hwnd)
        return
    b := gButtons[hwnd]
    b.ctrl.Opt("Background" b.bgH)
    b.ctrl.SetFont(b.fontOpt " c" b.fgH, b.fontName)
    RepaintCtrl(b.ctrl)
    ; 注册离开追踪: 鼠标离开该控件时收到WM_MOUSELEAVE, 用来恢复常态
    tme := Buffer(24, 0)
    NumPut("uint", 24, "uint", 2, "ptr", hwnd, tme)   ; cbSize, TME_LEAVE, hwnd
    DllCall("TrackMouseEvent", "ptr", tme)
}

OnMouseLeave(wParam, lParam, msg, hwnd) {
    global gHover
    if (hwnd = gHover)
        SetHover(0)
}

OnLButtonDown(wParam, lParam, msg, hwnd) {
    global myGui
    if (hwnd = myGui.Hwnd) {   ; 点在标题栏/空白处 → 拖动窗口
        DllCall("ReleaseCapture")
        PostMessage(0xA1, 2, 0, , myGui)   ; WM_NCLBUTTONDOWN, HTCAPTION
    }
}

OnSetCursor(wParam, lParam, msg, hwnd) {
    if (gButtons.Has(hwnd)) {
        DllCall("SetCursor", "ptr", DllCall("LoadCursor", "ptr", 0, "ptr", 32649, "ptr"))   ; IDC_HAND
        return 1
    }
}

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