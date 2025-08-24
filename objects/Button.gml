#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
text="Edit"
down=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
down=false
#define Mouse_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
down=true
screen_redraw()
event_user(0)
down=false
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//field text: string
image_xscale=(string_width(text)+8)/sprite_width
image_yscale=(string_height(text)+8)/sprite_height
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_ltgray)
draw_button(bbox_left,bbox_top,bbox_right,bbox_bottom,!down)
draw_set_color(c_black)
draw_text(x+4,y+4,text)
draw_set_color(c_white)
