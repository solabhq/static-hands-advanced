#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetCapsLockState, AlwaysOff

Menu, Tray, Icon, keyboard.ico
SetCapsLockState, AlwaysOff

; ===================================================================
; STATIC HANDS - Advanced Keyboard Layout
; ===================================================================

; ===================================================================
; NAVIGATION
; ===================================================================

CapsLock & i::Send, {blind}{Up}
CapsLock & j::Send, {blind}{Left}
CapsLock & k::Send, {blind}{Down}
CapsLock & l::Send, {blind}{Right}

CapsLock & u::Send, {blind}{home}
CapsLock & o::Send, {blind}{end}

CapsLock & y::Send, {blind}{PgUp}
CapsLock & n::Send, {blind}{PgDn}

CapsLock & h::Send, {blind}{delete}
CapsLock & SC027::Send, {blind}{Backspace}  ; Semicolon
CapsLock & p::Send, {blind}{Insert}

; ===================================================================
; MODIFIERS
; ===================================================================

CapsLock & f::Ctrl
CapsLock & d::Shift
CapsLock & s::Alt
CAPSLOCK & w::LWin

; ===================================================================
; TEXT EDITING
; ===================================================================

CapsLock & a::Send ^a  ; Select All
CapsLock & z::Send ^z  ; Undo
CapsLock & x::Send ^x  ; Cut
CapsLock & c::Send ^c  ; Copy
CapsLock & v::Send ^v  ; Paste
CapsLock & b::Send ^b  ; Bold

; ===================================================================
; SPEED NAVIGATION
; ===================================================================

CapsLock & 8::Send, {Up 5}
CapsLock & ,::Send, {Down 5}
CapsLock & m::Send, {blind}^{Left 6}   ; Left 6 words
CapsLock & .::Send, {blind}^{Right 6}  ; Right 6 words

; ===================================================================
; CASE CHANGE
; ===================================================================

CapsLock & 9::goSub, set_upper_case
CapsLock & 0::goSub, set_lower_case
CapsLock & -::goSub, set_title_case

set_upper_case:
set_lower_case:
set_title_case:
revert_clipboard := clipboardAll
clipboard =
send ^{c}
clipWait, 0.3

if (a_thisLabel = "set_upper_case")
    stringUpper, clipboard, clipboard
else if (a_thisLabel = "set_lower_case")
    stringLower, clipboard, clipboard
else if (a_thisLabel = "set_title_case")
    stringLower, clipboard, clipboard, T

send ^{v}
sleep 50
clipboard := revert_clipboard
return

; ===================================================================
; SPECIAL FUNCTIONS
; ===================================================================

CapsLock & q::Send, {blind}{Esc}
CapsLock & r::Send, {blind}{F2}  ; Rename
CapsLock & t::Send, {Home}{Shift down}{Down}{Shift up}  ; Select line

; Language switch - Choose one option or use system default (Win+Space)
; Option 1: CapsLock & Alt
; CapsLock & Alt::Send, {Alt Down}{Shift Down}{Shift Up}{Alt Up}

; Option 2: Alt & e
; !e::Send, {Alt Down}{Shift Down}{Shift Up}{Alt Up}


CapsLock & 7::Send, {blind}{Tab}
CapsLock & =::Winset, Alwaysontop, , A  ; Always On Top
CapsLock & `::Send !{F4}          ; Close window

CapsLock & F7::Send, {blind}{Enter}
CapsLock & F10::gosub, ShowHelp   ; Help window

; ===================================================================
; EXTERNAL TOOLS
; ===================================================================

; Google Search (Alt+G)
!g::
MyClip := ClipboardAll
Clipboard =
Send, ^c
ClipWait, 2
if ErrorLevel
{
    return
}
if RegExMatch(Clipboard, "^[^ ]*\.[^ ]*$")
{
    Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" %Clipboard%
}
else  
{
    StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All
    StringReplace, Clipboard, Clipboard, #, `%23, All
    StringReplace, Clipboard, Clipboard, &, `%26, All
    StringReplace, Clipboard, Clipboard, +, `%2b, All
    StringReplace, Clipboard, Clipboard, ", `%22, All
    Run % "https://www.google.com/search?hl=en&q=" . clipboard
}
Clipboard := MyClip
return

; ===================================================================
; HELP WINDOW (F10)
; ===================================================================

ShowHelp:
    Gui, Help:New, +AlwaysOnTop +ToolWindow +LabelHelp, Static Hands: CapsLock +
    Gui, Help:Color, 1a1a1a
    
    ; LEFT COLUMN
    ; Navigation
    Gui, Help:Font, s13 Bold c5a8ad8
    Gui, Help:Add, Text, x25 y25 w320, NAVIGATION
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+8 w90, I/J/K/L
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x120 yp w200, -> Arrows
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, U
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w70, -> Home
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x150 yp w40, O
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x195 yp w125, -> End
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, Y
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w70, -> PgUp
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x150 yp w40, N
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x195 yp w125, -> PgDn
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, H
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w250, -> Delete
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, `;
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w250, -> Backspace
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, P
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w250, -> Insert
    
    ; Modifiers
    Gui, Help:Font, s13 Bold c5a8ad8
    Gui, Help:Add, Text, x25 y+15 w320, MODIFIERS
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+8 w40, F
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w70, -> Ctrl
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x150 yp w40, D
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x195 yp w125, -> Shift
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, S
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w70, -> Alt
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x150 yp w40, W
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x195 yp w125, -> Win
    
    ; Text Editing
    Gui, Help:Font, s13 Bold c9c27b0
    Gui, Help:Add, Text, x25 y+15 w320, TEXT EDITING
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+8 w40, Z
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w70, -> Undo
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x150 yp w40, X
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x195 yp w125, -> Cut
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, C
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w70, -> Copy
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x150 yp w40, V
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x195 yp w125, -> Paste
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, A
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w250, -> Select All
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x25 y+5 w40, B
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x70 yp w250, -> Bold
    
    ; RIGHT COLUMN
    ; Speed
    Gui, Help:Font, s13 Bold cC03030
    Gui, Help:Add, Text, x360 y25 w305, SPEED
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+8 w40, 8
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Up x5
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, `,
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Down x5
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, M
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Left x6 words
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, .
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Right x6 words
    
    ; Case Change
    Gui, Help:Font, s13 Bold cFF9800
    Gui, Help:Add, Text, x360 y+15 w305, CASE CHANGE
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+8 w40, 9
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> UPPERCASE
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, 0
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> lowercase
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, -
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Title Case
    
    ; Special
    Gui, Help:Font, s13 Bold c00BCD4
    Gui, Help:Add, Text, x360 y+15 w305, SPECIAL
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+8 w40, ``
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Close window (Alt+F4)
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, 7
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Tab
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, Q
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Escape
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, R
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Rename (F2)
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, T
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Select line
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, =
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Always On Top
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, F7
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> Enter
    
    Gui, Help:Font, s13 Bold cFFD707
    Gui, Help:Add, Text, x360 y+5 w40, F10
    Gui, Help:Font, s12 Normal cE0E0E0
    Gui, Help:Add, Text, x405 yp w260, -> This Help window
    
    ; Bottom - External Tools
    Gui, Help:Font, s11 Normal c4CAF50
    Gui, Help:Add, Text, x25 y+25 w640 Center, External: Alt+G -> Google Search
    
    ; Button with softer styling
    Gui, Help:Font, s11 Normal cA0A0A0
    Gui, Help:Add, Button, gHelpClose x25 y+15 w640 h40, Close (Esc)
    Gui, Help:Show, w690
return

HelpClose:
HelpEscape:
    Gui, Help:Destroy
return