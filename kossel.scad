include <configuration.scad>;

use <vertex.scad>;
use <frame_motor.scad>;
use <frame_top.scad>;
use <extrusion.scad>;
use <nema17.scad>;
use <e3d_v6_all_metall_hotend.scad>;

black = [30/255, 30/255, 30/255, 1];

width = 360;
height = 750;
plate = 250;
print = 200;
rod = 288;

magic = 74.5;
hmax = height-170.7-sqrt((rod*rod)-(magic*magic));
hmin = 70.7;

module carriage(x, y, elev) {
    xdist = x;
    ydist = y+magic+(print/2);
    r = sqrt((xdist*xdist)+(ydist*ydist));
    h = sqrt((rod*rod)-(r*r));
    xangle = acos(h/rod);
    zangle = asin(xdist/r);
    translate([0, -213.347+0.5, h-12.25+elev+hmin]) {
        // carriage
        color(black) rotate([90, 0, 180]) import("WheelCarriage.stl");
        color("OrangeRed") translate([0, 12, 18.5]) rotate([-90, 180, 0])
            import("Carriage.stl");
        // connecting rods
        color(black) translate([24, 18.5, 34.5]) rotate([-180+xangle, 0, -zangle])
            cylinder(rod,d=0.23*25.4,$fn=30);
        color(black) translate([-24, 18.5, 34.5]) rotate([-180+xangle, 0, -zangle])
            cylinder(rod,d=0.23*25.4,$fn=30);
    }
}

module kossel(xpos, ypos, elev) translate([0, 0, 22.5]) {
    for(r=[0,120,240]) rotate([0, 0, r]) {
        // frame assembly
        translate([0, -((width/sqrt(3))+12.9951), 0]) {
            // lower corner brackets
            color("OrangeRed") frame_motor();
            // stepper motors
            color("Gray") translate([0, motor_offset, 0])
                rotate([90, 0, 0]) nema17();
            // lower horizontal extrusions
            vert_ar(15) {
                translate([7.5, 0, -15]) rotate([-90, 0, 0]) extrusion1515(width);
                translate([7.5, 0, 15]) rotate([-90, 0, 0]) extrusion1515(width);
            }
            // vertical extrusions
            translate([0, 0, -22.5]) extrusion1515(height);
            // upper frame assembly
            *translate([0, 0, height-40]) {
                // upper corner brackets
                color("OrangeRed") frame_top();
                // upper horizontal extrusions
                vert_ar(15) translate([7.5, 0, 0]) rotate([-90, 0, 0])
                    extrusion1515(width);
            }
        }
        // glass holding tabs
        tmp = ((width/2)+39.104)/sqrt(3);
        tmp2 = (plate/2)+8;
        translate([-sqrt((tmp2*tmp2)-(tmp*tmp)), tmp, 22.5]) {
            color(black) rotate([0, 0, acos(tmp/tmp2)])
                import("Glass_Tab.stl");
        }
        // carriages
        // x' = xcos(a) + ysin(a)
        // y' = ycos(a) - xsin(a)
        if(r==0)   carriage(xpos, ypos, elev);
        if(r==120) carriage((xpos*-0.5)+(ypos*sqrt(3)/2),
                            (ypos*-0.5)-(xpos*sqrt(3)/2),
                            elev);
        if(r==240) carriage((xpos*-0.5)-(ypos*sqrt(3)/2),
                            (ypos*-0.5)+(xpos*sqrt(3)/2),
                            elev);
    }
    // end effector
    translate([xpos, ypos, 26.5+elev+hmin]) rotate([0, 180, 0]) {
        color("OrangeRed") import("Effector_E3d.stl");
        translate([0, 0, 5]) e3d();
        color(black) translate([0, 0, 8]) import("Groovemount E3Dv6.stl");
    }
        
    // build plate
    color("LightGray", 0.5) translate([0, 0, 26.51]) cylinder(4, d=plate, $fn=60);
}

kossel(100*cos(360*$t), 100*sin(360*$t), 0);