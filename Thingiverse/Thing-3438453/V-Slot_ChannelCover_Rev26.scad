//Remix of V-Slot cover for adjustable fit
//2/16/2019 By David Bunch
//Remixed from: https://www.thingiverse.com/thing:832077
//
Test = 0;           //0 = Final Print,  1 = Test Print
Len = 25;          //165 * 3 = 495mm
Qty = 3;
Gap = 3.1;          //3.1 = 1/2 Dimensioned Gap distance where channel connects to V-Slot

V1 = 0.0;           //Thickness at V connection
                    //0.1 would be tighter fit, -0.1 would be looser fit
                    //-.1 works best for me
Z1 =  .25;

A_T1 = [.05, .025, 0, -.025 -.05, -.075];      //Used for Test print
Test_Qty = len(A_T1);
echo(Test_Qty = Test_Qty);

// StampN = 1; // Number of stamps: 0 - no stamps, 1 - one centered, ...
StampText = "@"; // Set to empty string to use image
StampImage = "bear1.png"; // Used only if StampText is empty
StampColor = "Red";
StampDepth = 0.3; // 0.8 - Maximum 
StampHeight = 4.2; // Define size of text or image height

// Setting number of stamps automatic by slot length and text lenght

ll = len(StampText)>0 ? len(StampText) : 1;

StampN = (Test==1) ? 1 : Len/(5*ll);


module V2020(V_Ht = Len)
{
    rotate([0,-90,0])
    rotate([0,0,-90])
    translate([0,10,0])
    difference()
    {
        linear_extrude(height = V_Ht, center = false, convexity = 10)polygon(points = 
        [[10,10],[10,4.9],[8.2,3.1],[8.2,5.5],[6.56,5.5],
        [3.9,2.84],[3.9,-2.84],[6.56,-5.5],[8.2,-5.5],[8.2,-3.1],
        [10,-4.9],[10,-10],[4.9,-10],[3.1,-8.2],[5.5,-8.2],
        [5.5,-6.56],[2.84,-3.9],[-2.84,-3.9],[-5.5,-6.56],[-5.5,-8.2],
        [-3.1,-8.2],[-4.9,-10],[-10,-10],[-10,-4.9],[-8.2,-3.1],
        [-8.2,-5.5],[-6.56,-5.5],[-3.9,-2.84],[-3.9,2.84],[-6.56,5.5],
        [-8.2,5.5],[-8.2,3.1],[-10,4.9],[-10,10],[-4.9,10],
        [-3.1,8.2],[-5.5,8.2],[-5.5,6.56],[-2.84,3.9],[2.84,3.9],
        [5.5,6.56],[5.5,8.2],[3.1,8.2],[4.9,10]]);
        translate([0,0,-1])
        cylinder(d=4.2,h=V_Ht+2,center=false,$fn=16);
    }
}
module Channel(T1 = -.1, Y1 = Z1)
{
    X1 = Gap + T1;
    echo(X1 = X1);
    echo(X1 * 2);
    rotate([0,-90,0])
    rotate([0,0,-90])
    linear_extrude(height = Len, center = false, convexity = 10)
	polygon(points = 
    [[3.13+T1,5.37],[3.34+T1,5],[3.34+T1,2.7],[3.1+T1,1.8],[3.5+T1,0.5+Y1],
    [3+T1,Y1],[-3-T1,Y1],[-3.5-T1,0.5+Y1],[-3.1-T1,1.8],[-3.34-T1,2.7],
    [-3.34-T1,5],[-3.13-T1,5.37],[-2.7-T1,5.37],[-2.49-T1,5],[-2.49-T1,2.81],
    [-1.97-T1,.8+Y1],[1.97+T1,.8+Y1],[2.49+T1,2.81],[2.49+T1,5],[2.7+T1,5.37]]);
	
}

module Stamps() {
	if (StampN > 0) {
		StampN = ceil(StampN);
		dX = Len / StampN;
		X1 = -Len/2 + dX/2;
		for (n=[0:1:StampN-1]) {
			translate([X1 + n*dX,0,0])
			Stamp() {
				children();
			}
		}
	}
}

module Stamp() {
	color(StampColor)
	translate([-Len/2, 0, Z1 + StampDepth - 0.001])
	resize([0,StampHeight,StampDepth], auto=[true,false,false])
	rotate([0,180,0])
	children();
}

if (Test == 0)
{
    translate([Len/2,0,0])
    %V2020();
    for (i = [0:Qty-1])
    {
        translate([Len/2,i * 9,0])
				difference() {
					Channel(V1,Z1);
					Stamps() {
						if (StampText > "") {
							linear_extrude(1)
							text(StampText, halign="center", valign="center");
						} else if (StampImage > "") {
							translate([0,0,100+1]) mirror([0,0,1])
							surface(StampImage, center=true);
						}
					}
				}
    }
} else if (Test == 1)
{
    translate([Len/2,0,0])
    %V2020();
    for (i = [0:Test_Qty-1])
    {
        translate([Len/2,i * 9,0])
				difference() {
					Channel(A_T1[i],Z1);
					Stamps() {
						scale([0.61,1,1])
						linear_extrude(1)
						text(str("V1=",A_T1[i]), halign="center", valign="center");
					}
				}
    }
}