/**
 * Created by ZergMaster on 08.01.2017.
 */
package com.testBubbleWitchSaga.game
{

import flash.display.Sprite;

import com.testBubbleWitchSaga.game.balls.BallGun;
import com.testBubbleWitchSaga.game.balls.UpperBalls;

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
