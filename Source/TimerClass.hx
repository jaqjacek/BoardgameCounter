package;

import openfl.display.Sprite;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author jaq
 */
class TimerClass extends Sprite 
{
	public var totalTime:Int;
	private var timerTF:TextField;

	public function new(width:Int,height:Int,color:Int) 
	{
		super();		
		this.graphics.beginFill(color);
		this.graphics.drawRect(0, 0, width, height);
		this.graphics.endFill();		
		totalTime = 0;	
		initText();
		addChild(timerTF);		
		upddateTime();
	}
	
	function initText():Void 
	{
		timerTF = new TextField();		
		timerTF.width = width / 2;
		timerTF.x = width / 4;
		
		timerTF.antiAliasType = AntiAliasType.ADVANCED;
		timerTF.sharpness = 100;		
		displayTime();
		//proper Y position
		
		var tf:TextFormat = timerTF.getTextFormat(0, 1);
		tf.size = 72;	
		timerTF.setTextFormat(tf);
		timerTF.selectable = false;
		displayTime();
		
		timerTF.y = (height - timerTF.height) / 2;
	}
	
	public function upddateTime(secondsSrc:Int = 0) {
		totalTime+= secondsSrc;
		displayTime();
	}
	
	private function displayTime() {
		var tmpTime:Int = totalTime;
		var tmpFloat:Float;
		var seconds:Int = tmpTime % 60;
		tmpFloat =  tmpTime / 60;
		tmpTime = Std.int(tmpFloat);
		var minutes:Int = tmpTime % 60;
		tmpTime = Std.int(tmpTime / 60);
		var houers = tmpTime;
		
		var secondsString:String = seconds < 10 ? "0" + seconds: Std.string(seconds);
		var minutesString:String = minutes < 10 ? "0" + minutes: Std.string(minutes);
		var houersString:String = houers < 10 ? "0" + houers: Std.string(houers);
		var text:String = houersString + " : " + minutesString + " : " + secondsString;
		timerTF.text = text;
		
	}
	
}