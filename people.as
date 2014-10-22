package 
{
	import flash.display.*;
	import flash.events.*;
	
	public class People extends MovieClip
	{
		var speedX,speedY:Number;
		var randomDir,moveDir:Number;
		
		var attacker:MovieClip;
		var attackExist:Boolean = false;
		var capture:Boolean = false;
		var saved:Boolean = false;
		
		
		function People() 
		{
			this.moveDir = Math.floor(Math.random() * 100) + 1;			
			if(this.moveDir > 50)
			{
				this.x = -20;
			}
			else if(this.moveDir <= 50)
			{
				this.x = 620;
			}
			this.y = 360;
			this.speedY = 3;
			this.speedX = Math.floor(Math.random()* 2) + 1;
			
			addEventListener(Event.ENTER_FRAME,movement);
		}
		
		function movement(e:Event)
		{
			if(this.saved == true)
			{
				this.attackExist = true;
				this.capture = false;
				
				if(this.y < 357)
				{
					this.speedX = 0;
					this.y += this.speedY;
				}
				else
				{
					this.speedX = 3;
					this.speedY = 0;
				}
			}
			
			if(this.attackExist == true)
			{
				if(this.capture == true)
				{
					this.x = this.attacker.x;
					this.y = this.attacker.y;
				}
				else
				{
					if(this.x < stage.x - (this.width * 2) || this.x > stage.stageWidth + (this.width * 2))
					{
						removeEventListener(Event.ENTER_FRAME,movement);
						
						Game.personGroup.splice(Game.personGroup.indexOf(this),1);
						this.parent.removeChild(this);
					}
					
					if(this.moveDir > 50)
					{
						this.x += this.speedX;
					}
					else if(this.moveDir <= 50)
					{
						this.x -= this.speedX;
					}
				}
			}
			else
			{
				if(this.x < stage.x - (this.width * 2) || this.x > stage.stageWidth + (this.width * 2))
				{
					removeEventListener(Event.ENTER_FRAME,movement);
					
					Game.personGroup.splice(Game.personGroup.indexOf(this),1);
					this.parent.removeChild(this);
				}
				
				if(this.moveDir > 50)
				{
					this.x += this.speedX;
				}
				else if(this.moveDir <= 50)
				{
					this.x -= this.speedX;
				}
			}
		}
	}
}
