package game.balls
{

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.hex.HexGrid;

public class BallGun extends Sprite
{
	private var _shootingBallPoint:Point;
	private var _touchablePole:Sprite;
	private var _path:Shape = new Shape();
	private var _ball:Ball;
	private var _shootAngle:Number;
	private var _bulletSpeed:Number;

	public function BallGun()
	{
		_bulletSpeed = Math.floor(HexGrid.hexWidth/5);

		addShootingBall();
		addTouchablePole();
	}

	private function addTouchablePole():void
	{
		_touchablePole = new Sprite();
		_touchablePole.graphics.beginFill(0, 0);
		_touchablePole.graphics.drawRect(0, 0, Main.WIDTH, Main.HEIGHT);
		_touchablePole.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		_touchablePole.addEventListener(MouseEvent.CLICK, clickHandler);
		addChild(_touchablePole);
	}

	private function clickHandler(event:MouseEvent):void
	{
		_shootAngle = (Math.atan2(_touchablePole.mouseY-_shootingBallPoint.y,
								  _touchablePole.mouseX-_shootingBallPoint.x))*(180/Math.PI);

		if(!hasEventListener(Event.ENTER_FRAME))
		{
			_touchablePole.removeEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
	}

	private function enterFrameHandler(event:Event):void
	{
		_ball.x += _bulletSpeed*Math.cos(Math.PI/180*_shootAngle);
		_ball.y += _bulletSpeed*Math.sin(Math.PI/180*_shootAngle);

		if(hitTestUpperBalls(_ball))
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_touchablePole.addEventListener(MouseEvent.CLICK, clickHandler);
			var ballHexPoint:Point = HexGrid.pixelsToHex(new Point(Math.floor(_ball.x), Math.floor(_ball.y)));
			_ball.x = ballHexPoint.x;
			_ball.y = ballHexPoint.y;
			removeChild(_ball);

			UpperBalls.addBall(_ball);

			addShootingBall();
		}
	}

	private static function hitTestUpperBalls(ball:Ball):Boolean
	{
		var testAngle:Number = 60;
		var rad:Number = ball.width/2;
		var testPoint:Point;
		var bx:int;
		var by:int;

		if((ball.x <= 0) || (ball.x >= Main.WIDTH) || (ball.y <= 0))
		{
			return true;
		}

		for(var i:int = 0; i < 6; i++)
		{
			bx = Math.floor(ball.x+rad*Math.cos(testAngle*i));
			by = Math.floor(ball.y+rad*Math.sin(testAngle*i));
			testPoint = new Point(bx, by);

			if(UpperBalls.getBallFromPoint(HexGrid.pixelsToHex(testPoint)))
				return true;
		}

		return false;
	}

	private function mouseMoveHandler(event:MouseEvent):void
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
		_ball.mouseEnabled = false;
		addChild(_path);
		addChild(_ball);
	}
}
}
