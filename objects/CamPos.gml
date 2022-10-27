#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (Controller) {
    var res; res=get_string("New position: X,Y,Z",strong(camx,",",camy,",",camz))
    string_token_start(res,",")
    var nx,ny,nz;
    nx=real(string_token_next())
    ny=real(string_token_next())
    nz=real(string_token_next())
    if (nx==0 && ny==0 && nz==0) {
        show_message("don't put the camera at the origin")
        exit
    }
    camx=nx
    camy=ny
    camz=nz
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_text(x,y-80,"Cam pos:")
draw_text(x,y-60,strong("X:",Controller.camx))
draw_text(x,y-40,strong("Y:",Controller.camy))
draw_text(x,y-20,strong("Z:",Controller.camz))
event_inherited()
