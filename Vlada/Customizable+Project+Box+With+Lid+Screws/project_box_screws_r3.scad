//Procedural Project Box Screws

//40mm x 60 board size

switch_w=12;
switch_l=8;
button_radius=2;
inside_width = 55;
inside_length = 70;
inside_height = 12.5;
//Wall thickness
thickness = 2;                  
//Fillet radius. This should not be larger than thickness.
radius = 1;                     
//Diameter of the holes that screws thread into. 
screw_dia = 3;                  
//Diameter of the holes on the lid (should be larger than the diameter of your screws)
screw_loose_dia = 3.2;
//Only use this if the lip on your lid is detached from the lid! This is a hack to work around odd union() behaviour.
extra_lid_thickness = 0;        //Extra lid thickness above thickness. 
                                //You may want to tweak this to account for large chamfer radius.

outside_width = inside_width + thickness * 2;
outside_length = inside_length + thickness * 2;
od = screw_dia * 2.5;

module box_screw(id, od, height) {
//   color( "blue", 1.0 )
    difference(){
        union(){
            cylinder(d=od, h=height, $fs=0.2);
            translate([-od/2, -od/2, 0])
                cube([od/2,od,height], false);
            translate([-od/2, -od/2, 0])
                cube([od,od/2,height], false);
        }
    }
}

module rounded_box(x,y,z,r){
    translate([r,r,r])
    minkowski(){
        cube([x-r*2,y-r*2,z-r*2]);
        sphere(r=r, $fs=0.1);
    }
}

module main_box(){
	difference() {
		union() {
			difference(){
					//cube([outside_width, outside_length, inside_height + thickness * 2]);
					difference(){
							rounded_box(outside_width, outside_length, inside_height + thickness + 2, radius);
							translate([0,0,inside_height + thickness])
							cube([outside_width, outside_length, inside_height + thickness * 2]);
					}
					translate([thickness, thickness, thickness])
					cube([inside_width, inside_length, inside_height + thickness]);
			}
			od = screw_dia * 2.5;

			translate([od/2+thickness,od/2+thickness, 0])
					box_screw(screw_dia, od, inside_height);
			
			translate([thickness+inside_width-od/2, od/2+thickness, 0])
					rotate([0,0,90])
							box_screw(screw_dia, od, inside_height);
			
			translate([thickness+inside_width-od/2, -od/2+thickness+inside_length, 0])
					rotate([0,0,180])
							box_screw(screw_dia, od, inside_height);
			
			translate([od/2 + thickness, -od/2+thickness+inside_length, 0])
					rotate([0,0,270])
							box_screw(screw_dia, od, inside_height);

		}
		
		union(){
			translate([inside_width - od/2 + thickness, od/2 + thickness, screw_l2-$01])
			rotate([180,0,0]) cl_holeNut(screw_m,screw_l1,screw_l2,bc=$plh);

			translate([od/2 + thickness, od/2 + thickness, screw_l2-$01])
			rotate([180,0,0]) cl_holeNut(screw_m,screw_l1,screw_l2,bc=$plh);

			translate([inside_width - od/2 + thickness, inside_length - od/2 + thickness, screw_l2-$01])
			rotate([180,0,0]) cl_holeNut(screw_m,screw_l1,screw_l2,bc=$plh);

			translate([od/2 + thickness, inside_length - od/2 + thickness, screw_l2-$01])
			rotate([180,0,0]) cl_holeNut(screw_m,screw_l1,screw_l2,bc=$plh);

		}
				
	}
    
}

