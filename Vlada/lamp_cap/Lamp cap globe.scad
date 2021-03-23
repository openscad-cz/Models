//Make EPIC custom crystal lamps

//https://www.youtube.com/watch?v=HZKu9QMN5xw&ab_channel=bigclivedotcom

//Lamp cap globe-style quartz crystal.
//You can adjust the five variables below
base=44;      //Diameter of base for lamp
rim=4;            //Length of rim at base
size=60;        //Diameter of crystal
facets=6;      //Number of sides (default 6)
scaling=1.5;  //Scale of crystal length (default 1.5)
//Don't change variables below here
half=size/2;
upper=half-(base/2)+rim;
$fn=facets;
difference(){
union(){
//outer body
translate([0,0,0])
cylinder(h=4+rim,d1=base,d2=base,$fn=100);
translate([0,0,-(base/2)+rim])
cylinder(h=half,d1=0,d2=size);
translate([0,0,upper])
cylinder(h=size*scaling,d1=size,d2=half*3);
translate([0,0,upper+size*scaling])
cylinder(h=(half*3)/2,d1=half*3,d2=0);
}
//Inner core.
translate([0,0,-1])
cylinder(h=6+rim,d1=base-2,d2=base-2,$fn=100);
translate([0,0,-(base/2)+rim+1])
cylinder(h=half-1,d1=0,d2=size-2);
translate([0,0,upper])
cylinder(h=size*scaling,d1=size-2,d2=(half*3)-2);
translate([0,0,upper+size*scaling])
cylinder(h=(half*3)/2-1.5,d1=(half*3)-2,d2=0);
translate([-half,-half,-half])
cube([size,size,half]);
//x-ray box
//translate([-80,-80,-50])
//cube([160,80,280]);
}