SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#NoEnv
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; Automatically replaces last instance

!s:: ;Alt + s activate hotkey
InputBox, x , SleepTimer, How many minutes?, 250,350, ; Creates gui for user input
time:=x*60*1000 ; Changes minutes to milliseconds
SoundGet, volume ; Gets current volume
OutputDebug, %volume% Timer: starting volume ; Prints the start volume in debug
interval:= 100
dropInterval:=x*interval ; sets the rate of decreasing volume to 3 times a minute
Timer:= time/dropInterval ; sets the delay in the program proportional to run time and drop interval
OutputDebug, %dropInterval%
; Calculations to find exponential volume function
linearMatch:= 3  ; finds (v/c) in function (v/c)=(1/k)(e^(kt)-1)

k:= Loopidy(x, volume, linearMatch)
OutputDebug, %k% This K Defined Outside Loopidy

Loopidy(x, volume, linearMatch){

   Loop 10000{
      ToolTip, %A_Index% ; This variable is built into AHK, it counts the loop number for you :)
      k:= (A_Index/10000)-0.75
      output:= 30*Exp(k*x)
      if (output >= linearMatch) {
         OutputDebug,  %k% K value
         Sleep 1000
         ToolTip
         return k  
      }
   }
}
Loop %dropInterval% { ; loops based on amount of drop intervals
   soundDrop:= volume*Exp(k*((A_Index-1)/interval))
   progres:= x-((A_Index-1)/interval)
   OutputDebug, %soundDrop% %progres%
   SoundSet, soundDrop ; reduces volume
   SoundGet, currentVolume 
   OutputDebug, %currentVolume% Timer: current volume ; prints to debug new volume
   Sleep,Timer
   }
Send {Media_Play_Pause} ; pauses media
OutputDebug, Timer: paused
Sleep, 1000
SoundSet, volume ; sets volume to initial volume before hotkey use
SoundGet, endVolume
OutputDebug, %endVolume% Timer: resetting volume  
Return
