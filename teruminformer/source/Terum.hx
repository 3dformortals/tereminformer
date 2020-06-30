package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Http;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween; //fon moving
import flixel.tweens.FlxEase;

class Terum extends FlxState {
    
    var kursname:Array<FlxText>=new Array();
    var kurs:Array<FlxText>=new Array();
    var metalname:Array<FlxText>=new Array();
    var metal:Array<FlxText>=new Array();
    var cityname:Array<FlxText>=new Array();
    var city:Array<FlxText>=new Array();
    var webanifon:Array<FlxSprite>=new Array();
    var webani:Array<FlxSprite>=new Array();
    var stone:FlxSprite;
    var stonelights:FlxSprite;
    var information:FlxSprite; //sprite which show infotext, btn i press
    var fonup:FlxSprite;
    var fondn:FlxSprite;
    var rescue:FlxText;
    var message:FlxText;
    var mounit:FlxText;
    var meunit:FlxText;
    var tcolor:FlxColor;
    var colorgroup:FlxTypedGroup<FlxText>; //texts
    var fongroup:FlxTypedGroup<FlxSprite>; //sferes fon
    var anigroup:FlxTypedGroup<FlxSprite>; //sferes
    var mc:MunsellContrast20=new MunsellContrast20(); //color keeper
    
    function tsmaker(t:FlxText,color:FlxColor,align:String):Void{
		var fw:Int = 60;
		var style:FlxTextBorderStyle = FlxTextBorderStyle.OUTLINE;
		// t.fieldWidth=tfw;
		t.setFormat("assets/data/RobotoMono-Bold.ttf", fw, color);
		// t.alignment = CENTER;
        switch(align){
            case "l":t.alignment=LEFT;
            case "r":t.alignment=RIGHT;
            default:t.alignment=CENTER;
        }
        
		add(t);
	}
    
    function screentextmaker():Void{
        tcolor=FlxColor.WHITE;
        message=new FlxText(160,80,400,"актуально"); tsmaker(message,tcolor,"c");
        rescue=new FlxText(400,240,320,"единая\nслужба\nспасения\n112  911"); tsmaker(rescue,tcolor,"c");
        mounit=new FlxText(120,160,240,"RUB"); tsmaker(mounit,tcolor,"l");
        meunit=new FlxText(120,1040,240,"RUB/g"); tsmaker(meunit,tcolor,"l");
        
        var x:Array<Int>=[0,0,0,0,0]; var y:Array<Int>=[0,240,320,400,480];
        for (i in 1...5){kursname[i]=new FlxText(x[i],y[i],120,Main.namekurs[i]);tsmaker(kursname[i],tcolor,"l");}
        x=[0,120,120,120,120]; y=[0,240,320,400,480];
        for (i in 1...5){kurs[i]=new FlxText(x[i],y[i],200,Main.kurs[i]);tsmaker(kurs[i],tcolor,"r");}
        
        x=[0,0,0,0,0]; y=[0,720,800,880,960];
        for (i in 1...5){metalname[i]=new FlxText(x[i],y[i],80,Main.namemetal[i]);tsmaker(metalname[i],tcolor,"l");}
        x=[0,80,80,80,80]; y=[0,720,800,880,960];
        for (i in 1...5){metal[i]=new FlxText(x[i],y[i],240,Main.metal[i]);tsmaker(metal[i],tcolor,"r");}
        
        x=[0,400,400,400,400,400]; y=[0,720,800,880,960,1040];
        for (i in 1...6){cityname[i]=new FlxText(x[i],y[i],120,Main.namecity[i]);tsmaker(cityname[i],tcolor,"l");}
        x=[0,520,520,520,520,520]; y=[0,720,800,880,960,1040];
        for (i in 1...6){city[i]=new FlxText(x[i],y[i],200,Main.city[i]);tsmaker(city[i],tcolor,"l");}
        
    }
    
    function datarefreshmaker(s:String):Void{
        var ss:Array<String>=s.split(" ");
        if (ss.length==20){
            var kurs:Array<String>=["kurs",ss[3],ss[4],ss[5],ss[6]];
            var metal:Array<String>=["metal",ss[9],ss[10],ss[11],ss[12]];
            var city:Array<String>=["city",ss[15],ss[16],ss[17],ss[18],ss[19]];
            for (i in 1...5){
                Main.kurs[i]=kurs[i];
                Main.metal[i]=metal[i];
                Main.city[i]=city[i];
            }
            Main.city[5]=city[5];
            Main.saveall();
            message.text="актуально";
        }
        else{
            message.text="сбой сети";
        }
    }
    
