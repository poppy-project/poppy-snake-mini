include <poppy_snake_mini_def.scad>

include <robotis-scad/ollo/ollo_def.scad>
include <robotis-scad/dynamixel/xl320_def.scad>
include <robotis-scad/specific_frames/specific_frame_def.scad>

use <robotis-scad/dynamixel/xl320.scad>

use <robotis-scad/frames/three_ollo_to_horn_frame.scad>


use <MCAD/rotate.scad>

module snake_segment(length=elementLenght, nLayer=1, withConnector=true) {
  translate([0,length+3*(OlloSpacing),0]) {
    xl320_two_horns();
    if (withConnector==true) {
      translate([0, -OlloSpacing*3, 0])
        rotate([0,0,180])
          three_ollo_to_horn_frame(length=length, nLayer=nLayer);
    }
  }
}

module add_snake_segment(length=elementLenght, nLayer=1, withConnector=true) {
  snake_segment(length=length, nLayer=nLayer, withConnector=withConnector);
  translate([0,length+3*(OlloSpacing),0])
    for(i = [0 : $children - 1])
      children(i);
}

module snake_two_segments(length=elementLenght, nLayer=1, withConnector=true) {
    add_snake_segment(length, nLayer, withConnector)
      rotate([0,90,0])
        snake_segment(length, nLayer);
}

module add_snake_two_segments(length=elementLenght, nLayer=1, withConnector=true) {
  snake_two_segments(length, nLayer, withConnector);
  translate([0,2*(length+3*(OlloSpacing)),0])
    for(i = [0 : $children - 1])
      children(i);
}

module poppy_snake_mini(nTwoSegments=4, segmentLength=elementLenght, nLayer=1){

  for (i=[0:nTwoSegments-1]) {
    translate([0,i*2*(segmentLength+3*(OlloSpacing)),0])
      if (i==0) {
        snake_two_segments(segmentLength, nLayer, false);
      } else {
        snake_two_segments(segmentLength, nLayer, true);
      }
  }

}



// Testing
echo("##########");
echo("In poppy_snake_mini.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
if (p==1) {
  poppy_snake_mini();
}
