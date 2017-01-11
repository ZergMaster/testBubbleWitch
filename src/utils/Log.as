/**
 * Created by ZergMaster on 06.01.2017.
 */
package utils
{

import flash.display.Sprite;
import flash.text.TextField;

public class Log extends Sprite
{
	private static const _NUM_LINES_LIMIT:int = 30;

	private static var _textField:TextField = new TextField();
	private static var _timeBegun:int;

	public function Log(width:Number, height:Number)
	{
		_textField.width = width;
		_textField.height = height;
		_textField.border = true;
		_textField.selectable = false;
		addChild(_textField);
		_textField.text = '';

		_timeBegun = new Date().getTime();

		add(' - Log was added ');
	}

	public static function add(inputStr:String):void
	{
		trace(inputStr);

		var timeFromBegun:int = new Date().getTime() - _timeBegun;
		var str:String = '[' + timeFromBegun + '] : ' + inputStr;

		if(_textField.text)
			str += '\n' + _textField.text;

		_textField.text = str;

		if(TextField(_textField).numLines > _NUM_LINES_LIMIT)
			TextField(_textField).scrollV --;
	}
}
}
