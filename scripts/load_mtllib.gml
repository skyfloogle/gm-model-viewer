///load_mtllib(fn)
var f; f=file_text_open_read(argument0)
if (f<0) {
    show_error("Material file "+argument0+" does not exist.",false)
    exit
}
var olddir; olddir=working_directory
set_working_directory(filename_path(argument0))
var current_matname; current_matname=""
var current_mat; current_mat=0

while (!file_text_eof(f)) {
    var line; line=merge_spaces(file_text_read_string(f))
    file_text_readln(f)
    string_token_start(line," ")
    var cmd; cmd=string_token_next()
    switch (cmd) {
        case "newmtl": {
            current_matname=string_token_next()
            current_mat=matc
            mats[current_mat,0]=current_matname
            mats[current_mat,1]=bgBlank
            mats[current_mat,2]=c_white
            dsmap(matnames,current_matname,matc)
            matc+=1
        }break
        case "map_Kd": {
            var tex; tex=string_token_next()
            if (file_exists(tex)) {
                mats[current_mat,1]=background_add(tex,false,false)
            } else {
                show_error("Texture file "+tex+" was not found.",false)
                mats[current_mat,1]=bgBlank
            }
        }break
        case "Kd": {
            mats[current_mat,2]=make_color_rgb(
                real(string_token_next())*255,
                real(string_token_next())*255,
                real(string_token_next())*255,
            )
        }break
    }
}
file_text_close(f)
set_working_directory(olddir)
