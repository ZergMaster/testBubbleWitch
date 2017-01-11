/**
 * Created by ZergMaster on 06.01.2017.
 */
package
{

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;

public class HexGrid
{
	private static var _hexWidth:Number;
	private static var _hexYGap:Number;
	private static var _hexHeight:Number;
	private static var _verticalHexCount:int;
	private static var _horizontalHexCount:int;

	public function HexGrid()
	{
	}

	public static function createGrid(width:Number, height:Number, hexSize:int = 25):Sprite
	{
		_hexHeight = hexSize*2;
		_hexWidth = Math.sqrt(3)/2*_hexHeight;
		_hexYGap = _hexHeight*3/4;

		var grid:Sprite = new Sprite();
		_verticalHexCount = Math.ceil(height/hexHeight/3*4);
		_horizontalHexCount = Math.ceil(width/hexWidth);
		
		for(var i:int = 0; i < verticalHexCount; i++)
		{
			for(var n:int = 0; n < horizontalHexCount; n++)
			{
				var hex:Shape = new Hexagon(hexSize);
				grid.addChild(hex);
				hex.x = hexWidth*n;
				hex.y = hexHeight*3/4*i;

				if(i%2)
					hex.x += hex.width/2;
			}
		}

		return grid;
	}

	public static function pixelsToHex(inputPoint:Point):Point
	{
		var floorHexNumX:int = Math.floor(inputPoint.x/(hexWidth/2));
		var floorHexNumY:int = Math.floor(inputPoint.y/hexYGap);

		var hexPointsX:Vector.<Number> = new Vector.<Number>(2, true);
		hexPointsX[0] = (hexWidth/2)*floorHexNumX;
		hexPointsX[1] = (hexWidth/2)*(floorHexNumX+1);

		var hexPointsY:Vector.<Number> = new Vector.<Number>(2, true);
		hexPointsY[0] = floorHexNumY*hexYGap;
		hexPointsY[1] = (floorHexNumY+1)*hexYGap;

		var hexPoints:Vector.<Point> = new <Point>[];

		var i:int;
		var n:int;
		for(i = 0; i < hexPointsX.length; i++)
		{
			for(n = 0; n < hexPointsY.length; n++)
			{
				var rest:Number = Math.floor(hexPointsX[i]%hexWidth);
				if((rest != 0) && (rest != Math.floor(hexWidth)) && ((hexPointsY[n]/hexYGap)%2))
					hexPoints.push(new Point(hexPointsX[i], hexPointsY[n]));
				else if((!rest || (rest == Math.floor(hexWidth))) && !((hexPointsY[n]/hexYGap)%2))
					hexPoints.push(new Point(hexPointsX[i], hexPointsY[n]));
			}
		}

		var resultPoint:Point = hexPoints[0];

		for(i = 0; i < hexPoints.length; i++)
		{
			if(Point.distance(inputPoint, hexPoints[i]) < Point.distance(inputPoint, resultPoint))
				resultPoint = hexPoints[i];
		}

		return resultPoint;
	}

	public static function get hexHeight():Number
	{
		return _hexHeight;
	}

	public static function get hexWidth():Number
	{
		return _hexWidth;
	}

	public static function get hexYGap():Number
	{
		return _hexYGap;
	}

	public static function get verticalHexCount():int
	{
		return _verticalHexCount;
	}

	public static function get horizontalHexCount():int
	{
		return _horizontalHexCount;
	}
}
}