    function getwebdataandrefresh():Void{
        var serverlink:String;
        if (Main.testserver){serverlink="http://127.0.0.1:8000/informer/teruminformer/";}
        else {serverlink="http://stts.pythonanywhere.com/informer/teruminformer/";}
        
        var req:Http = new Http(serverlink);
        req.setParameter("kurs1", Main.namekurs[1]);
        req.setParameter("kurs2", Main.namekurs[2]);
        req.setParameter("kurs3", Main.namekurs[3]);
        req.setParameter("kurs4", Main.namekurs[4]);
        req.setParameter("metal1", Main.namemetal[1]);
        req.setParameter("metal2", Main.namemetal[2]);
        req.setParameter("metal3", Main.namemetal[3]);
        req.setParameter("metal4", Main.namemetal[4]);
        req.setParameter("city1", Main.namecity[1]);
        req.setParameter("city2", Main.namecity[2]);
        req.setParameter("city3", Main.namecity[3]);
        req.setParameter("city4", Main.namecity[4]);
        req.setParameter("city5", Main.namecity[5]);
        req.request( true );
        var s:String=req.responseData;
        datarefreshmaker(s);
    }
    
    function screendatarefresh():Void{
        for (i in 1...6){
            if (i<5){
                kursname[i].text=Main.namekurs[i];
                kurs[i].text=Main.kurs[i];
                metalname[i].text=Main.namemetal[i];
                metal[i].text=Main.metal[i];
            }
            cityname[i].text=Main.namecity[i];
            city[i].text=Main.city[i];
        }
    }
    
    function screenwebanimaker():Void{
        var x:Array<Int>=[0,0,630,0,630];
        var y:Array<Int>=[0,160,160,1040,1040];
        var af:Array<Int>=[for (i in 0...10) i];
        var back:Bool=true;
        for (i in 1...5){
            webanifon[i]=new FlxSprite(x[i],y[i],"assets/images/ani_web_fon90.png");
            add(webanifon[i]);
            webani[i]=new FlxSprite(x[i],y[i]);
            webani[i].loadGraphic("assets/images/ani_web.png",true,90,90);
            back=back?false:true;
            webani[i].animation.add("ani",af,24,true,back);
            webani[i].animation.play("ani");
            add(webani[i]);
        }
        var llll:FlxSprite=new FlxSprite(280,0);
        llll.loadGraphic("assets/images/ani_llll.png",true,160,80);
        llll.animation.add("tik",[0,1,2,3,2,1,0,4,5,6,5,4],12,true);
        llll.animation.play("tik");
        add(llll);
    }
    
    function changefon():Void{
        if (Main.fonnumber<29){ Main.fonnumber+=1; }else{Main.fonnumber=1;}
        fonup.loadGraphic("assets/images/fon/fon"+Std.string(Main.fonnumber)+"up_960640.png");
        fondn.loadGraphic("assets/images/fon/fon"+Std.string(Main.fonnumber)+"dn_960640.png");
    }
    
    function changecolor():Void{
        if (Main.colornumber<22){Main.colornumber+=1;}else{Main.colornumber=0;}
        for (t in colorgroup){
            t.color=mc.c[Main.colornumber];
        }
        for (s in fongroup){s.color=mc.c[Main.colornumber];}
        anigroup.forEach(function(s){s.color=mc.o[Main.colornumber];});
        fonup.color=mc.o[Main.colornumber];
        fondn.color=mc.o[Main.colornumber];
    }
    
    function showhideinfo():Void{
        if (information.visible){information.visible=false;information.kill();}
        else{information.visible=true;add(information);information.reset(0,160);}
    }
    
    function tryrefresh():Void{
        var needrefresh:Float=Date.now().getTime();
        if (needrefresh-Main.lastrefresh>600000 && needrefresh - Main.lasttry>2000){
            //10 minutes = 600000
            getwebdataandrefresh();screendatarefresh();
            if (message.text!="сбой сети"){
                message.text="актуально";
                Main.lastrefresh=needrefresh;
            }
        }
        else{
            if (message.text!="сбой сети"){ message.text="рано";}
            
        }
        Main.lasttry=Date.now().getTime();
    }
    
