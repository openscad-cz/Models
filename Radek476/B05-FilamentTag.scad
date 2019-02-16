
// Toto je jen pracovní verze - v plánu je to po testování
// přepsat, zjendodušit a smazat nepoužité části


textFont = "Liberation Sans Narrow:style=Bold";

text1 = "PLA - Průša (PM)";
text1 = "ABS-T - Pl.Mladeč";
text1 = "PLA - Průša (Flmnt)"; // Filamentum
text1 = "Nylon - Gembird";
text1 = "ABS-T - Průša (PM)";
text1 = "PLA - Pl. Mladeč";
text1 = "PLA - Gembird";
text1 = "PETG - Pl. Mladeč";
text1 = "TPE - Gembird";
text1 = "ABS - Pl. Mladeč";

text2 = "Beige - Béžová";
text2 = "Brown - Hnědá";
text2 = "Transp. Žlutá";
text2 = "Transparentní";
text2 = "Transp. Zelená";
text2 = "Transp. Červená";
text2 = "Metalická Zelená";
text2 = "Transp. Zelená";
text2 = "Silver - Stříbrná";
text2 = "Yellow - Žlutá";
text2 = "Petrol Green";
text2 = "Red - Červená";
text2 = "Šedá - Mramor";
text2 = "Černá - Karbon";
text2 = "Černá - Black";
text2 = "Černá - Flexible";
text2 = "Blue - Modrá";


Inf = 0.01; 
Inf2 = 0.02; 
$fn = 50;

$01 = 0.001;
$02 = 2 * $01;
$03 = 3 * $01;
$04 = 4 * $01;
$05 = 5 * $01;

$pn = 0.4;

Lw1 = 0.2; // Tloustaka prvni vrsty
LwN = 0.2; // 0.35 // Tloustka dalsich vrstev

N = 8; // Pocet vrstev (celkova tloustka)
NT = 2; // Pocet vrstev textu (vtlaceno)
NL = 2; // Pocet vrstev na presah zamku

W = Lw1 + LwN * (N-1); // Celkova tloustka
L = 90; // 100 Celkova delka
H = 20; // 18 Celkova vyska

Cd = 7; // Prumer spojky minimalni
CN1 = 1; // Pocet vrstev cepu - rovne
CN = N - 1; // Pocet vrstev cepu (45st sklon);
cepOutline = 0.3; // Cep Outline
cepOutlineN = 1; // Zapusteni cepu

diff = 0; // LwN / 2;

Dd = Cd + diff; // Primer diry pro cep
DN1 = 1; // Pocet vrstev rovne diry
DN = N - 1; // Pocet vrstv diry

echo("Tag WIDTH: ", W);

textOutline = 0; // 0.8;

//rotate([180,0,180])
tag();
// translate([0,H+1]) tag();
// translate([0,-H-1]) tag();

module tag() {
	difference() {
		union() {
			translate([H/2,0])    tagLeft();
			translate([H/2,-H/2]) tagBody();
			translate([L-H/2,0])  tagRight();
		}
		translate([L-H/2,0,-Inf]) cepInv(
			d1 = Dd, 
			d2 = Dd + DN*LwN*2,
			w1 = DN1*Lw1 + 2*Inf,
			w2 = DN*LwN,
			rot = 0
		);
	}
}

module cep(d1,d2,w1,w2,w3,rot=0) {
	cylinder(d=d1, w1 + Inf);
	translate([0,0,w1])
	rotate([0,0,rot])
	intersection() {
		union() {
			cylinder(d1=d1, d2=d2, w2);
			translate([0,0,w2]) cylinder(d=d2, w3);
		}
		translate([-d2/2,-d1/2]) cube([d2,d1,w2+w3]);
	};	
}

module cepInv(d1,d2,w1,w2,rot=0) {
	cylinder(d=d1, w1 + Inf);
	translate([0,0,w1])
	cylinder(d1=d1, d2=d2, w2);
//	translate([-d2/2,-d1/2]) cube([d2,d1,w2]);
	linear_extrude(w1+w2) projection()
  cep(d1,d2,w1,w2,0,rot);
}

