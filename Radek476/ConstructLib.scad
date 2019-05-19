
// Infinitezimal pieces
$01 = 0.001;
$02 = 2*$01;
$03 = 3*$01;
$04 = 4*$01;
$05 = 5*$01;
$06 = 6*$01;
$07 = 7*$01;
$08 = 8*$01;
$09 = 9*$01;


$pnd = 0.4; // Printer Nozzle Diameter
$plh = 0.2; // Printing Layer Height
$pl1 = 0.2; // Printing 1st Layer Height


// ========================================
// 	Generic tools
// ========================================

// ========================================
// 	Generic shapes
// ========================================

// CL_nGon(dd=20,n=8,r=-0);

module cl_nGon(
	d, // Diameter verterx-vertex
	dd, // Diameter edge-edge 
	h=0, // Height
	n=6, // 3=Triangel, 4=Square, 5=Pentagon, 6=Hexagon, 7=Heptagon, 8=Octagon, 9=Nonagon, 10=Decagon, ...
	r=0 // Rotate angle (0-cylinder default) (>0 angle) (<0 angle = central angle / r) 
) {
	D = (dd>0) ? dd / cos(360/n/2) : d;
	R = r < 0 ? (360/n/r): r;
	rotate([0,0,R])
	if (h>0) {
		cylinder(d=D,h=h,$fn=n);
	} else {
		circle(d=D,$fn=n);
	}
}

// ========================================
// 	Hole for nut and bolt
// ========================================

// cl_holeNutBold_test();

module cl_holeNutBold_test() {

	translate([-11,-6,0])
	rotate([180,0,0])
	difference() {
		cube([20,10,5], center=true);
		translate([5,0,0]) cl_holeNut(bc=0.35);
		translate([-5,0,0]) cl_holeBolt(bc=0.35);
	}

	translate([-11,6,0])
	difference() {
		cube([20,10,5], center=true);
		translate([5,0,0]) cl_holeNut();
		translate([-5,0,0]) cl_holeBolt();
	}

}

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
	cylinder(d=d1, h=l1+$02, $fn=60);
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


// ========================================
// 	T-Lock
// ========================================

// cl_tLock_test();

module cl_tLock_test() {
	translate([0,10,0]) 
	cl_tLock();

	cl_tLock(hole=true);
	% cl_tLock(hole=true, diff=0.2);
}


module cl_tLock(a=10, b=5, c=3, d=4, hole=false, diff=0) {
	a = a + 2*diff;
	b = b + 2*diff;
	c = c - diff;
	d = d + 2* diff;
	if (hole) {
		step = 5;
		for (R=[0:step:90-step]) {
			hull() {
				rotate([0,0,-R])      cl_tLock_(a,b,c,d,"bottom");
				rotate([0,0,-R-step]) cl_tLock_(a,b,c,d,"bottom");
			}
			hull() {
				rotate([0,0,-R])      cl_tLock_(a,b,c,d,"top");
				rotate([0,0,-R-step]) cl_tLock_(a,b,c,d,"top");
			}
		}
		rotate([0,0,-90]) hull() {
			translate([0,0,c])
			cl_tLock_(a,b,c,d,"bottom");
			cl_tLock_(a,b,c,d,"bottom");
		}
	} else {
		cl_tLock_(a,b,c,d);
	}
}


module cl_tLock_(a,b,c,d,mode="both") {
	B = b / cos(360/8/2);
	if ((mode=="both") || mode=="top") {
		translate([0,0,-c-d]) cl_nGon(d=B,h=c+d,n=8,r=-2);
	}
	if ((mode=="both") || mode=="bottom") {
		hull() {
			translate([a/2-b/2,0,-c-d]) cl_nGon(d=B,h=d,n=8,r=-2);
			translate([b/2-a/2,0,-c-d]) cl_nGon(d=B,h=d,n=8,r=-2);
		}
	}
}
