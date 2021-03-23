//Make EPIC custom crystal lamps

//https://www.youtube.com/watch?v=HZKu9QMN5xw&ab_channel=bigclivedotcom

//Lamp cap diamond.
//You can adjust the five variables below
base=40;      //Diameter of base for lamp
rim=5;            //Length of rim at base
size=60;        //Size of diamond
facets=6;       //Number of sides (default 6)
scaling=0.66; //Ratio of length to width (default 0.66)
//Don't change variables below here
halfsize=size/2;
$fn=facets;
difference(){
union(){
//outer body
translate([0,0,0])
cylinder(h=4+rim,d1=base,d2=base,$fn=100);
translate([0,0,-(base/2)+rim])
cylinder(h=halfsize,d1=0,d2=size);
translate([0,0,halfsize-(base/2)+rim])
cylinder(h=size*scaling,d1=size,d2=0);
}
//Inner core.
translate([0,0,-1])
cylinder(h=6+rim,d1=base-2,d2=base-2,$fn=100);
translate([0,0,-(base/2)+rim+1])
cylinder(h=halfsize-1,d1=0,d2=size-2);
translate([0,0,halfsize-(base/2)+rim])
cylinder(h=size*scaling-1.5,d1=size-2,d2=0);
translate([-halfsize,-halfsize,-halfsize])
cube([size,size,halfsize]);
//x-ray box
//translate([-80,-80,-50])
//cube([160,80,260]);
}