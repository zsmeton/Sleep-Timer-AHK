#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
!t::
CoordMode,Mouse,Screen
MouseGetPos, xmos, ymos
InputBox, x , SleepTimer, How many minutes?, 250,350,
time:=x*60*1000
Sleep,time
Send {Media_Play_Pause}
Return
