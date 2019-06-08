package;

/**
 * ...
 * @author jaq
 */
class GameConfig 
{
	@:isVar public var playersNumber(get, set):Int;
	private var _playersColors:Array<Int>;

	public function new() 
	{
		
	}
	
	public function getPlayerColor(playerNumber:Int):Int
	{
		return _playersColors[playerNumber];
	}
	
	public function setPlayerColor(playerNumber:Int, playerColor:Int) {
		_playersColors[playerNumber] = playerColor;
	}
	
	function get_playersNumber():Int 
	{
		return playersNumber;
	}
	
	function set_playersNumber(value:Int):Int 
	{
		playersNumber = value;
		_playersColors = new Array<Int>();
		for (i in 0...playersNumber) 
		{
			_playersColors.push(0xFFFFFF);
		}
		return playersNumber;
	}
	
	
	
	
	
}