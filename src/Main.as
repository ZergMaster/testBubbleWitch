package
{

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.Log;

public class Main extends Sprite
{
	private static const WIDTH:Number = 800;
	private static const HEIGHT:Number = 600;

	public function Main()
	{
		var log:Log = new Log(WIDTH, HEIGHT);
		addChild(log);

		addChild(HexGrid.createGrid(WIDTH, HEIGHT));
		var game:Game = new Game();
		addChild(game);

		stage.addEventListener(MouseEvent.CLICK, clickStageHandler);
	}

	private function clickStageHandler(event:MouseEvent):void
	{
	}
}
}