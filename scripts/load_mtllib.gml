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

files=ds_map_create()
while (!file_text_eof(f)) {
    var oline; oline=file_text_read_string(f)
    var line; line=merge_spaces(oline)
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
            mats[current_mat,3]=""
            dsmap(matnames,current_matname,matc)
            matc+=1
        }break
        case "map_Kd": {
            var tex; tex=string_remainder(oline)
            if (string_pos('/',tex)==1 || string_pos('\',tex)==1)
                tex=string_delete(tex,1,1)
            mats[current_mat,3]=tex
            if (ds_map_exists(files,tex)) {
                mats[current_mat,1]=dsmap(files,tex)
                continue
            }
            if (file_exists(tex)) {
                mats[current_mat,1]=background_add(tex,false,false)
                if (!background_exists(mats[current_mat,1])) {
                    show_error("Texture "+tex+" is in an unsupported format.",false)
                    mats[current_mat,1]=-1
                }
            } else {
                show_error("Texture file "+tex+" was not found.",false)
                mats[current_mat,1]=bgBlank
            }
            ds_map_add(files,tex,mats[current_mat,1])
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
ds_map_destroy(files)
file_text_close(f)
set_working_directory(olddir)
