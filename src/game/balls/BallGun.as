/**
 * Created by ZergMaster on 12.01.2017.
 */
package game.balls
{

import flash.display.Sprite;
import flash.geom.Point;

import utils.hex.HexGrid;

public class BallGun extends Sprite
{
	public function BallGun()
	{
		addShootingBall();
	}

	private function addShootingBall():void
	{
		var midPoint:Point = new Point(Main.WIDTH/2, Main.HEIGHT);
		var ball:Ball = new Ball(HexGrid.pixelsToHex(midPoint));
		addChild(ball);
	}
}
}
