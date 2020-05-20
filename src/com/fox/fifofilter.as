import com.Utils.LDBFormat;
import com.Utils.SignalGroup;
import com.Utils.Slot;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
 
class com.fox.fifofilter
{
	static var Filters:Array;
	public static function main(swfRoot:MovieClip):Void
	{
		var s_mod:fifofilter = new fifofilter();
		swfRoot.onLoad = function(){s_mod.HookSpaghetti()};
	}

	public function fifofilter()
	{
		Filters = [
			LDBFormat.LDBGetText(100, 59164832).split(".")[1], // You will need to spend some of this currency before you can earn any more.
			LDBFormat.LDBGetText(100, 78153876), // There are no valid targets in range.
			LDBFormat.LDBGetText(100, 255695508), // Interrupted!
			LDBFormat.LDBGetText(120, 32539732) // Cannot use this ability.
			
		]
	}
	public function HookSpaghetti():Void
	{
		if(_root.fifo._SlotShowFIFOMessage) return
		if (!_root.fifo)
		{
			setTimeout(Delegate.create(this, HookSpaghetti), 500);
			return;
		}
		_root.fifo._SlotShowFIFOMessage = _root.fifo.SlotShowFIFOMessage;
		_root.fifo.SlotShowFIFOMessage = function(text:String, mode:Number){
			for (var i in fifofilter.Filters)
			{
				if (text.indexOf(fifofilter.Filters[i]) >= 0)
				{
					return;
				}
			}
			this._SlotShowFIFOMessage(text, mode);
		}
		// private arrray m_Connections
		for (var i in _root.fifo.m_SignalGroup["m_Connections"])
		{
			var slot:Slot = _root.fifo.m_SignalGroup["m_Connections"][i];
			if (slot["m_Callback"] == _root.fifo._SlotShowFIFOMessage)
			{
				slot["m_Callback"] = _root.fifo.SlotShowFIFOMessage;
			}
		}
	}
}