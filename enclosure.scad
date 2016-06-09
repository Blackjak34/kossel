use <kossel.scad>;
use <vertex.scad>;
use <bracket.scad>;

kossel(0, 100, 200);

w = 20*25.4;
h = 30*25.4;
side = 22*25.4;

for(r=[0,120,240]) rotate([0, 0, r]) {
    color("LightGray", 0.5) translate([w/-2, side/(2*sqrt(3)), 0])
        cube([w,0.08*25.4,h]);
    color("LimeGreen") translate([0, -198.842, 0]) {
        bracket(45);
        translate([0, 0, 750-25]) bracket(15);
    }
}
