#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_index=2
event_inherited()
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (Controller) {
    upx=pick(other.image_index,1,-1,0,0,0,0)
    upy=pick(other.image_index,0,0,1,-1,0,0)
    upz=pick(other.image_index,0,0,0,0,1,-1)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_text(x,y-20,"Cam Up")
event_inherited()
