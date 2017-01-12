/**
 * Created by ZergMaster on 12.01.2017.
 */
package game.balls
{

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.hex.HexGrid;

public class BallGun extends Sprite
{
	private var _shootingBallPoint:Point;
	private var _touchablePole:Sprite;
	private var _path:Shape = new Shape();
	private var _ball:Ball;

	public function BallGun()
	{
		addShootingBall();
		addTouchablePole();
	}

	private function addTouchablePole():void
	{
		_touchablePole = new Sprite();
		_touchablePole.graphics.beginFill(0, 0);
		_touchablePole.graphics.drawRect(0, 0, Main.WIDTH, Main.HEIGHT);
		_touchablePole.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		addChild(_touchablePole);
	}

	private function mouseMoveHandler(event:MouseEvent):void
	{
		var angle:Number = (Math.atan2(_touchablePole.mouseY-_shootingBallPoint.y,
									   _touchablePole.mouseX-_shootingBallPoint.x))*(180/Math.PI);

		drawPath();
	}

	private function drawPath():void
	{
		_path.graphics.clear();
		_path.graphics.lineStyle(1, 0, 0.2);
		_path.graphics.moveTo(_shootingBallPoint.x, _shootingBallPoint.y);
		_path.graphics.lineTo(_touchablePole.mouseX, _touchablePole.mouseY);
	}

	private function addShootingBall():void
	{
		_shootingBallPoint = HexGrid.pixelsToHex(new Point(Main.WIDTH/2, Main.HEIGHT));
		_ball = new Ball(_shootingBallPoint);
		addChild(_path);
		addChild(_ball);
	}
}
}
