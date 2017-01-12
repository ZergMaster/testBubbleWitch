package com.testBubbleWitchSaga.game.balls
{

import flash.display.Sprite;
import flash.geom.Point;

import com.testBubbleWitchSaga.utils.hex.HexGrid;

public class UpperBalls extends Sprite
{
	private static var _ballsContainer:Sprite;
	private static var _balls:Vector.<Ball>;

	public function UpperBalls()
	{
		layoutBalls();

		addBallsWeight();
		removeAllWithoutWeight();
	}

	private function layoutBalls():void
	{
		_ballsContainer = new Sprite();
		addChild(_ballsContainer);

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
					_ballsContainer.addChild(ball);
					_balls.push(ball);
				}
			}
		}
	}

	public static function resetBallsWeight():void
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			_balls[i].weight = 0;
		}
		
		addBallsWeight();
		removeAllWithoutWeight();
	}

	private static function addBallsWeight():void
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			if(!_balls[i].y && !_balls[i].weight)
				_balls[i].transferWeight(1);
		}
	}

	public static function addBall(ball:Ball):void
	{
		_balls.push(ball);
		ball.weight = 1;
		_ballsContainer.addChild(ball);
		ball.checkColor(new Vector.<Ball>());

		removeAllWithoutWeight();
		resetBallsWeight();
	}

	public static function getBallFromPoint(point:Point):Ball
	{
		for(var i:int = 0; i < _balls.length; i++)
		{
			var ball:Ball = _balls[i];
			if((Math.floor(point.x) == Math.floor(ball.x)) && (Math.floor(point.y) == Math.floor(ball.y)))
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
