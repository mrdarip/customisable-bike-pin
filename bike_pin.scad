use <src/voxel/vx_gray.scad>

$fn=100;
bike_pin(10,5,10,1,6);

module bike_pin(height, iD, oD, thickness, pins){
    /*difference(){
        //clip
        difference(){
            cylinder(h = height, d=oD);
            cylinder(h = height, d=iD);
        }
            
        
        //insertion hole
        translate([-thickness/2,0,0])
        cube([thickness,oD/2,height]);
    }*/

    
levels = [
    [0,10,20],
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

a = function (map, j, i) j*90/len(map[0]);
y = function (map, i, height) i * height / len(map);
function h(map, i, j, height) = map[i<len(map)?i:0][j<len(map[0])?j:0] * height / 255;

module roundMeshFromPoints(levels, height, radius) {
    for (i = [0:len(levels)-2]) {
        for (j = [0:len(levels[i])-2]) {
            color("red")
            translate([
                cos(i),
                sin(j),
                h(levels,i,j,height)
            ])
            sphere(r=1);

            color("white")
            translate([
                cos(i),
                sin(j+1),
                h(levels,i,j+1,height)
            ])
            sphere(r=1);

            color("blue")
            translate([
                cos(i+1),
                sin(j),
                h(levels,i+1,j,height)
            ])
            sphere(r=1);

            color("green")
            translate([
                cos(i+1),
                sin(j+1),
                h(levels,i+1,j+1,height)
            ])
            sphere(r=1);
        }
    }
}

