package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import Std;

class Main extends Sprite {
	
	private var _timers:Array<TimerClass> ;
	private var _currentClickedTimer:Int;
	private var _tickTime:Float;
	private var _gameConfig:GameConfig;
	
	public function new () {
		
		super ();
		_timers  = new Array();
		
		
		initGame();
		startGame();
	}
	
	private function initGame() {
		_gameConfig = hardCodedValues();
	}
	
	private function hardCodedValues():GameConfig {
		var gameConfig:GameConfig = new HardCodedGameConfig();		
		return gameConfig;
	}	
	
	public function startGame() {
		_currentClickedTimer = -1;
		var totalTimerAmount = _gameConfig.playersNumber + 1;
		var timerHeight:Int = Std.int(stage.stageHeight / totalTimerAmount);
		var timerWidht:Int = Std.int(stage.stageWidth);
		for (i in 0..._gameConfig.playersNumber) {
			var tmpTimerClass:TimerClass = new TimerClass(timerWidht, timerHeight, _gameConfig.getPlayerColor(i));
			tmpTimerClass.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			_timers.push(tmpTimerClass);
		}
		//totalTimer
		var tmpTimerClass:TimerClass = new TimerClass(timerWidht, timerHeight, 0xFFFFFF);
		_timers.push(tmpTimerClass);
		setTimersPostions();
	}
	
	function setTimersPostions():Void 
	{
		for (i in 0..._timers.length) {
			_timers[i].y = _timers[i].height * i;
			addChild(_timers[i]);
		}
	}
	
	function mouseUpListener(e:MouseEvent):Void 
	{
		var eventTimer:TimerClass = cast(e.currentTarget, TimerClass);
		var index:Int = _timers.indexOf(eventTimer);
		if (index != _currentClickedTimer) {
			_currentClickedTimer = index;
			_tickTime = -1;
			stage.addEventListener(Event.ENTER_FRAME, tickListener);	
		}
		else {
			_currentClickedTimer = -1;
			stage.removeEventListener(Event.ENTER_FRAME, tickListener);
			_tickTime = -1;
			updateLastTimer();
		}
	}
	
	function tickListener(e:Event):Void 
	{
		var date:Float = Date.now().getTime();
		
		if (_tickTime == -1) {
			_tickTime = date;
			return ;
		}
		var originalDate:Float = date;
		date = date - _tickTime;
		var secondDuration:Int = 1;
		#if(html5)
			secondDuration = 1000;
		#end
		#if(android)
			secondDuration = 1000;
		#end
		if (date > secondDuration) {
			var tickFloat:Float = date / secondDuration;
			var tickTime:Int = Std.int(tickFloat);
			_timers[_currentClickedTimer].upddateTime(tickTime);
			
			_tickTime = originalDate;
			_timers[_timers.length -1].upddateTime(tickTime);
			
		}
	}
	
	function updateLastTimer():Void 
	{
		var totalTime:Int = 0;
		for (i in 0...(_timers.length - 1)) {
			totalTime+= _timers[i].totalTime;
		}
		_timers[_timers.length - 1].totalTime = 0;
		_timers[_timers.length - 1].upddateTime(totalTime);		
	}
	
	function timerTouchedListener(e:MouseEvent):Void 
	{
		var eventTimer:TimerClass = cast(e.currentTarget, TimerClass);
		eventTimer.x += 10;
		this.removeChild(eventTimer);
	}
	
}