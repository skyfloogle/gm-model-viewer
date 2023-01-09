#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
modelc=0
camx=100
camy=100
camz=100
upx=0
upy=1
upz=0
fov=45
scale=1
flip_tris=true
culling=cull_none
verts=ds_grid_create(0,0)
norms=ds_grid_create(0,0)
texs=ds_grid_create(0,0)
faces=ds_list_create()

gizmosurf=-1

genmodels=void

room_speed=display_get_frequency()

alarm[0]=1

file_drag_enable(true)
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///load model loaded with exe
if (parameter_count()>0) load_model(parameter_string(1))
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Window caption
room_caption=str_cat("Game Maker 3D Viewer - ",fps," FPS")
for (i=file_drag_count()-1;i>=0;i-=1) {
    var fn; fn=file_drag_name(i)
    if (string_lower(filename_ext(fn))==".obj") {load_model(fn) break}
}
file_drag_clear()
#define Mouse_60
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!Gizmo.drag && point_in_rectangle(mouse_x,mouse_y,100,0,room_width-100,room_height)) {
    camx/=1.1
    camy/=1.1
    camz/=1.1
} else if (point_in_rectangle(mouse_x,mouse_y,room_width-100,100,room_width,room_height)) {
    var ok; ok=false
    with (ModelExport) if (y<ystart) {ok=true break}
    if (ok) {
        with (ModelExport) y+=16
        with (ModelVisible) y+=16
    }
}
#define Mouse_61
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!Gizmo.drag && point_in_rectangle(mouse_x,mouse_y,100,0,room_width-100,room_height)) {
    camx*=1.1
    camy*=1.1
    camz*=1.1
} else if (point_in_rectangle(mouse_x,mouse_y,room_width-100,100,room_width,room_height)) {
    var ok; ok=false
    with (ModelExport) if (y>room_height-30) {ok=true break}
    if (ok) {
        with (ModelExport) y-=16
        with (ModelVisible) y-=16
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
d3d_start()
d3d_transform_set_scaling(32,32,32)
d3d_set_projection_ext(camx,camy,camz,0,0,0,upx,upy,upz,fov,room_width/room_height,1,16000)
dx8_set_cull_mode(culling)
texture_set_repeat(true)
i=-1 repeat (modelc) { i+=1
    if (!models[i,4]) continue
    var mat; mat=models[i,3]
    var tex;
    if (mat>=0) tex=background_get_texture(mats[mat,1]) else tex=-1
    d3d_model_draw(models[i,0],0,0,0,tex)
}
texture_set_repeat(false)
d3d_set_culling(false)
d3d_transform_set_identity()
d3d_end()
d3d_set_projection_ortho(0,0,room_width,room_height,0)
draw_set_color(c_black)
draw_rectangle(0,0,100,room_height,false)
draw_rectangle(room_width-100,0,room_width,room_height,false)
draw_set_color(c_white)

if (modelc==0) {
    draw_set_halign(fa_center)
    draw_text(room_width-50,140+25,"No model#F1 for help")
    draw_set_halign(fa_left)
}
