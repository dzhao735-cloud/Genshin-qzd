#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "OCR.ahk"

; 运行此脚本，会弹窗显示系统当前安装了哪些OCR语言
; 如果列表里有 zh-Hans-CN 或 zh-CN，说明中文OCR可用

try {
    langs := OCR.GetAvailableLanguages()
    if (Trim(langs) = "")
        MsgBox("系统没有检测到任何OCR语言！`n需要安装语言的OCR组件。", "OCR检测", "Iconx")
    else
        MsgBox("系统已安装的OCR语言：`n`n" langs "`n`n如果上面有 zh-Hans 或 zh-CN，中文OCR就能用。", "OCR检测", "Iconi")
} catch as e {
    MsgBox("检测失败：" e.Message, "OCR检测", "Iconx")
}
