include <ConstructLib.scad>;

$pnd = 0.6; // Printer Nozzle Diameter
$plh = 0.35; // Printing Layer Height

$fn = 90;
 


threadFoot = 1;
threadBaseF = 3;

t1h = 52;
t1d = 27;
t1hm = 60;
t1dm = 9;

threadRackT = 2;
threadRackSpaceX = t1d + 2;
threadRackSpaceY = t1d + 2;
threadRackMarginX = threadRackSpaceX * 0.6;
threadRackMarginY = threadRackSpaceY * 0.25;

/// tD1 = 15;
// tH1 = 40;

// threadRack();

threadRack2();

module threadRack2() {
	a=10; b=5; c=3; d=4;
	X = 15;
	Z = 10;
	
	translate([60+d,-20,b/2]) rotate([90,0,90]) cl_tLock(c=60);

	for (n=[0:2]) {
		translate([n*X,0,0])
		difference() {
			cube([X,X,Z]);
			translate([X/2,X/2,Z+$01]) cl_tLock(hole=true, diff=0.2 + n*0.1);
		}
	}
}

module threadRack() {
	N = 6;
	NN = 5;
	sizeX = (N-1)*threadRackSpaceX + 2*threadRackMarginX;
	sizeY = (NN-0.3)*threadRackSpaceY + 2*threadRackMarginY;
	translate([0,-threadRackMarginY,0])
	cube([sizeX, sizeY, threadRackT]);
	dX = threadRackSpaceX/2;
	threadRackRows(rows=[
		[N,   0,  [t1h,t1d,t1hm,t1dm]],
		[N-1, dX, [t1h,t1d,t1hm,t1dm]],
		[N,   0,  [t1h,t1d,t1hm,t1dm]],
		[N-1, dX, [t1h,t1d,t1hm,t1dm]],
		[N,   0,  [t1h,t1d,t1hm,t1dm]],
	],Y=0,C=0);
}

module threadRackRows(rows,Y,C) {
	if (len(rows) > 0) {
		row = rows[0];
		tN = row[0];
		tS = row[1];
		tT = row[2];
		tY = Y + 10;
		tX = threadRackMarginX + tS;
		for (n=[1:1:tN]) {
			translate([tX + threadRackSpaceX*(n-1), tY, threadRackT])
			threadRackCell(tT, C+(n-1)*0.06);
		}
		threadRackRows(
			rows = [for (i=[1:1:len(rows)-1]) rows[i]],
			Y = Y+threadRackSpaceY,
			C = Y/100+0.33
		);
	} else {
		// END
	}
}

module threadRackCell(tT,tC) {
	angle = 25;
	baseD = tT[1]+2*threadBaseF;
	dZ = sin(angle) * baseD/2;
	dY = (1-cos(angle)) * baseD/2;
	translate([0,baseD/2,0]) rotate([90,0,-90]) rotate_extrude(angle=angle)
	translate([baseD/2,0]) circle(d=baseD);
	
	tHm = tT[2];
	tDm = tT[3];
	d1 = tDm-2;
	d2 = tDm+0.1;
	translate([0,dY,dZ])
	rotate([-angle,0,0])
	union() {
		%thread(tT, tC);
		difference() {
			hull() {
				translate([0,0,tHm]) sphere(d=d1);
				translate([0,0,tHm/2]) sphere(d=d2);
				sphere(d=d1);
			}
			hull() {
				translate([0,0,5]) rotate([90,0,0]) cylinder(d2,d=2,center=true);
				translate([0,0,tHm/2]) rotate([90,0,0]) cylinder(d2,d=4,center=true);
				translate([0,0,tHm-5]) rotate([90,0,0]) cylinder(d2,d=2,center=true);
			}
		}
	}
}

module thread(tT,tC) {
	tH = tT[0];
	tD = tT[1];
	tHm = tT[2];
	tDm = tT[3];
//	color(hsv(tC,0.8,0.9))
//  translate([0,0,threadFoot]) cylinder(tH-threadFoot,d=tD);
//	color(hsv(tC,0.3,0.9))
//	cylinder(threadFoot,d1=tD+threadFoot*2,d2=tD);

	shift = (tHm-tH)/2;
	alpha = 0.6;
	color(hsv(tC,0.8,0.9,alpha))
	difference() {
		translate([0,0,shift]) cylinder(tH,d=tD);
		cylinder(tHm,d=tDm+2);
	}
	color("White",alpha)
	difference() {
		cylinder(tHm, d=tDm+2);
		translate([0,0,-$01]) cylinder(tHm+$02, d=tDm);
	}
}


function hsv(h, s=1, v=1,a=1)=doHsvMatrix((h%1)*6,s<0?0:s>1?1:s,v<0?0:v>1?1:v,v*(1-s),v*(1-s*((h%1)*6-floor((h%1)*6))),v*(1-s*(1-((h%1)*6-floor((h%1)*6)))),a); 

function doHsvMatrix(h,s,v,p,q,t,a=1)=[h<1?v:h<2?q:h<3?p:h<4?p:h<5?t:v,h<1?t:h<2?v:h<3?v:h<4?q:h<5?p:p,h<1?p:h<2?p:h<3?t:h<4?v:h<5?v:q,a]; 
