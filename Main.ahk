;自己的脚本与此脚本的区别：
; tab键触发(不是caps lock)
;最低sleep为20
;sleep高很多
;每个脚本多一个功能`

#Requires AutoHotkey v2.0
#SingleInstance Force
CheckUpdate()

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
        ["测试", "传奇\测试.ahk"],
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


CheckUpdate() {
    static base := "https://cdn.jsdelivr.net/gh/dzhao735-cloud/Genshin-qzd@main/"
    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        ; 1. 获取版本时加上时间戳，干掉 jsDelivr 缓存
        whr.Open("GET", base "version.txt?t=" A_TickCount, false)
        whr.SetTimeouts(5000, 5000, 10000, 10000)
        whr.Send()
        remoteVer := Trim(whr.ResponseText)
    } catch {
        return
    }
    
    localTextFile := A_ScriptDir "\version.txt"
    localVer := FileExist(localTextFile) ? Trim(FileRead(localTextFile)) : "0"
    if (remoteVer = localVer || remoteVer = "")
        return
        
    if MsgBox("发现新版本 v" remoteVer "  （当前 v" localVer "）`n是否立即更新所有路线脚本？",
              "千织屋自动锄地 - 脚本更新", "YesNo Icon?") != "Yes"
        return
        
    try {
        ; 2. 获取 filelist.txt 加上时间戳，确保拿到最新名单
        whr.Open("GET", base "filelist.txt?t=" A_TickCount, false)
        whr.Send()
        fileList := whr.ResponseText
    } catch {
        MsgBox("获取文件列表失败，请检查网络。", "更新失败", "IconX")
        return
    }
    
    if (Trim(fileList) == "") {
        MsgBox("同步失败：从云端获取到的文件列表为空！", "错误", "IconX")
        return
    }
    
    failed := []
    successCount := 0
    totalFiles := 0
    
    ; 先统计总文件数（排除空行和注释）
    for rawLine in StrSplit(fileList, "`n") {
        line := Trim(StrReplace(rawLine, "`r", ""))
        if (line != "" && SubStr(line, 1, 1) != ";" && line != "version.txt")
            totalFiles++
    }
    
    ; 开始遍历下载
    for rawLine in StrSplit(fileList, "`n") {
        line := Trim(StrReplace(rawLine, "`r", ""))
        if (line = "" || SubStr(line, 1, 1) = ";" || line = "version.txt")
            continue
            
        ; 规范化本地保存路径，处理“精英怪/山鼬.ahk” -> “精英怪\山鼬.ahk”
        standardLine := StrReplace(line, "/", "\")
        localPath := A_ScriptDir "\" standardLine
        
        ; 自动创建对应的子文件夹
        SplitPath(localPath,, &dir)
        if (dir != "" && !FileExist(dir))
            DirCreate(dir)
            
        try {
            ; 显示动态下载进度，让用户知道卡在哪个文件
            ToolTip("正在同步 (" successCount + failed.Length + 1 "/" totalFiles "):`n" line, A_ScreenWidth/2 - 100, A_ScreenHeight/2)
            
            ; ===== 核心修复：URL 编码时，必须对包含中文的子路径进行编码，同时挂上时间戳破缓存 =====
            urlTarget := base . EncodeUrl(line) "?t=" A_TickCount
            Download(urlTarget, localPath)
            successCount++
        } catch {
            failed.Push(line)
        }
    }
    
    ToolTip() ; 关闭进度提示
    
    ; ===== 核心逻辑修正：安全校验 =====
    if (failed.Length > 0) {
        msg := ""
        for f in failed
            msg .= "❌ " f "`n"
        MsgBox("以下文件下载失败（可能由于 CDN 暂未刷新或网络波动）：`n`n" msg "`n本地版本号未变动，请尝试重新运行主脚本更新。", "部分更新失败", "IconX")
    } else {
        ; 只有当全部文件成功下载覆盖后，才允许修改本地的 version.txt
        try {
            if FileExist(localTextFile)
                FileDelete(localTextFile)
            FileAppend(remoteVer, localTextFile, "UTF-8")
        }
        
        BlockInput(false) ; 确保安全解锁键盘鼠标
        MsgBox("✅ 所有路线脚本已成功同步至最新版 v" remoteVer "！`n将自动重新启动。", "更新成功", "Icon!")
        Run('"' A_AhkPath '" "' A_ScriptFullPath '"')
        ExitApp()
    }
}



; CheckUpdate() {
;     static base := "https://cdn.jsdelivr.net/gh/dzhao735-cloud/Genshin-qzd@main/"
;     try {
;         whr := ComObject("WinHttp.WinHttpRequest.5.1")
;         whr.Open("GET", base "version.txt", false)
;         whr.SetTimeouts(5000, 5000, 10000, 10000)
;         whr.Send()
;         remoteVer := Trim(whr.ResponseText)
;     } catch {
;         return
;     }
;     localVerFile := A_ScriptDir "\version.txt"
;     localVer := FileExist(localVerFile) ? Trim(FileRead(localVerFile)) : "0"
;     if (remoteVer = localVer || remoteVer = "")
;         return
;     if MsgBox("发现新版本 v" remoteVer "  （当前 v" localVer "）`n是否立即更新？",
;               "脚本更新", "YesNo Icon?") != "Yes"
;         return
;     try {
;         whr.Open("GET", base "filelist.txt", false)
;         whr.Send()
;         fileList := whr.ResponseText
;     } catch {
;         MsgBox("获取文件列表失败，请检查网络。", "更新失败", "IconX")
;         return
;     }
;     failed := []
;     for rawLine in StrSplit(fileList, "`n") {
;         line := Trim(StrReplace(rawLine, "`r", ""))
;         if (line = "" || SubStr(line, 1, 1) = ";")
;             continue
;         localPath := A_ScriptDir "\" StrReplace(line, "/", "\")
;         SplitPath(localPath,, &dir)
;         if (dir != "" && !FileExist(dir))
;             DirCreate(dir)
;         try {
;             Download(base . EncodeUrl(line), localPath)
;         } catch {
;             failed.Push(line)
;         }
;     }
;     if (failed.Length > 0) {
;         msg := ""
;         for f in failed
;             msg .= f "`n"
;         MsgBox("以下文件下载失败：`n" msg, "部分更新失败", "IconX")
;     } else {
;         MsgBox("✅ 更新完成！将重新启动。", "更新成功", "Icon!")
;         Reload
;     }
; }

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