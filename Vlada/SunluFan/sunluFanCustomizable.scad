//remixed from https://www.thingiverse.com/thing:4729474

stepDown = true; //true or false
wall = 2.2;
dOut = 225+10;
$fn=256;
fanOffsetX = stepDown ? -1.5 : 0;
fanOff = [fanOffsetX,30,30];
size = 78.6-4;
fanWidth=41;//41 mm min
fanDeph=11;//11 mm min
mainInserts = false; //true or false
stepDownInserts = true; //true or false
tapeWidth=21;
layerHeight=0.2;
mountingTape=false; //true or false
cableDuct=true; //true or false
tempProbe=true; //true or false
difference()
{
  hull()
  {
    translate([-(size-14)/2,0,0])
      cube([size-14,70,70]);
    translate([-size/2,0,0])
      cube([size,70-7,70-7]);
  }
  translate([-50,-255/2+70,-255/2+70+5])
    rotate([0,90,0])
      cylinder(d=dOut,h=100);
  translate(fanOff)
    rotate([45,0,0])
      translate([41/-2,0,fanDeph/-2]) cube([fanWidth,fanWidth,fanDeph]);
  translate(fanOff)
    rotate([45,0,0])
      translate([100/-2,41-0.01,50/-2]) cube([100,41,50]);
  hull()
  {
      translate(fanOff)
        rotate([45,0,0])
          translate([0,20,11/2-0.01])
            cylinder(d=38,h=2);
      difference()
      {
          hull()
          {
            translate([-(size-14-2*wall)/2,-0.01,0])
             cube([size-14-2*wall,0.5,70-wall]);
            translate([-(size-2*wall)/2,-0.01,0])
              cube([size-2*wall,0.5,70-7-wall]);
          }
          translate([-50,-255/2+70,-255/2+70+5])
            rotate([0,90,0])
              cylinder(d=dOut+2*wall,h=100);
      }
  }
  
  hull()
  {
      translate(fanOff)
        rotate([45,0,0])
          translate([0,20,-11/2-2+0.01])
            cylinder(d=38,h=2);
      difference()
      {
          hull()
          {
            translate([-(size-14-2*wall)/2,0,-0.01])
              cube([size-14-2*wall,70-wall,0.5]);
            translate([-(size-2*wall)/2,0,-0.01])
              cube([size-2*wall,70-7-wall,0.5]);
          }
          translate([-50,-255/2+70,-255/2+70+5])
            rotate([0,90,0])
              cylinder(d=dOut+2*wall,h=100);
      }
  }
  if (mainInserts)
  {  
        //upper iserts holes
        translate([25,30,70-8])
        cylinder(d=4.5,h=10);
        translate([-25,30,70-8])
        cylinder(d=4.5,h=10);
        //lower iserts  
        translate([25,70-8,30])
        rotate([-90,0,0]) cylinder(d=4.5,h=10);
        translate([-25,70-8,30])
        rotate([-90,0,0]) cylinder(d=4.5,h=10);
      
 } 
  if (mountingTape)
  {       
          
        //upper mounting tape
        translate([-tapeWidth/2,30-tapeWidth/2,70-layerHeight*2])
        cube([tapeWidth,tapeWidth,layerHeight*2]);

        //lower  mounting tape  
        translate([-tapeWidth/2,70-layerHeight*2,30+tapeWidth/2])
        rotate([-90,0,0]) 
        cube([tapeWidth,tapeWidth,layerHeight*2]);

       
     }   

  if (cableDuct)
  {       
 //cable
        translate([(size/2)-3,(70)-3,-1]) cylinder(d=6,h=80);
  }


  if (tempProbe)
  {       
 //thermistor
     translate([size/2-14.5+3,55,55])
     rotate([90,0,-10]) 
      cylinder(d=3,h=40);
  }   

  
  if (stepDown)
  {
    translate([size/2-14.5,29,29])
    rotate([45,0,0])
      {
       difference()
       {
          translate([0,0,21/-2]) 
          cube([16,44,21]);
if (stepDown)
{
	translate([size/2-14.5,29,29])
	rotate([45,0,0])
		{
			difference()
			{
				translate([0,0,21/-2]) 
						cube([16,44,21]);
				if (stepDownInserts) {
					translate([-0.01,22-30/2+1,15/2])
						rotate([0,90,0])
							cylinder(d=6,h=1);
					translate([-0.01,22+30/2+1,-15/2])
							rotate([0,90,0])
								cylinder(d=6,h=1);
				}
			}
			if (stepDownInserts) {
				translate([3,22-30/2+1,15/2])
					rotate([0,-90,0])
						cylinder(d=3,h=6);
				translate([3,22+30/2+1,-15/2])
					rotate([0,-90,0])
						cylinder(d=3,h=6);
			}
		}
}    





       
    }
   }
  }
  
  *translate([0,-1,-1]) cube (100);
}