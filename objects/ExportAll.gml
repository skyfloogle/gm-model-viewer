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
g3z=show_message_ext("Please select the export format.","G3D","G3Z","Cancel")

if (g3z==0 or g3z==3) exit

g3z=(g3z==2)

var dir; dir=get_directory_alt("Save all models to this folder.","")
if (dir=="") exit
if (string_pos("\/",string_char_at(dir,string_length(dir)))==0) dir+="/"
for (m=0;m<Controller.modelc;m+=1) {
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
    if (g3z) d3d_model_save_g3z(Controller.models[m,0],dir+"/"+fn+".g3z")
    d3d_model_save(Controller.models[m,0],dir+"/"+fn+".g3d")
}
