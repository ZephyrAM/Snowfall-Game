package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Game extends MovieClip
	{
		static var personGroup:Array;
		static var enemyGroup:Array;
		
		static var player:MovieClip;
		var snowFlake:MovieClip;
		
		var enemyTimer:Number = 10;
		var personTimer:Number = 10;
		var shotTimer:Number = 20;
		
		function Game() 
		{
			Key.initialize(stage);
			
			player = new Player();
			
			addChild(player);
			
			personGroup = new Array();
			enemyGroup = new Array();
			
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		function gameLoop(e:Event)
		{
			shotTimer++;
			enemyTimer++;
			personTimer++;
			
			addEventListener(Event.ENTER_FRAME, tickEnemy);
			addEventListener(Event.ENTER_FRAME, tickPerson);
			stage.addEventListener(MouseEvent.CLICK, playerShot);
		}
		
		function tickPerson(e:Event)
		{
			if(personTimer > 60)
			{
				var person:MovieClip = new People();
				addChild(person);
				personGroup.push(person);
				personTimer = 0;
			}
		}
		function tickEnemy(e:Event)
		{
			if(enemyTimer > 100)
			{
				var enemy:MovieClip = new Enemy();		
				addChild(enemy);
				enemyGroup.push(enemy);
				enemyTimer = 0;
			}
		}
		
		function playerShot(e:MouseEvent)
		{
			if(shotTimer > 20)
			{				
				snowFlake = new SnowFlakes();
				addChild(snowFlake);
				
				snowFlake.angle = Math.atan2(stage.mouseY - (player.y), stage.mouseX - player.x);
				
				snowFlake.newX = stage.mouseX;
				snowFlake.newY = Math.sin(snowFlake.angle) * (snowFlake.speedY / Math.sin(snowFlake.angle));
				snowFlake.newY *= -1;
				shotTimer = 0;
			}
		}
	}
}
