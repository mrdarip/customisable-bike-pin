use <src/voxel/vx_gray.scad>

$fn=100;
bike_pin(10,5,10,1,6);

module bike_pin(height, iD, oD, thickness, pins){
    difference(){
        //clip
        difference(){
            cylinder(h = height, d=oD);
            cylinder(h = height, d=iD);
        }
            
        
        //insertion hole
        translate([-thickness/2,0,0])
        cube([thickness,oD/2,height]);
    }

    
levels = [
    [10,10,20],
    [30,40,50],
    [60,70,80]
];
    /*dots = vx_gray(levels, center = true);

    translate([0,0,height/2])
    rotate([0, 0, 180]) 
    
    for (dot = dots) {
        rotate([0,0,dot[0][0]*180/len(levels[0])])
        translate([0,oD/2,dot[0][1]/len(levels)*height])
        rotate([0,90,90])
        cylinder(h = dot[1]/255, d=0.5);
    }*/

    roundMeshFromPoints(levels, height, oD/2);
}

a = function (map, j, i) i*45/(len(map[0])+1);
y = function (map, j, height) j * height / (len(map)-1);
function h(map, i, j, height) = 1 + map[j][i] / 255;

module roundMeshFromPoints(levels, height, radius) {
    for (i = [0:len(levels)-2]) {
        for (j = [0:len(levels[i])-2]) {
            echo(i, j);

            color("red")
            translate([
                cos(a(levels, j, i)) * h(levels, i, j, height) * radius,
                sin(a(levels, j, i)) * h(levels, i, j, height) * radius,
                y(levels, j, height)
            ])
            sphere(r=1);

            color("white")
            translate([
                cos(a(levels, j+1, i)) * h(levels, i, j+1, height) * radius,
                sin(a(levels, j+1, i)) * h(levels, i, j+1, height) * radius,
                y(levels, j+1, height)
            ])
            sphere(r=1);

            color("blue")
            translate([
                cos(a(levels, j, i+1)) * h(levels, i+1, j, height) * radius,
                sin(a(levels, j, i+1)) * h(levels, i+1, j, height) * radius,
                y(levels, j, height)
            ])
            sphere(r=1);

            color("green")
            translate([
                cos(a(levels, j+1, i+1)) * h(levels, i+1, j+1, height) * radius,
                sin(a(levels, j+1, i+1)) * h(levels, i+1, j+1, height) * radius,
                y(levels, j+1, height)
            ])
            sphere(r=1);
        }
    }
}

