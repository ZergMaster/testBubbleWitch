/**
 * Created by ZergMaster on 05.01.2017.
 */
package game.balls
{

import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.Point;

import utils.hex.HexGrid;

public class Ball extends Sprite
{
	private static var _colors:Vector.<uint> = new Vector.<uint>(6, true);

	private var _ball:Sprite = new Sprite();

	private var _weight:int = 0;

	public function Ball(point:Point = null, inputColor:uint = undefined)
	{
		if(point)
		{
			x = point.x;
			y = point.y;
		}

		_colors[0] = 0x808080; //gray
		_colors[1] = 0xffffff; //white
		_colors[2] = 0x0000ff; //blue
		_colors[3] = 0xff0000; //red
		_colors[4] = 0x008000; //green
		_colors[5] = 0xffff00; //yellow

		var _fon:Shape = new Shape();
		_fon.graphics.lineStyle(1);
		var color:uint = inputColor ? inputColor : getRandomColor();
		_fon.graphics.beginFill(color);
		_fon.graphics.drawCircle(0, 0, Math.floor(HexGrid.hexWidth/2-1));
		_fon.graphics.endFill();
		_fon.filters = [new GlowFilter(0x000000, 0.5, 30, 30, 2, 1, true), new DropShadowFilter(1, 90, 0, 0.5)];

		var shine1:Shape = new Shape();
		shine1.graphics.beginFill(_colors[1]);
		shine1.graphics.drawCircle(_fon.width/8, -_fon.height/8, _fon.width/4);
		shine1.graphics.endFill();
		shine1.alpha = 0.2;

		var shine2:Shape = new Shape();
		shine2.graphics.beginFill(_colors[1]);
		shine2.graphics.drawCircle(_fon.width/8+shine1.width/8, -_fon.height/8-shine1.height/8, shine1.width/6);
		shine2.graphics.endFill();
		shine2.alpha = 0.6;

		addChild(_ball);
		_ball.addChild(_fon);
		_ball.addChild(shine1);
		_ball.addChild(shine2);
	}

	private static function getRandomColor():uint
	{
		var randomIndex:int = Math.random()*_colors.length;
		return _colors[randomIndex];
	}

	public function remove():void
	{
		removeChild(_ball);
		parent.removeChild(this);
		UpperBalls.removeBallFromArray(this);
	}

	public function transferWeight(weight:int):void
	{
		_weight = weight;

		for(var i:int = 0; i < 6; i++)
		{
			var ball:Ball = checkHexFromAngle(60*i);

			if(ball && !ball._weight)
				ball.transferWeight(weight);
		}
	}

	private function checkHexFromAngle(angle_deg:int):Ball
	{
		var angle_rad:Number = Math.PI/180*angle_deg;
		var pointX:Number = Math.floor(x+HexGrid.hexWidth*Math.cos(angle_rad));
		var pointY:Number = Math.floor(y+HexGrid.hexWidth*Math.sin(angle_rad));
		var point:Point = new Point(pointX, pointY);

		return UpperBalls.getBallFromPoint(point);
	}

	public function get weight():int
	{
		return _weight;
	}
}
}
