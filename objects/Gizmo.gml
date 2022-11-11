#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surf=-1
drag=false
dragme=false
event_step()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///drag
if (!mouse_check_button(mb_left)) {dragme=false drag=false}
if (drag) {
    var xac,yac;
    xac=(mouse_x-grab_mx)
    yac=clamp((mouse_y-grab_my),-180,180)
    var a,b,c,ca,cb,cc,u;
    if (Controller.upz!=0) {
        u=Controller.upz
        a="camx"
        b="camy"
        c="camz"
        ca=ocamx
        cb=ocamy
        cc=ocamz
    }
    if (Controller.upx!=0) {
        u=Controller.upx
        a="camy"
        b="camz"
        c="camx"
        ca=ocamy
        cb=ocamz
        cc=ocamx
    }
    if (Controller.upy!=0) {
        u=Controller.upy
        a="camz"
        b="camx"
        c="camy"
        ca=ocamz
        cb=ocamx
        cc=ocamy
    }
    var xa,ya;
    xa=point_direction(0,0,ca,cb)-xac*u
    ya=point_direction(0,0,point_distance(0,0,ca,cb),cc)
    if (ya>180) ya-=360
    // why can't i look straight up/down???
    ya=clamp(ya-yac*u,-90+0.001,90-0.001)
    show_debug_message(ya)
    var l;
    l=lengthdir_x(odist,ya)
    variable_instance_set(Controller,c,lengthdir_y(odist,ya))
    variable_instance_set(Controller,a,lengthdir_x(l,xa))
    variable_instance_set(Controller,b,lengthdir_y(l,xa))
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///render
surf=dx8_surface_engage(surf,100,100)
var prim,sec; prim=192 sec=0
if (dragme) {prim=255 sec=64}
else if (collision_point(mouse_x,mouse_y,id,false,false)) prim=255
with (Controller) {
    d3d_start()
    draw_clear(c_black)
    var camdist; camdist=point_distance_3d(0,0,0,camx,camy,camz)/(sqrt(2))
    d3d_set_projection_ext(camx/camdist,camy/camdist,camz/camdist,0,0,0,upx,upy,upz,90,1,0.01,10)
    draw_set_color(make_color_rgb(prim,sec,sec))
    d3d_transform_set_rotation_y(-90)
    d3d_draw_cylinder(-0.1,-0.1,0,0.1,0.1,0.75,-1,1,1,false,24)
    d3d_draw_ellipsoid(-.25,-.25,.5,.25,.25,1,-1,1,1,24)
    d3d_transform_set_identity()
    draw_set_color(make_color_rgb(sec,prim,sec))
    d3d_transform_set_rotation_x(90)
    d3d_draw_cylinder(-0.1,-0.1,0,0.1,0.1,0.75,-1,1,1,false,24)
    d3d_draw_ellipsoid(-.25,-.25,.5,.25,.25,1,-1,1,1,24)
    d3d_transform_set_identity()
    draw_set_color(make_color_rgb(sec,sec,prim))
    d3d_draw_cylinder(-0.1,-0.1,0,0.1,0.1,0.75,-1,1,1,false,24)
    d3d_draw_ellipsoid(-.25,-.25,.5,.25,.25,1,-1,1,1,24)
    draw_set_color(c_white)
    d3d_end()
}
dx8_surface_disengage()
#define Mouse_53
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dragme=collision_point(mouse_x,mouse_y,id,false,false)
if (dragme || point_in_rectangle(mouse_x,mouse_y,100,0,room_width-100,room_height)) {
    drag=true
    grab_mx=mouse_x
    grab_my=mouse_y
    ocamx=Controller.camx
    ocamy=Controller.camy
    ocamz=Controller.camz
    odist=point_distance_3d(0,0,0,ocamx,ocamy,ocamz)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_surface(surf,x,y)
