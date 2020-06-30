package;

import flixel.util.FlxColor as FC;

class MunsellContrast20 {
    /**
     *  array of color 0,1...20,21,22
     */
    public var c:Array<FC>=new Array();
    /**
     *  array of opposite color for 0,1...20,21,22
     */
    public var o:Array<FC>=new Array();
    /**
     *  array of arrays of [color,opposite color] for 0,1...20,21,22
     */
    var co:Array<Array<FC>>=new Array();
    
    public function new() {
        c[0]=FC.fromInt(0xff000000);
        c[1]=FC.fromInt(0xfff2003c);
        c[2]=FC.fromInt(0xfff85900);
        c[3]=FC.fromInt(0xfff28800);
        c[4]=FC.fromInt(0xfff2ab00);
        c[5]=FC.fromInt(0xffefcc00);
        c[6]=FC.fromInt(0xfff0ea00);
        c[7]=FC.fromInt(0xffb1d700);
        c[8]=FC.fromInt(0xff00ca24);
        c[9]=FC.fromInt(0xff00a877);
        c[10]=FC.fromInt(0xff00a78a);
        c[11]=FC.fromInt(0xff00a59c);
        c[12]=FC.fromInt(0xff00a3ac);
        c[13]=FC.fromInt(0xff0093af);
        c[14]=FC.fromInt(0xff0082b2);
        c[15]=FC.fromInt(0xff006ebf);
        c[16]=FC.fromInt(0xff7d00f8);
        c[17]=FC.fromInt(0xff9f00c5);
        c[18]=FC.fromInt(0xffb900a6);
        c[19]=FC.fromInt(0xffd00081);
        c[20]=FC.fromInt(0xffe20064);
        c[21]=FC.fromInt(0xffffffff);
        c[22]=FC.fromInt(0xff939393);
        //opposite colors
        o[0]=c[22];
        o[1]=c[11];
        o[2]=c[12];
        o[3]=c[13];
        o[4]=c[14];
        o[5]=c[15];
        o[6]=c[16];
        o[7]=c[17];
        o[8]=c[18];
        o[9]=c[19];
        o[10]=c[20];
        o[11]=c[1];
        o[12]=c[2];
        o[13]=c[3];
        o[14]=c[4];
        o[15]=c[5];
        o[16]=c[6];
        o[17]=c[7];
        o[18]=c[8];
        o[19]=c[9];
        o[20]=c[10];
        o[21]=c[0];
        o[22]=c[21];
        for (i in 0...23){ co[i]=[c[i],o[i]]; }
    }
}