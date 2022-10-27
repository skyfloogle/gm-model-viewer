#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (Controller) {
    var new_fov;
    new_fov=real(get_string("FOV",fov))
    if (new_fov!=0) {
        fov=new_fov
    } else {
        show_message("FOV shouldn't be 0")
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_text(x,y-40,"FOV (vert)")
draw_text(x,y-20,Controller.fov)
event_inherited()
