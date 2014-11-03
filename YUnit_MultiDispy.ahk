﻿#NoEnv

#Include %A_ScriptDir%\Yunit\Yunit.ahk
#Include %A_ScriptDir%\Yunit\Window.ahk
#Include %A_ScriptDir%\Yunit\StdOut.ahk
#include lib\Windy\MultiDispy.ahk
#include lib\Windy\Dispy.ahk
#include lib\Windy\Recty.ahk

#Warn All
;#Warn LocalSameAsGlobal, Off
#SingleInstance force

ReferenceVersion := "0.1.4"

debug := 1

Yunit.Use(YunitStdOut, YunitWindow).Test(_BaseTestSuite, MultiDispyTestSuite)
Return

ExitApp

class MultiDispyTestSuite
{
	Begin() {
		Global debug
		this.obj := new MultiDispy(debug)
		this.monCount := 2
		this.mon1Width := 1920
		this.mon1Height := 1080
		this.mon2Width := 1600
		this.mon2Height := 1200
		
		this.monvirtWidth := this.mon1Width + this.mon2Width
		this.monvirtHeight := this.mon2Height
    }

	identify() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	this.obj.identify(250, "00FF00")
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}
	
   	monitorsCount() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		cnt := this.obj.monitorsCount
		Yunit.assert(cnt == this.monCount)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	size() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		rect :=  this.obj.virtualScreenSize
		Yunit.assert(rect.x == 0)
		Yunit.assert(rect.y == 0)
		Yunit.assert(rect.w == this.monvirtWidth)
		Yunit.assert(rect.h == this.monvirtHeight)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}
	
	virtualScreenSize() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		rect :=  this.obj.size
		Yunit.assert(rect.x == 0)
		Yunit.assert(rect.y == 0)
		Yunit.assert(rect.w == this.monvirtWidth)
		Yunit.assert(rect.h == this.monvirtHeight)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	End()  {
        this.remove("obj")
		this.obj := 
    }
}

class _BaseTestSuite {
    Begin() {
	}
	
	Version() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		Global ReferenceVersion
		md := new MultiDispy(debug)
		Yunit.assert(md.version == ReferenceVersion)
		OutputDebug % "MultiDispy Version <" md.version "> <-> Required <" ReferenceVersion ">"
		OutputDebug % ">>>>[" A_ThisFunc "]>>>>"
	}

	End() {
	}
}