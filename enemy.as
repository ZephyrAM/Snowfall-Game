package  
{
	import flash.display.*;
	import flash.events.*;
	
	public class Enemy extends MovieClip
	{
		var speedX,speedY:Number;
		var moveDir:Number;
		var hit:Boolean = false;
		
		var target:MovieClip;
		var targetDistX,targetDistY,targetIndex:Number;
		var targetTime:Number = 0;
		var targetValid:Boolean = false;

		function Enemy() 
		{
			moveDir = Math.floor(Math.random() * 100) + 1;
			if(moveDir <= 50)
			{
				this.x = 630;
			}
			else if(moveDir > 50)
			{
				this.x = -30;
			}
			this.y = Math.floor(Math.random() * 200) + 100;
			this.speedX = 5;
			this.speedY = 2;
			
			targetCheck();
			
			addEventListener(Event.ENTER_FRAME,movement);
		}
		
		function movement(e:Event)
		{
			if(this.hit == true)
			{
				removeEventListener(Event.ENTER_FRAME,movement);
				
				if(this.target != null)
				{
					if(this.target.capture == true)
					{
						this.target.saved = true;
					}
					invalidTarget();
				}
				
				Game.enemyGroup.splice(Game.enemyGroup.indexOf(this),1);
				this.parent.removeChild(this);
				
				return;
			}
			
			if(this.hitTestObject(this.target))
			{
				this.target.capture = true;
				 
				this.speedX = 3;
				this.speedY = 1;
				
				if(this.moveDir <= 50)
				{
					this.x -= speedX;
					this.y -= speedY;
				}
				else if(this.moveDir > 50)
				{
					this.x += speedX;
					this.y -= speedY;
				}
				
				if(this.x < stage.x - (this.width * 2) || this.x > stage.stageWidth + (this.width * 2))
				{
					removeEventListener(Event.ENTER_FRAME,movement);
					this.target.removeEventListener(Event.ENTER_FRAME,movement);
					
					Game.personGroup.splice(Game.personGroup.indexOf(this.target),1);
					this.parent.removeChild(this.target);
					
					Game.enemyGroup.splice(Game.enemyGroup.indexOf(this),1);
					this.parent.removeChild(this);
				}
			}
			else
			{
				if(this.x < stage.x - (this.width * 2) || this.x > stage.stageWidth + (this.width * 2))
				{
					removeEventListener(Event.ENTER_FRAME,movement);
					
					Game.enemyGroup.splice(Game.enemyGroup.indexOf(this),1);
					this.parent.removeChild(this);
				}
				
				targetDistX = this.target.x - this.x;
				targetDistY = this.target.y - this.y;
				
				if(targetDistX < 0)
				{
					targetDistX *= -1;
				}
				if(targetDistY < 0)
				{
					targetDistY *= -1;
				}

				targetTime = targetDistX / (this.target.speedX + this.speedX);
				this.speedY = targetDistY / targetTime;

				if(this.moveDir > 50 && this.target.moveDir > 50)
				{
					if(this.x > this.target.x)
					{
						invalidTarget();
						this.x += this.speedX;
					}
					else if(this.x < this.target.x)
					{
						this.x += this.speedX;
					}
				}
				else if(this.moveDir > 50 && this.target.moveDir <= 50)
				{
					if(this.x > this.target.x)
					{
						invalidTarget();
						this.x += this.speedX;
					}
					else if(this.x < this.target.x)
					{
						this.x += this.speedX;
					}
						
				}
				else if(this.moveDir <= 50 && this.target.moveDir > 50)
				{
					if(this.x > this.target.x)
					{
						this.x -= this.speedX;
					}
					else if(this.x < this.target.x)
					{
						invalidTarget();
						this.x -= this.speedX;
					}
				}
				else if(this.moveDir <= 50 && this.target.moveDir <= 50)
				{
					if(this.x > this.target.x)
					{
						this.x -= this.speedX;
					}
					else if(this.x < this.target.x)
					{
						invalidTarget();
						this.x -= this.speedX;
					}
				}
				

				
				if(this.target.y > this.y)
				{
					this.y += this.speedY;
				}
				else if(this.target.y < this.y)
				{
					this.y -= this.speedY;
				}
			}
		}
		
		function invalidTarget()
		{
			this.targetValid = false;
			this.target.attackExist = false;
			this.target.attacker = null;
			
			this.speedX = 4;
			this.speedY = 0;
		}
		function targetCheck()
		{			
			while(this.targetValid == false)
			{
				targetIndex = Math.floor(Math.random() * (Game.personGroup.length));
				if(Game.personGroup[targetIndex].attackExist == false)
				{
					targetValid = true;
				}
			}
			
			this.target = Game.personGroup[targetIndex];   
			this.target.attackExist = true;
			this.target.attacker = this;
		}
	}
}
