/**
 * Created by ZergMaster on 08.01.2017.
 */
package
{

import flash.display.Sprite;
import flash.geom.Point;

public class Game extends Sprite
{

	private static var _balls:Vector.<Ball>;

	public function Game()
	{
		layoutBalls();

		addBallWeight();
		removeAllWithoutWeight();
	}

	private function layoutBalls():void
	{
		_balls = new <Ball>[];
		for(var n:int = 0; n < 6; n++)
		{
			for(var i:int = 0; i < HexGrid.horizontalHexCount; i++)
			{
				var rand:Number = Math.round(Math.random());

				if(rand)
				{
					var hexPoint:Point = HexGrid.pixelsToHex(
							new Point((HexGrid.hexWidth*i+HexGrid.hexWidth/4), (HexGrid.hexYGap*n-HexGrid.hexYGap/4)));
					var ball:Ball = new Ball(hexPoint);
					addChild(ball);
					_balls.push(ball);
				}
			}
		}
	}

	private static function addBallWeight():void
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			if(!_balls[i].y && !_balls[i].weight)
			{
				_balls[i].transferWeight(1);
			}
		}
	}

	public static function getBallFromPoint(point:Point):Ball
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			var ball:Ball = _balls[i];
			if((point.x == Math.floor(ball.x)) && (point.y == Math.floor(ball.y)))
				return ball;
		}
		return null;
	}

	public static function removeBallFromArray(ball:Ball):void
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			if(_balls[i] == ball)
				_balls.removeAt(i);
		}
	}

	public static function removeAllWithoutWeight():void
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			var ball:Ball = _balls[i];
			if(!ball.weight)
			{
				ball.remove();
				i--;
			}
		}
	}
}
}