    function btnmaker():Void{
        var b:FlxButton;
        var url:String;
        var x:Array<Int>=[0,0,640,0,640];
        var y:Array<Int>=[0,160,160,1040,1040];
        var z:Array<String>=new Array();
        z[1]="http://www.cbr.ru/currency_base/daily.aspx?date_req=12.31";
        z[2]="http://112.mchs.ru/how-to-use";
        z[3]="http://cbr.ru/hd_base/metall/metall_base_new/";
        z[4]="http://www.openweathermap.com/weathermap?basemap=satellite&cities=true&layer=temperature&lat=62.7547&lon=69.2578&zoom=3";
        for (i in 1...5){
            b=new FlxButton(x[i],y[i],"",function():Void{FlxG.openURL(z[i],"_blank");});
            b.loadGraphic("assets/images/glass80.png");
            add(b);
        }
        url="https://play.google.com/store/apps/developer?id=llll";
        b=new FlxButton(280,0,"",function():Void{FlxG.openURL(url,"_blank");});
        b.loadGraphic("assets/images/glass16080.png");
        // add(b);
        
        b=new FlxButton(320,160,"",changefon);
        b.loadGraphic("assets/images/glass80.png");
        add(b);
        
        b=new FlxButton(280,560,"",changecolor);
        b.loadGraphic("assets/images/glass160.png");
        add(b);
        
        b=new FlxButton(560,0,"",showhideinfo);
        b.loadGraphic("assets/images/glass160.png");
        add(b);
        
        b=new FlxButton(0,0,"",tryrefresh);
        b.loadGraphic("assets/images/glass160.png");
        add(b);
        
    }
    
    function colorgroupmaker():Void{
        for (x in 1...6){
            if (x<5){
                colorgroup.add(kursname[x]);
                colorgroup.add(kurs[x]);
                colorgroup.add(metalname[x]);
                colorgroup.add(metal[x]);
                anigroup.add(webani[x]);
                
            }
            colorgroup.add(cityname[x]);
            colorgroup.add(city[x]);
        }
        colorgroup.add(rescue);
        colorgroup.add(message);
        colorgroup.add(mounit);
        colorgroup.add(meunit);
    }
    
    function fongroupmaker():Void{
        for (i in 1...5){
            fongroup.add(webanifon[i]);
        }
        fongroup.add(stone);
    }
    
    public override function create():Void {
        super.create();
        Main.loadall();
        // extension.wakeLock.WakeLock.allowScreenTimeout = false;
        // FlxG.log.redirectTraces = true;
        fonup=new FlxSprite(0,0,"assets/images/fon/fon"+Std.string(Main.fonnumber)+"up_960640.png"); add(fonup);
        fondn=new FlxSprite(0,640,"assets/images/fon/fon"+Std.string(Main.fonnumber)+"dn_960640.png"); add(fondn);
        FlxTween.tween(fonup, { x: -240 }, 15.0, { type: FlxTweenType.PINGPONG });
        FlxTween.tween(fondn, { x: -240 }, 15.0, { type: FlxTweenType.PINGPONG });
        var sword:FlxSprite=new FlxSprite(0,140,"assets/images/sword7201000.png"); add(sword);
        stone=new FlxSprite(280,560,"assets/images/stone160.png"); add(stone);
        stonelights=new FlxSprite(280,560,"assets/images/stonelights160.png"); add(stonelights);
		var groundstone:FlxSprite=new FlxSprite(0,1120,"assets/images/stone720160.png"); add(groundstone);
        var info:FlxSprite=new FlxSprite(560,0,"assets/images/info160.png"); add(info);
        var refresh:FlxSprite=new FlxSprite(0,0,"assets/images/refresh160.png"); add(refresh);
        information=new FlxSprite(0,160,"assets/images/info720960.png"); information.visible=false;
        colorgroup=new FlxTypedGroup<FlxText>();
        fongroup=new FlxTypedGroup<FlxSprite>();
        anigroup=new FlxTypedGroup<FlxSprite>();
        screentextmaker();
        getwebdataandrefresh();
        screendatarefresh();
        Main.lastrefresh=Date.now().getTime();
        screenwebanimaker();
        btnmaker();
        
        colorgroupmaker();
        fongroupmaker();
        changecolor();
        // Main.ads.showbanner();
    }
    
    public override function update(elapsed:Float):Void {
        super.update(elapsed);
        if(Date.now().getTime()-Main.lasttry>2000){
            if (message.text=="рано") message.text="актуально";
            else if (message.text=="сбой сети") message.text="обновим?";
        }
        if(Date.now().getTime()-Main.lastrefresh>600000){if (message.text!="обновим?") message.text="обновим?";}
    }
}