package;

/**
 * ...
 * @author jaq
 */
class HardCodedGameConfig extends GameConfig 
{

	public function new() 
	{
		super();
		playersNumber = 4;
		this.setPlayerColor(0, 0xFF0000);
		this.setPlayerColor(1, 0xFFFF00);
		this.setPlayerColor(2, 0x00FF00);
		this.setPlayerColor(3, 0x00FFFF);
	}
	
}