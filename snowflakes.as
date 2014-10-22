package
{
	import flash.display.*;
	import flash.events.*;
	
	public class SnowFlakes extends MovieClip
	{
		var speedX,speedY,speedR:Number;
		var newX,newY:Number;
		var angle:Number;
		
		var target:MovieClip;
		
		function SnowFlakes()
		{			
			this.x = Game.player.x;
			this.y = Game.player.y;
			
			this.speedR = 6;
			this.speedX = 40;
			this.speedY = 2;
			
			addEventListener(Event.ENTER_FRAME, movement);
		}
		
		function movement(e:Event)
		{
			this.rotationZ += speedR;
			
			if(newY < 3)
			{
				newY += .2;
			}
			
			this.x += (this.newX - this.x) / this.speedX;
			this.y += newY;
		
			if(this.y > stage.stageHeight + (this.height * 2))
			{
				removeEventListener(Event.ENTER_FRAME, movement);
				
				this.parent.removeChild(this);
			}
			else if(this.x < stage.x - (this.width * 2) || this.x > stage.stageWidth + (this.width * 2))
			{
				removeEventListener(Event.ENTER_FRAME, movement);
				
				this.parent.removeChild(this);
			}
			
			for(var n:Number = 0;n < Game.enemyGroup.length;n++)
			{
				if(this.hitTestObject(Game.enemyGroup[n]))
				{
					this.target = Game.enemyGroup[n];
					this.target.hit = true;
					
					removeEventListener(Event.ENTER_FRAME, movement);
					this.parent.removeChild(this);
					
					break;
				}
			}
		}
	}
}
