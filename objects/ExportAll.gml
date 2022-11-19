#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
text="Export All"
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var dir; dir=get_directory_alt("Save all models to this folder.","")
if (dir=="") exit
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