module tagLeft() {
	D2 = Cd + CN*LwN*2;
	CO = Cd + 2*cepOutline;
	COW = cepOutlineN * LwN;
	difference() {
		union() {
			difference() {
					cylinder(d=H, W);
					translate([0,0,W-COW+Inf]) cylinder(d=CO, COW);
			}
			cep(
				d1 = Cd, 
				d2 = D2,
				w1 = W + CN1*LwN,
				w2 = CN*LwN,
				w3 = LwN * NL,
				rot = 90
			);
		}
		translate([0,0,-Inf]) cylinder(d=D2+1, Lw1 + (NL+1)*LwN + Inf);
		
	}
}

module tagRight() {
	cylinder(d=H, W);
}

module tagBody() {
	difference() {
		union() {
			difference() {
				tagBodyMain();
				tagTextLine();
			}
			tagTextOutline();
		}
		tagText();
		translate([0,H/2,-Inf]) cylinder(d=H, W + 2*Inf);
		translate([L-H,H/2,-Inf]) cylinder(d=H, W + 2*Inf);
	}
}

backsideText = true;

module tagBodyMain() {
	ww = backsideText ? W : W-LwN;
	intersection() {
		cube([L-H, H, ww]);
//		union() {
//			translate([0,ww]) cube([L-H, H-2*ww, ww]);
//			translate([0,ww]) rotate([0,90]) cylinder(L-H, r=ww);
//			translate([0,H-ww]) rotate([0,90]) cylinder(L-H, r=ww);
//		}
	}
}

module tagTextLine() {
	yShift = H/2; // + ww * 0.07;
	hull() {
		translate([H/2, yShift, W]) 	tagTextLineShape(H * 0.36, W);
		//translate([(L-H)/2, yShift, W]) 	tagTextLineShape(ww, W);
		translate([L-H-H/2, yShift, Lw1]) tagTextLineShape(H * 0.36, W); // 0.22
	}
}

module tagTextLineShape(ww, W) {
	// cylinder(d=ww, W);
	translate([-ww/2, -ww/2]) cube([ww,ww,W]);
}

textMarginX = H/20;
textMarginY = H/10;

module tagTextOutline(x,y) {
	textX = L - 2*H - 2*textMarginX;
	textY = H - 2*textMarginY;
	textWidth = NT > 1 ? (Lw1 + (NT-1)*LwN) : 0;
	
			translate([H/2+textMarginX, textMarginY, 0]) // -Inf
			offset_extrude(
				[[$pn+LwN, Lw1+LwN+LwN + 2*LwN]]
			) {
				translate([textX,0,0]) rotate([0,180,0])
				tagText2D(textX, textY);
			}
}

module tagText(x,y) {
	textX = L - 2*H - 2*textMarginX;
	textY = H - 2*textMarginY;
	textWidth = NT > 1 ? (Lw1 + (NT-1)*LwN) : 0;
	if (backsideText) {
		if (textOutline > 0) {
			translate([H/2+textMarginX, textMarginY, -Inf])
			linear_extrude(textWidth)
			translate([textX,0,0]) rotate([0,180,0])
			difference() {
				offset(r=textOutline) tagText2D(textX, textY);
				tagText2D(textX, textY);
			}
		} else {
			translate([H/2+textMarginX, textMarginY, -Inf])
			offset_extrude(
				// [for (o=[0:LwN:LwN]) [-o,Lw1+LwN+o] ]
				[[Lw1/2,Lw1], [0,Lw1+LwN], [-LwN/2,Lw1+LwN+LwN]]
			) {
				translate([textX,0,0]) rotate([0,180,0])
				tagText2D(textX, textY);
			}
		}
	} else {
		translate([H/2+textMarginX, textMarginY, W-LwN-textWidth+Inf])
		linear_extrude(textWidth)
		tagText2D(textX, textY);
	}
}

module offset_extrude(offsets) {
	for (os=offsets) {
		linear_extrude(os[1])
		offset(r=os[0])
		children();
	}
}

module tagText2D(x,y) {
	h = y * 0.31; // h/1.618
	spacing = 1; // 0.86;
//	square([x,y]);
	translate([x/2, y*0.72])
		text(text1, size=h, halign="center", font=textFont, spacing=spacing);
	translate([x/2, 0])
		text(text2, size=h, halign="center", font=textFont, spacing=spacing);
//	translate([x,y*2/3])
//	text(textOwner, size=y/4, valign="top", halign="right");
}
