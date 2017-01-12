/**
 * Created by ZergMaster on 06.01.2017.
 */
package com.testBubbleWitchSaga.utils.hex
{

import flash.display.Shape;
import flash.geom.Point;

public class Hexagon extends Shape
{
	private var _size:Number = 25;

	public function Hexagon(size:Number)
	{
		super();

		_size = size;

		graphics.lineStyle(1, 0, 0.03);
		graphics.moveTo(hex_corner(_size, 1).x, hex_corner(_size, 1).y);
		for(var i:int = 2; i < 8; i ++)
		{
			graphics.lineTo(hex_corner(_size, i).x, hex_corner(_size, i).y);
		}
	}

	private static function hex_corner(size:Number, i:Number, center:Point = null):Point
	{
		if(! center)
			center = new Point(0, 0);

		var angle_deg:Number = 60 * i - 30;
		var angle_rad:Number = Math.PI / 180 * angle_deg;

		return new Point(center.x + size * Math.cos(angle_rad), center.y + size * Math.sin(angle_rad));
	}

	override public function get height():Number
	{
		return _size * 2;
	}

	override public function get width():Number
	{
		return Math.sqrt(3) / 2 * height;
	}
}
}
