package
{

import flash.display.Sprite;
import flash.events.MouseEvent;

import com.testBubbleWitchSaga.game.Game;

import com.testBubbleWitchSaga.utils.Log;
import com.testBubbleWitchSaga.utils.hex.HexGrid;

public class Main extends Sprite
{
	public static const WIDTH:Number = 800;
	public static const HEIGHT:Number = 600;

	public function Main()
	{
		var log:Log = new Log(WIDTH, HEIGHT);
		addChild(log);

		addChild(HexGrid.createGrid(WIDTH, HEIGHT));
		var game:Game = new Game();
		addChild(game);
	}
}
}
