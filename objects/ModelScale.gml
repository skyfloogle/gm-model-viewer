#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (Controller) {
    var new_scale;
    new_scale=real(get_string("Scale",scale))
    if (new_scale!=0) {
        scale=new_scale
        generate_models()
    } else {
        show_message("Scale shouldn't be 0")
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_text(x,y-40,"Model scale")
draw_text(x,y-20,Controller.scale)
event_inherited()