module lid(){
    difference(){
        union(){
        //Lid.
        difference(){
            rounded_box(outside_width, outside_length, thickness * 4, radius);
            translate([0,0, thickness + extra_lid_thickness])
                cube([outside_width, outside_length, inside_height + thickness * 4]);
        }
        //Lip
        lip_tol = 0.5;
        lip_width = inside_width - lip_tol;
        lip_length = inside_length - lip_tol;
        translate([(outside_width - lip_width)/2,(outside_length - lip_length)/2, thickness * 0.99])
            difference(){
                cube([lip_width, lip_length, thickness-$01]);
                translate([thickness, thickness, 0])
                    cube([lip_width-thickness*2, lip_length-thickness*2, thickness]);
        }
        
        intersection(){
            union(){
            translate([od/2 + thickness, od/2 + thickness, thickness])
                box_screw(screw_dia, od, thickness);
            translate([inside_width - od/2 + thickness, od/2 + thickness, thickness])
                rotate([0,0,90])
                    box_screw(screw_dia, od, thickness);
            translate([inside_width - od/2 + thickness, inside_length - od/2 + thickness, thickness])
                rotate([0,0,180])
                    box_screw(screw_dia, od, thickness);
            translate([od/2 + thickness, inside_length - od/2 + thickness, thickness])
                rotate([0,0,270])
                    box_screw(screw_dia, od, thickness);
            }
            translate([thickness + lip_tol, thickness + lip_tol, 0])
            cube([lip_width-lip_tol,lip_length-lip_tol, 200]);
        }

        }
        
        union(){
					translate([inside_width - od/2 + thickness, od/2 + thickness, screw_l2-$01])
					rotate([180,0,0]) cl_holeBolt(screw_m,screw_l1,screw_l2,bc=$plh);

					translate([od/2 + thickness, od/2 + thickness, screw_l2-$01])
					rotate([180,0,0]) cl_holeBolt(screw_m,screw_l1,screw_l2,bc=$plh);

					translate([inside_width - od/2 + thickness, inside_length - od/2 + thickness, screw_l2-$01])
					rotate([180,0,0]) cl_holeBolt(screw_m,screw_l1,screw_l2,bc=$plh);

					translate([od/2 + thickness, inside_length - od/2 + thickness, screw_l2-$01])
					rotate([180,0,0]) cl_holeBolt(screw_m,screw_l1,screw_l2,bc=$plh);

        }
    }
}

main_box();
translate([-outside_width-2,0,0])
difference() {
lid();
    translate([outside_width/2,outside_length/2+switch_l+thickness,0])
buttons();

}
// Infinitezimal pieces ...

$01 = 0.001;
$02 = 2*$01;
$03 = 3*$01;
$04 = 4*$01;
$05 = 5*$01;
$06 = 6*$01;
$07 = 7*$01;
$08 = 8*$01;
$09 = 9*$01;
$10 = 10;
// Slicer parameters ...

$pnd = 0.4; // Printer Nozzle Diameter
$plh = 0.2; // Printing Layer Height
$pl1 = 0.2; // Printing 1st Layer Height

// Parametry srouby pro spojeni ...

screw_m = 3; // Sroub M3
screw_l1 = inside_height; // Delka sroubu
screw_l2 = 3; // Delka hlavicky

// Hole for nut and bolt ...

module cl_holeBolt(
	m = 3,
	l1 = 12,
	l2 = 3,
	bc = 0
) {
	d1 = m * 1.15;
	d2 = m * 2.0;
	cl_holeNutBolt(m,d1,l1,d2,l2,60,bc);
}

module cl_holeNut(
	m = 3,
	l1 = 12,
	l2 = 3,
	bc = 0
) {
	d1 = m * 1.15;
	d2 = m * 2.2;
	cl_holeNutBolt(m,d1,l1,d2,l2,6,bc);
}

module cl_holeNutBolt(
	m, // size: 3=M3, 4=M4, ...
	d1,l1, // Bolt part
	d2,l2,f2, // Nut part
	bc=0 // Bottom correction - for easy 3D printing
) {
	translate([0,0, -l1+$01])
	cylinder(d=d1, h=l1+$02, $fn=30);
	cylinder(d=d2, h=l2,     $fn=f2);
	if (bc > 0) {
		intersection() {
			translate([-d1/2,-d2/2,-bc]) cube([d1,d2,bc+$01]);
			translate([0,0,-2*bc])
			cylinder(d=d2, h=l2, $fn=f2);
		}
		translate([-d1/2,-d1/2,-2*bc]) cube([d1,d1,bc+$01]);
	}
}



module buttons()
{
translate([0, -(switch_l+25), 0])  
cube([switch_w,switch_l,thickness+$10], center=true);


    $fn=64;
for ( i = [0 : 3] ){    
 rotate( i * 90, [0, 0, 90])
    translate([0, 15, 0])    
cylinder(h=thickness+$10 , r1=button_radius, r2=button_radius, center=true, $fn=30);

}}
    
