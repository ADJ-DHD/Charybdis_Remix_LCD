// LCD top bezel / faceplate for original 67.5 x 40mm PCB holder

// ===== PARAMETERS =====

pcb_x = 67.5;
pcb_y = 40;

clearance = 0.25;   // per side

wall = 2;

// same footprint as holder
inner_x = pcb_x + clearance * 2;
inner_y = pcb_y + clearance * 2;

outer_x = inner_x + wall * 2;
outer_y = inner_y + wall * 2;

// faceplate thickness
plate_z = 3.25;

// screen/window size
window_x = 55.45;   // height / long direction
window_y = 40.25;   // width / short direction

// screen pocket/recess depth so screen can sit flush
screen_recess_depth = 3;

// position window centrally
window_pos_x = (outer_x - window_x) / 2;
window_pos_y = (outer_y - window_y) / 2;

// M3 clearance holes — same as holder
hole_d = 3.2;
hole_r = hole_d / 2;

// distance from INTERNAL PCB/cavity edge to HOLE EDGE
hole_offset = 1.5;
hole_center_offset = hole_offset + hole_r;

$fn = 64;


// ===== MODEL =====

difference() {
    // main bezel plate
    cube([outer_x, outer_y, plate_z]);

    // recessed screen pocket, 3mm deep from underside/top surface
    translate([window_pos_x, window_pos_y, plate_z - screen_recess_depth])
        cube([window_x, window_y, screen_recess_depth + 0.1]);

    // actual window cutout through remaining face
    translate([window_pos_x, window_pos_y, -0.5])
        cube([window_x, window_y, plate_z + 1]);

    // screw pass-through holes, matching holder
    for (x = [wall + hole_center_offset, wall + inner_x - hole_center_offset])
    for (y = [wall + hole_center_offset, wall + inner_y - hole_center_offset])
        translate([x, y, -0.5])
            cylinder(h = plate_z + 1, d = hole_d);
}