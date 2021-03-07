$fn=100;

// pen tip diameter
tipDia = 5;

// pen body diameter
dia = 11.2;

/**
 * Tip adapter for Edding 0.3mm.
*/
module eddingAdapter() {
  difference() {
    cylinder (d1=dia+0.3, d2=dia-0.2, h=10, center=true);
    translate([0,0,2]) cylinder (d=dia-2.2, h=8, center=true);
    cylinder (d=tipDia,h=50,center=true);
  }
}



/**
 * Alignment for printing.
*/
 translate([0,0,5]) rotate([0,0,0]) eddingAdapter();;
