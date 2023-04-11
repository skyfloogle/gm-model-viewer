#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (Controller) {
    var res; res=get_string("New position: X,Y,Z",str_cat(camx,",",camy,",",camz))
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
draw_text(x,y-60,str_cat("X:",Controller.camx))
draw_text(x,y-40,str_cat("Y:",Controller.camy))
draw_text(x,y-20,str_cat("Z:",Controller.camz))
event_inherited()
