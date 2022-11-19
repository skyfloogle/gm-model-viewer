#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
text="Open"
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var fn; fn=get_open_filename("Wavefront OBJ|*.obj","")
if (!file_exists(fn)) exit
with (Controller) {
    load_model(fn)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_black)
draw_rectangle(room_width-100,0,room_width,130,false)
draw_set_color(c_white)
event_inherited()
