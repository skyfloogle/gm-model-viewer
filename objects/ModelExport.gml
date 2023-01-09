#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
text="Export"
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var o,g,mat;
o=Controller.models[m,1]
g=Controller.models[m,2]
mat=Controller.models[m,3]
var fn; fn=""
if (o!="") {
    fn+=o
    if (g!="" || mat>=0) fn+="_"
}
if (g!="") {
    fn+=g
    if (mat>=0) fn+="_"
}
if (mat>=0) {
    fn+=Controller.mats[mat,0]
}
if (fn=="") fn="model"
var fn; fn=get_save_filename("Game Maker model|*.g3d",fn+".g3d")
if (fn=="") exit
d3d_model_save(Controller.models[m,0],fn)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (y<-20 || y>room_height+80) exit
var o,g,mat;
o=Controller.models[m,1]
g=Controller.models[m,2]
mat=Controller.models[m,3]
var Y; Y=y-20*((o!="")+(g!="")+(mat>=0))
draw_set_halign(fa_right)
if (o!="") {
    draw_text(room_width-4,Y,"o:"+o)
    Y+=20
}
if (g!="") {
    draw_text(room_width-4,Y,"g:"+g)
    Y+=20
}
if (mat>=0) {
    draw_text(room_width-4,Y,"m:"+Controller.mats[mat,0])
}
draw_set_halign(fa_left)
event_inherited()
