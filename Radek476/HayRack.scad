include <ConstructLib.scad>;

$pnd = 0.6; // Printer Nozzle Diameter
$plh = 0.35; // Printing Layer Height

$01=0.01;

$fn = 90;

L2 = 320 - 27 ; // Celkova delka - 270
L = L2/2; // Delka tisknute poloviny

D = 4.2 + 0.8; // Prumer dratu

RL = 151; // Roztec uchytu vlevo
RR = 149; // Roztec uchytu vpravo
R = RL/2 + RR/2; // Prumerna roztec pro vypocet

H = 100; // Hloubka 
T = 1.7; // Tloustka steny

// DR = 2 * (H+R); // Velky prumer (vnitrni)
// DR = sqrt(2*R*R)*2;
DR = H + R*R/H + 20;
echo(DR);

XS = D+5; // Posun ve smeru X - Presah za drat
YSH = 10; // Posun ve smeru Y - Presah nad drat
YSD = 10; // Posun ve smeru Y - Presah pod drat

LT = L-T/2;

dRL = (RL-R)/2;
dRR = (RR-R)/2;

rotate([0,180]) l_rack();
translate([2,0,0]) r_rack();
// rack();





module l_rack() {
	intersection() {
		translate([0,-DR,0]) cube([DR,DR,DR]);
		rack();
	}
}

module r_rack() {
	intersection() {
		translate([0,-DR,-DR]) cube([DR,DR,DR]);
		rack();
	}
}


module rack() {
	CX = DR/2 - H - XS;
	CY = YSD + YSH;
	ZZ = 42;
	ZA = 107;
	intersection() {
		difference() {
			translate([-CX,-CY,0]) cylinder(d=DR+2*T, h=L2, $fn=300, center=true);
			translate([-CX,-CY,0]) cylinder(d=DR, h=L2-2*T, $fn=300, center=true);
			translate([XS,-YSH+dRL,LT]) zaves();
			translate([XS,-YSD-R-dRL,LT]) zaves();
			translate([XS,-YSH+dRR,-LT]) zaves();
			translate([XS,-YSD-R-dRR,-LT]) zaves();
			translate([-$01,-R,-L-$01]) cube([XS+D/2,R-YSH-YSD,L2+$02]);
			
			rotate([90,0,0]) translate([-ZZ/2 + (XS+D/2),0,0]) cl_nGon(dd=ZZ,n=8,h=DR,r=-2);
			rotate([90,0,0]) translate([-ZZ/2 + (XS+D/2),ZA,0]) cl_nGon(dd=ZZ,n=8,h=DR,r=-2);
			rotate([90,0,0]) translate([-ZZ/2 + (XS+D/2),-ZA,0]) cl_nGon(dd=ZZ,n=8,h=DR,r=-2);
		}
		translate([0,-DR,-L]) cube([DR,DR,L2]);
	}
	
	translate([-CX,-CY,0]) rotate([0,0,0])
	translate([DR/2+T/2,0,0]) spojka();
	translate([-CX,-CY,0]) rotate([0,0,-30])
	translate([DR/2+T/2,0,0]) spojka();
	translate([-CX,-CY,0]) rotate([0,0,-60])
	translate([DR/2+T/2,0,0]) spojka();
}

module spojka() {
	I0 = 10;
	I1 = 5;
	I2 = 25;
	I = I1/4+I2/4;
	rotate([0,0,180])
	difference() {
		hull() {
			translate([I0,-I0/2,-I1/2]) cube([T,I0,I1]);
			translate([0,-I0/2,-I2/2]) cube([T,I0,I2]);
		}
		translate([T+I0/2,0,I-3]) 
			cl_holeNut(m=3,l1=I-3+$02,l2=I0,bc=$plh);
		translate([T+I0/2,0,-I+3]) rotate([180,0,0])
			cl_holeBolt(m=3,l1=I-3+$02,l2=I0,bc=$plh);
	}
}

module zaves() {
	DD = D;
	hull() { 
		drat();
		translate([0,-DD]) drat();
	}
	hull() { 
		translate([0,-DD]) drat();
		translate([-XS*2,-YSD*2]) drat();
	}
}

module drat() {
	cylinder(d=D,h=T+$02,center=true);
}

