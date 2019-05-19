//Remix of V-Slot cover for adjustable fit
//2/16/2019 By David Bunch
//Remixed from: https://www.thingiverse.com/thing:832077
//
Test = 0;           //0 = Final Print,  1 = Test Print
Len = 165;          //165 * 3 = 495mm
Qty = 3;
Gap = 3.1;          //3.1 = 1/2 Dimensioned Gap distance where channel connects to V-Slot

V1 = 0.05;           //Thickness at V connection
                    //0.1 would be tighter fit, -0.1 would be looser fit
                    //-.1 works best for me
Z1 =  .25;

A_T1 = [.05, .025, 0, -.025 -.05, -.075];      //Used for Test print
Test_Qty = len(A_T1);
echo(Test_Qty = Test_Qty);
module V2020(V_Ht = Len)
{
    rotate([0,-90,0])
    rotate([0,0,-90])
    translate([0,10,0])
    difference()
    {
        linear_extrude(height = V_Ht, center = false, convexity = 10)polygon(points = 
    [[-3.9,-2.84],[-3.9,2.84],[-6.56,5.5],[-8.2,5.5],[-8.2,3.13],
    [-8.55,3.13],[-10,4.58],[-10,10],[-4.58,10],[-3.13,8.55],
    [-3.13,8.2],[-5.5,8.2],[-5.5,6.56],[-2.84,3.9],[2.84,3.9],
    [5.5,6.56],[5.5,8.2],[3.13,8.2],[3.13,8.55],[4.58,10],
    [10,10],[10,4.58],[8.55,3.13],[8.2,3.13],[8.2,5.5],
    [6.56,5.5],[3.9,2.84],[3.9,-2.84],[6.56,-5.5],[8.2,-5.5],
    [8.2,-3.13],[8.55,-3.13],[10,-4.58],[10,-10],[4.58,-10],
    [3.13,-8.55],[3.13,-8.2],[5.5,-8.2],[5.5,-6.56],[2.84,-3.9],
    [-2.84,-3.9],[-5.5,-6.56],[-5.5,-8.2],[-3.13,-8.2],[-3.13,-8.55],
    [-4.58,-10],[-10,-10],[-10,-4.58],[-8.55,-3.13],[-8.2,-3.13],
    [-8.2,-5.5],[-6.56,-5.5]]);
        translate([0,0,-1])
        cylinder(d=4.2,h=V_Ht+2,center=false,$fn=16);
    }
}
module Cbeam(V_Ht = Len)
{
    rotate([0,-90,0])
    rotate([0,0,-90])
    translate([0,10,0])
    difference()
    {
    linear_extrude(height = V_Ht, center = false, convexity = 10)polygon(points = 
    [[14.5,-8.2],[14.5,-6.56],[17.16,-3.9],[22.84,-3.9],[25.5,-6.56],
    [25.5,-8.2],[23.4,-8.2],[23.4,-8.82],[24.58,-10],[28.5,-10],
    [29.07,-9.89],[29.56,-9.56],[29.89,-9.07],[30,-8.5],[30,-4.58],
    [28.82,-3.4],[28.2,-3.4],[28.2,-5.5],[26.56,-5.5],[23.9,-2.84],
    [23.9,2.84],[26.56,5.5],[28.2,5.5],[28.2,3.4],[28.82,3.4],
    [30,4.58],[30,8.5],[29.89,9.07],[29.56,9.56],[29.07,9.89],
    [28.5,10],[24.58,10],[23.4,8.82],[23.4,8.2],[25.5,8.2],
    [25.5,6.56],[22.84,3.9],[17.16,3.9],[14.5,6.56],[14.5,8.2],
    [16.61,8.2],[16.61,8.82],[15.42,10],[10,10],[10,15.42],
    [8.82,16.61],[8.2,16.61],[8.2,14.5],[6.56,14.5],[3.9,17.16],
    [3.9,22.84],[6.56,25.5],[8.2,25.5],[8.2,23.4],[8.82,23.4],
    [10,24.58],[10,35.42],[8.82,36.61],[8.2,36.61],[8.2,34.5],
    [6.56,34.5],[3.9,37.16],[3.9,42.84],[6.56,45.5],[8.2,45.5],
    [8.2,43.4],[8.82,43.4],[10,44.58],[10,50],[15.42,50],
    [16.61,51.19],[16.61,51.8],[14.5,51.8],[14.5,53.44],[17.16,56.1],
    [22.84,56.1],[25.5,53.44],[25.5,51.8],[23.4,51.8],[23.4,51.19],
    [24.58,50],[28.5,50],[29.07,50.11],[29.56,50.44],[29.89,50.93],
    [30,51.5],[30,55.42],[28.82,56.61],[28.2,56.61],[28.2,54.5],
    [26.56,54.5],[23.9,57.16],[23.9,62.84],[26.56,65.5],[28.2,65.5],
    [28.2,63.4],[28.82,63.4],[30,64.58],[30,68.5],[29.89,69.07],
    [29.56,69.56],[29.07,69.89],[28.5,70],[24.58,70],[23.4,68.82],
    [23.4,68.2],[25.5,68.2],[25.5,66.56],[22.84,63.9],[17.16,63.9],
    [14.5,66.56],[14.5,68.2],[16.61,68.2],[16.61,68.82],[15.42,70],
    [4.58,70],[3.4,68.82],[3.4,68.2],[5.5,68.2],[5.5,66.56],
    [2.84,63.9],[-2.84,63.9],[-5.5,66.56],[-5.5,68.2],[-3.4,68.2],
    [-3.4,68.82],[-4.58,70],[-8.5,70],[-9.07,69.89],[-9.56,69.56],
    [-9.89,69.07],[-10,68.5],[-10,64.58],[-8.82,63.4],[-8.2,63.4],
    [-8.2,65.5],[-6.56,65.5],[-3.9,62.84],[-3.9,57.16],[-6.56,54.5],
    [-8.2,54.5],[-8.2,56.61],[-8.82,56.61],[-10,55.42],[-10,44.58],
    [-8.82,43.4],[-8.2,43.4],[-8.2,45.5],[-6.56,45.5],[-3.9,42.84],
    [-3.9,37.16],[-6.56,34.5],[-8.2,34.5],[-8.2,36.61],[-8.82,36.61],
    [-10,35.42],[-10,24.58],[-8.82,23.4],[-8.2,23.4],[-8.2,25.5],
    [-6.56,25.5],[-3.9,22.84],[-3.9,17.16],[-6.56,14.5],[-8.2,14.5],
    [-8.2,16.61],[-8.82,16.61],[-10,15.42],[-10,4.58],[-8.82,3.4],
    [-8.2,3.4],[-8.2,5.5],[-6.56,5.5],[-3.9,2.84],[-3.9,-2.84],
    [-6.56,-5.5],[-8.2,-5.5],[-8.2,-3.4],[-8.82,-3.4],[-10,-4.58],
    [-10,-8.5],[-9.89,-9.07],[-9.56,-9.56],[-9.07,-9.89],[-8.5,-10],
    [-4.58,-10],[-3.4,-8.82],[-3.4,-8.2],[-5.5,-8.2],[-5.5,-6.56],
    [-2.84,-3.9],[2.84,-3.9],[5.5,-6.56],[5.5,-8.2],[3.4,-8.2],
    [3.4,-8.82],[4.58,-10],[15.42,-10],[16.61,-8.82],[16.61,-8.2],
    [14.5,-8.2]]);
    for (y = [0,1])
    {
        translate([0,y*40,0])
        mirror([y,0,0])
        translate([0,0,-1])
        linear_extrude(height = V_Ht+2, center = false, convexity = 10)polygon(points = 
        [[-5.94,13],[-2.84,16.1],[2.84,16.1],[5.94,13],[8.2,13],
        [8.2,9.26],[2.84,3.9],[-2.84,3.9],[-5.94,7],[-8.2,7],
        [-8.2,13]]);
        translate([0,y*60,0])
        mirror([0,y,0])
        translate([0,0,-1])
        linear_extrude(height = V_Ht+2, center = false, convexity = 10)polygon(points = 
        [[16.1,2.84],[13,5.94],[13,8.2],[9.26,8.2],[3.9,2.84],
        [3.9,-2.84],[7,-5.94],[7,-8.2],[13,-8.2],[13,-5.94],
        [16.1,-2.84],[16.1,2.84]]);
    }
        translate([0,0,-1])
        linear_extrude(height = V_Ht+2, center = false, convexity = 10)polygon(points = 
        [[-2.84,23.9],[-5.94,27],[-8.2,27],[-8.2,33],[-5.94,33],
        [-2.84,36.1],[2.84,36.1],[5.94,33],[8.2,33],[8.2,27],
        [5.94,27],[2.84,23.9]]);
        for (y = [0,20,40,60])
        {
            translate([0,y,-1])
            cylinder(d=4.2,h=V_Ht+2,center=false,$fn=16);
        }
        for (y = [0,60])
        {
            translate([20,y,-1])
            cylinder(d=4.2,h=V_Ht+2,center=false,$fn=16);
        }
    }
}

