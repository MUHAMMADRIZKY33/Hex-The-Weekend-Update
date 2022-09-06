package;

import flixel.FlxSprite;
import flixel.FlxSubState;

class ControlsSubState extends FlxSubState
{
	public function new()
	{
		super();
	}
}
#if android
addVirtualPad(LEFT_FULL, A_B);
#end

//if you want to remove it at some moment use
#if android
removeVirtualPad();
#end

//if you want it to have a camera
#if android
addPadCamera();
#end

//in states, these need to be added before super.create();
//in substates, in fuction new at the last line add these

//on Playstate.hx after all of the
//obj.cameras = [...];
//things, add
#if android
addAndroidControls();
#end

//if you want to remove it at some moment use
#if android
removeAndroidControls();
#end

//to make the controls visible the code is
#if android
androidControls.visible = true;
#end

//to make the controls invisible the code is
#if android
androidControls.visible = false;
#end
