package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import flixel.util.FlxSave;
import flixel.FlxG;

class Main extends Sprite
{
	// public static var ads:Ads;
	/**
	 *  save slot
	 */
	public static var ss:FlxSave;
	public static var testserver:Bool=false;
	public static var lastrefresh:Float=0;
	public static var lasttry:Float=0;
	public static var namekurs:Array<String>=["namekurs","USD","EUR","JPY","CNY"];
	public static var namemetal:Array<String>=["namemetal","Au","Ag","Pt","Pd"];
	public static var namecity:Array<String>=["namecity","MSK","SPB","NSK","EKB","NNV"];
	public static var kurs:Array<String>=["kurs","...","...","...","..."];
	public static var metal:Array<String>=["metal","...","...","...","..."];
	public static var city:Array<String>=["city","...","...","...","...","..."];
	public static var fonnumber:Int=1;
	public static var colornumber:Int=20;
	
	public static function saveall():Void{
		ss=FlxG.save;
		ss.data.namekurs=namekurs;
		ss.data.namemetal=namemetal;
		ss.data.namecity=namecity;
		ss.data.kurs=kurs;
		ss.data.metal=metal;
		ss.data.city=city;
		ss.data.fonnumber=fonnumber;
		ss.data.colornumber=colornumber;
		ss.flush();
	}
	
	public static function loadall():Void{
		ss=FlxG.save;
		if (ss.data.kurs!=null){
			namekurs=ss.data.namekurs;
			namemetal=ss.data.namemetal;
			namecity=ss.data.namecity;
			kurs=ss.data.kurs;
			metal=ss.data.metal;
			city=ss.data.city;
			fonnumber=ss.data.fonnumber;
			colornumber=ss.data.colornumber;
		}
	}
	
	public function new()
	{
		super();
		// ads=new Ads("ca-app-pub-**","interstitialid",30,0,"dn",false);//true = testing ads for app debugging process or can be ban from admob
		addChild(new FlxGame(720, 1280, Terum,true));
	}
}