module Channel(T1 = -.1, Y1 = Z1)
{
    X1 = Gap + T1;
    echo(X1 = X1);
    echo(X1 * 2);
    rotate([0,-90,0])
    rotate([0,0,-90])
    linear_extrude(height = Len, center = false, convexity = 10)polygon(points = 
    [[-3.4-T1,1.8],[-3.63-T1,2.7],[-3.63-T1,4.71],[-3.42-T1,5.08],[-3-T1,5.08],
    [-2.78-T1,4.71],[-2.78-T1,2.81],[-2.25-T1,0.8+Y1],[2.25+T1,0.8+Y1],[2.78+T1,2.81],
    [2.78+T1,4.71],[3+T1,5.08],[3.42+T1,5.08],[3.63+T1,4.71],[3.63+T1,2.7],
    [3.4+T1,1.8],[3.4+T1,1.19],[3.5++T1,0.5+Y1],[3+T1,Y1],[-3-T1,Y1],
    [-3.5-T1,0.5+Y1],[-3.4-T1,1.19]]);
}
if (Test == 0)
{
    translate([Len/2,0,0])
    %Cbeam();
    for (i = [0:Qty-1])
    {
        translate([Len/2,i * 9,0])
        Channel(V1,Z1);
    }
} else if (Test == 1)
{
    translate([Len/2,0,0])
%Cbeam();
    for (i = [0:Test_Qty-1])
    {
        translate([Len/2,i * 9,0])
        Channel(A_T1[i],Z1);
    }
}