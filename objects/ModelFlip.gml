#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
axis=""
image_speed=0
#define Mouse_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var s; s=pick(mouse_button-1,2,4)
if (image_index mod 2 == mouse_button-1) {
    with (ModelFlip) if (id mod 3 == (other.id + 1) mod 3) {
        var tmp; tmp=(other.image_index-s+6) mod image_number
        tmp-=tmp mod 2
        tmp+=image_index mod 2
        other.image_index=image_index-image_index mod 2
        image_index=tmp
    }
    image_index=image_index mod 6
}
with (Controller) generate_models()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_text(x-20,y+4,axis+">")
event_inherited()
