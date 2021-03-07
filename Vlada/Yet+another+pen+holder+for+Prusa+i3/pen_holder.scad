$fn=100;

// pen body diameter
dia = 11.2;

/**
 * Pen bracket.
*/
module penBracket() {
  difference() {
    hull() {
      translate([0,0,10])
      rotate([0,90,0])
      cylinder (d=dia+4, h=10, center=true);
      translate([0,0,2.5]) cube ([10,dia+18.8,1], center=true);
    }
    translate([0,0,10]) rotate([0,90,0]) cylinder (d=dia, h=10.01, center=true);
  }
}

/**
 * Complete pen holder.
*/
module penHolder() {
  difference() {
    union() {
      translate([90/2+7.5,0,0]) cube ([90+15,30,5], center=true);
  
      translate([5,0,0]) penBracket();
      translate([39,0,0]) penBracket();
      translate([78,0,0]) penBracket();
    }

    hull() {
    translate([15+73.5+10+3.2/2,-7.5,0]) cylinder (d=3.2, h=5.01, center=true);
    translate([17+25+10+3.2/2,-7.5,0]) cylinder (d=3.2, h=5.01, center=true);
    }
    hull() {
   translate([15+73.5+10+3.2/2,7.5,0]) cylinder (d=3.2, h=5.01, center=true);
      translate([17+25+10+3.2/2,7.5,0]) cylinder (d=3.2, h=5.01, center=true);
    }
  }
}


/**
 * Alignment for printing.
*/
translate([0,0,2.5]) rotate([0,0,0]) penHolder();

