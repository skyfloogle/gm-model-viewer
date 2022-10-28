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
flip_tris=false
culling=cull_none

gizmosurf=-1

room_speed=display_get_frequency()
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
    var mat; mat=models[i,2]
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
    draw_text(room_width-50,140,"No model#F1 for help")
    draw_set_halign(fa_left)
}
