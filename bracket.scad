use <vertex.scad>;

module bracket(height=45, holes=1) {
    intersection() {
        difference() {
            cylinder(r=40, h=height, center=false, $fn=60);
            translate([0, 0, -0.05])
                cylinder(r=36.5, h=height+0.1, center=false, $fn=60);
        }
        translate([0, -58.5, 0]) rotate([0, 0, 30])
            cylinder(r=50, h=height+0.1, center=false, $fn=6);
    }
    translate([0, -22, -0.05]) {
        vert_al(19.77) translate([0, 0.4, 0]) difference() {
            cube([4.72, 15, height]);
            if(holes!=0) {
                translate([4.52, 7.5, 7.5]) rotate([0, -90, 0]) screw_socket();
                translate([4.52, 7.5, 37.5]) rotate([0, -90, 0]) screw_socket();
            }
        }
        vert_ar(19.77) translate([15.05, 0.4, 0]) difference() {
            cube([4.72, 15, height]);
            if(holes!=0) {
                translate([0.2, 7.5, 7.5]) rotate([0, 90, 0]) screw_socket();
                translate([0.2, 7.5, 37.5]) rotate([0, 90, 0]) screw_socket();
            }
        }
    }
    translate([-12, -38-72, 0]) cube([4, 72, height]);
    translate([8, -38-72, 0]) cube([4, 72, height]);
    translate([0, -95, 0]) intersection() {
        difference() {
            cylinder(height, d=40);
            translate([0, 0, -0.05]) cylinder(height+0.1, d=34);
        }
        translate([0, -25, -0.05]) rotate([0, 0, 30])
            cylinder(height+0.1,d=50,$fn=6);
    }
    difference() {
        union() {
            rotate([0, 0, -30]) translate([58.39, -87, 0])
                cube([9, 80, height]);
            rotate([0, 0, 30]) translate([-67.39, -87, 0])
                cube([9, 80, height]);
        }
        w = 20*25.4;
        side = 22*25.4;
        translate([0, 198.842, 0]) rotate([0, 0, 240])
            translate([w/-2, side/(2*sqrt(3)), -0.05])
            cube([w,0.09*25.4,height+0.1]);
        translate([0, 198.842, 0]) rotate([0, 0, 120])
            translate([w/-2, side/(2*sqrt(3)), -0.05])
            cube([w,0.09*25.4,height+0.1]);
        translate([0, -95, -0.05]) intersection() {
            difference() {
                cylinder(height+0.1, d=45);
                translate([0, 0, -0.05]) cylinder(height+0.2, d=40);
            }
            translate([0, -25, -0.1]) rotate([0, 0, 30])
                cylinder(height+0.2,d=50,$fn=6);
        }
        translate([-8.25, -110, -0.05]) cube([16.5, 12, height+0.1]);
    }
    //rotate([0, 0, 30]) translate([-60, -11, 0]) cube([24, 4, height]);
    //rotate([0, 0, -30]) translate([37, -11, 0]) cube([24, 4, height]);
}

bracket(45, 1);
