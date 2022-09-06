package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverState extends FlxTransitionableState
{
	var bfX:Float = 0;
	var bfY:Float = 0;

	public function new(x:Float, y:Float)
	{
		super();

		bfX = x;
		bfY = y;
	}

	override function create()
	{
		var loser:FlxSprite = new FlxSprite(100, 100);
		var loseTex = Paths.getSparrowAtlas('lose');
		loser.frames = loseTex;
		loser.animation.addByPrefix('lose', 'lose', 24, false);
		loser.animation.play('lose');
		loser.antialiasing = FlxG.save.data.antialiasing;
		add(loser);

		var bf:Boyfriend = new Boyfriend(bfX, bfY);
		// bf.scrollFactor.set();
		add(bf);
		bf.playAnim('firstDeath');

		FlxG.camera.follow(bf, LOCKON, 0.001);

		var restart:FlxSprite = new FlxSprite(500, 50).loadGraphic(Paths.loadImage('restart'));
		restart.setGraphicSize(Std.int(restart.width * 0.6));
		restart.updateHitbox();
		restart.alpha = 0;
		restart.antialiasing = FlxG.save.data.antialiasing;
		add(restart);

		FlxG.sound.music.fadeOut(2, FlxG.sound.music.volume * 0.6);

		FlxTween.tween(restart, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		FlxTween.tween(restart, {y: restart.y + 40}, 7, {ease: FlxEase.quartInOut, type: PINGPONG});

		super.create();
	}

	private var fading:Bool = false;

	override function update(elapsed:Float)
	{
		var pressed:Bool = FlxG.keys.justPressed.ANY;

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (FlxG.save.data.InstantRespawn)
		{
			fading = true;
			FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween)
			{
				FlxG.sound.music.stop();
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}

		if (gamepad != null)
		{
			if (gamepad.justPressed.ANY)
				pressed = true;
		}

		pressed = false;

		if (pressed && !fading)
		{
			fading = true;
			FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween)
			{
				FlxG.sound.music.stop();
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}
		super.update(elapsed);
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
