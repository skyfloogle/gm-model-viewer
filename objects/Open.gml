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
var fn; fn=get_open_filename("*.obj","")
if (!file_exists(fn)) exit
with (Controller) {
    load_obj(fn)
    generate_models()
}
