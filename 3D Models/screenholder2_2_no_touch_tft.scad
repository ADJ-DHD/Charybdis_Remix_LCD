// LCD enclosure with open top, internal-offset corner holes,
// and side wire pipe mounted OUTSIDE the long edge

// ===== PARAMETERS =====

// measured LCD/PCB size
pcb_x = 67.5;
pcb_y = 40;
pcb_z = 14.5;

// fit tolerance for 0.6 nozzle / 0.3 layer
clearance = 0.25;   // per side

// final internal cavity
inner_x = pcb_x + clearance * 2;
inner_y = pcb_y + clearance * 2;
inner_z = pcb_z + clearance;

wall = 2;
floor = 2;

// M3 clearance hole
hole_d = 3.2;

// distance from INTERNAL PCB edge to HOLE EDGE
hole_offset = 1.5;

// side pipe
pipe_inner = 6;
pipe_wall = 2;
pipe_length = 10;

$fn = 64;


// ===== DERIVED =====
outer_x = inner_x + wall * 2;
outer_y = inner_y + wall * 2;
outer_z = inner_z + floor;

hole_r = hole_d / 2;
hole_center_offset = hole_offset + hole_r;


// ===== MODEL =====
difference() {
    union() {
        // Main box
        difference() {
            cube([outer_x, outer_y, outer_z]);

            // Hollow interior
            translate([wall, wall, floor])
                cube([inner_x, inner_y, inner_z]);
        }

        // Side pipe on OUTSIDE of long edge
        translate([
            outer_x / 2,
            outer_y + pipe_length,
            inner_z / 2 + floor / 2
        ])
        rotate([90, 0, 0])
        difference() {
            cylinder(h = pipe_length, d = pipe_inner + pipe_wall * 2);
            translate([0, 0, -0.5])
                cylinder(h = pipe_length + 1, d = pipe_inner);
        }
    }

    // Hole from pipe into box wall
    translate([
        outer_x / 2,
        outer_y + 0.01,
        inner_z / 2 + floor / 2
    ])
    rotate([90, 0, 0])
    cylinder(h = wall + 0.02, d = pipe_inner);

    // Corner holes offset from INTERNAL cavity edges by hole EDGE distance
    for (x = [wall + hole_center_offset, wall + inner_x - hole_center_offset])
    for (y = [wall + hole_center_offset, wall + inner_y - hole_center_offset])
        translate([x, y, 0])
            cylinder(h = outer_z + 1, d = hole_d);
}