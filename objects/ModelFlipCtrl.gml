#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (instance_create(x+20,y+20,ModelFlip)) {axis="X" image_index=0}
with (instance_create(x+20,y+50,ModelFlip)) {axis="Y" image_index=2}
with (instance_create(x+20,y+80,ModelFlip)) {axis="Z" image_index=4}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_text(x,y,"Model Axes")
