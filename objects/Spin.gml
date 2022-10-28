#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
text="Spin"
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (Controller) {
    var ox,oy,oz;
    ox=camx
    oy=camy
    oz=camz
    var a,b;
    if (upx!=0) {a="camy" b="camz"}
    if (upy!=0) {a="camx" b="camz"}
    if (upz!=0) {a="camx" b="camy"}
    var dir,len,ang;
    dir=point_direction(0,0,variable_local_get(a),variable_local_get(b))
    len=point_distance(0,0,variable_local_get(a),variable_local_get(b))
    for (ang=0;ang<360;ang+=360/min(fps_real,room_speed)) {
        variable_local_set(a,lengthdir_x(len,dir+ang))
        variable_local_set(b,lengthdir_y(len,dir+ang))
        screen_redraw()
        sleep(1000/room_speed)
    }
    camx=ox
    camy=oy
    camz=oz
}
