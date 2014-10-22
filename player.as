package  
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Player extends MovieClip
	{
		var dy:Number = 0;
		var float:Number = .2;
		var moveSpeed:Number = 3;
		
		function Player()
		{
			this.x = 290;
			this.y = 30;
			
			addEventListener(Event.ENTER_FRAME, move);
		}
		
		function move(e:Event)
		{
			if(this.x <= (stage.x + (this.width / 2)))
			{
				this.x = stage.x + (this.width / 2);
			}
			else if(this.x >= stage.stageWidth - (this.width / 2))
			{
				this.x = stage.stageWidth - (this.width / 2);
			}
			
			if(Key.isDown(Keyboard.RIGHT) || Key.isDown(Keyboard.LEFT))
			{
				dy += float;
				this.y += dy;
				if(dy >= 3 || dy <= -3)
				{
					float *= -1;
				}
			}
			
			if(Key.isDown(Keyboard.RIGHT))
			{
				this.x += moveSpeed;
			}
			if(Key.isDown(Keyboard.LEFT))
			{
				this.x -= moveSpeed;
			}
		}
	}
}
