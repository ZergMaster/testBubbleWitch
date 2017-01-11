/**
 * Created by ZergMaster on 08.01.2017.
 */
package game
{

import flash.display.Sprite;

import game.balls.BallGun;
import game.balls.UpperBalls;

public class Game extends Sprite
{
	public function Game()
	{
		var balls:UpperBalls = new UpperBalls();
		addChild(balls);

		var ballGun:BallGun = new BallGun();
		addChild(ballGun);
	}
}
}
