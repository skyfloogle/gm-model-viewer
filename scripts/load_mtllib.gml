///load_mtllib(fn)
var f; f=file_text_open_read(argument0)
if (f<0) {
    show_message("Material file "+argument0+"#does not exist.")
    exit
}
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
            mats[current_mat,1]=-1
            mats[current_mat,2]=c_white
            dsmap(matnames,current_matname,matc)
            matc+=1
        }break
        case "map_Kd": {
            mats[current_mat,1]=background_add(string_token_next(),false,false)
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
