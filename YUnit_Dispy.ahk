﻿#NoEnv

#Include %A_ScriptDir%\Yunit\Yunit.ahk
#Include %A_ScriptDir%\Yunit\Window.ahk
#Include %A_ScriptDir%\Yunit\StdOut.ahk
#include lib\Windy\Dispy.ahk
#include lib\Windy\Recty.ahk

#Warn All
;#Warn LocalSameAsGlobal, Off
#SingleInstance force


ReferenceVersion := "0.1.7"
debug := 1

;Yunit.Use(YunitStdOut, YunitWindow).Test(ExpDispyTestSuite)
Yunit.Use(YunitStdOut, YunitWindow).Test(_BaseTestSuite, DispyTestSuite)
Return

ExitApp


class ExpDispyTestSuite
{
	Begin() {
		Global debug
;		this.obj := new Dispy(1, debug)
		this.monCount := 2
		this.mon1Width := 1920
		this.mon1Height := 1080
  		this.mon2Width := 1600
		this.mon2Height := 1200		
    }

	End()  {
;        this.remove("obj")
;		this.obj := 
    }

}

class DispyTestSuite
{
	Begin() {
		Global debug
;		this.obj := new Dispy(1, debug)
		this.monCount := 2
		this.mon1Width := 1920
		this.mon1Height := 1080
  		this.mon2Width := 1600
		this.mon2Height := 1200		
    }

	_constructor() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
    	Yunit.assert(mon1 != false)
    	mon99 := new Dispy(99, debug)
    	Yunit.assert(mon99 = false)
    	OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
    }

    boundary() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
		rect1 := mon1.boundary
		Yunit.assert(rect1.w == this.mon1Width)
		Yunit.assert(rect1.h == this.mon1Height)	
		mon2 := new Dispy(2, debug)
		rect2 := mon2.boundary(2)
		Yunit.assert(rect2.x == rect1.w)
		Yunit.assert(rect2.y == rect2.y)
		Yunit.assert(rect2.w == rect1.w + this.mon2Width)
		Yunit.assert(rect2.h == this.mon2Height)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

    center() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
		pt1 := mon1.center
		Yunit.assert(pt1.x == this.mon1Width/2)
		Yunit.assert(pt1.y == this.mon1Height/2)
		mon2 := new Dispy(2, debug)
		pt2 := mon2.center
		Yunit.assert(pt2.x == (this.mon1Width+(this.mon2Width/2)))
		Yunit.assert(pt2.y == this.mon2Height/2)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	identify() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
		mon1.identify(250)
		mon2 := new Dispy(2, debug)
		mon2.identify(250)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	monitorsCount() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
		cnt := mon1.monitorsCount
		Yunit.assert(cnt == this.monCount)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}
	
	nextPrev() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"

		; Monitor 1
    	mon1 := new Dispy(1, debug)
		monNxt := mon1.next
		Yunit.assert(monNxt == 2)
		monNxt := mon1.next(0)
		Yunit.assert(monNxt == 2)
		monNxt := mon1.next(1)
		Yunit.assert(monNxt == 2)
		
		monPrv := mon1.prev
		Yunit.assert(monPrv == 2)
		monPrv := mon1.prev(0)
		Yunit.assert(monPrv == 1)
		monPrv := mon1.prev(1)
		Yunit.assert(monPrv == 2)

		; Monitor 2 ....
		mon2 := new Dispy(2, debug)
		monNxt := mon2.next
		Yunit.assert(monNxt == 1)
		monNxt := mon2.next(0)
		Yunit.assert(monNxt == 2)
		monNxt := mon2.next(1)
		Yunit.assert(monNxt == 1)
		
		monPrv := mon2.prev
		Yunit.assert(monPrv == 1)
		monPrv := mon2.prev(0)
		Yunit.assert(monPrv == 1)
		monPrv := mon2.prev(1)
		Yunit.assert(monPrv == 1)
		
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

		
    size() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
		rect := mon1.size
		Yunit.assert(rect.w == this.mon1Width)
		Yunit.assert(rect.h == this.mon1Height)	
		mon2 := new Dispy(2, debug)
		rect := mon2.size
		Yunit.assert(rect.w == this.mon2Width)
		Yunit.assert(rect.h == this.mon2Height)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	virtualScreenSize() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		mon1 := new Dispy(1, debug)
		rect := mon1.virtualScreenSize()
		Yunit.assert(rect.x == 0)
		Yunit.assert(rect.y == 0)
		Yunit.assert(rect.w == (this.mon1Width + this.mon2Width))
		Yunit.assert(rect.h == this.mon2Height)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	workingArea() {
    	Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	mon1 := new Dispy(1, debug)
		rect := mon1.workingArea
		Yunit.assert(rect.w <= this.mon1Width)
		Yunit.assert(rect.h <= this.mon1Height)	
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	End()  {
;        this.remove("obj")
;		this.obj := 
    }

}

class _BaseTestSuite {
    Begin() {
	}
	
	Version() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		Global ReferenceVersion
		idispy := new Dispy(1, debug)
		OutputDebug % "Dispy Version <" idispy.version "> <-> Required <" ReferenceVersion ">"
		Yunit.assert(idispy.version == ReferenceVersion)
		OutputDebug % ">>>>[" A_ThisFunc "]>>>>"
	}

	End() {
	}
}
