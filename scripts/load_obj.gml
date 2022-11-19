///load_obj(fname)
var f; f=file_text_open_read(argument0)
if (f<0) {
    show_error("OBJ file "+argument0+" does not exist.",false)
    exit
}
set_working_directory(filename_path(argument0))
modelc=0
with (ModelExport) instance_destroy()
screen_redraw()
loading_message("Deallocating old model...")
i=0 repeat (ds_list_size(faces)) {ds_list_destroy(ds_list_find_value(faces,i)) i+=1}
ds_list_clear(faces)
facec=0
loading_message("Allocating memory...")
vertc=0
normc=0
texc=0
facec=0
linec=0

filesize=file_size(argument0)
filecompleted=0

var lasttime; lasttime=0
while (!file_text_eof(f)) {
    if (current_time>lasttime+100) {
        lasttime=current_time
        loading_message(strong("Allocating memory...#",filecompleted*100/filesize))
    }
    var oline; oline=file_text_read_string(f)
    file_text_readln(f)
    filecompleted+=string_length(oline)+1
    vertc+=string_pos("v ",oline)==1
    normc+=string_pos("vn ",oline)==1
    texc+=string_pos("vt ",oline)==1
    facec+=string_pos("f ",oline)==1
    linec+=1
}
ds_grid_resize(verts,vertc,6)
ds_grid_resize(norms,normc,3)
ds_grid_resize(texs,texc,2)
vertc=0
normc=0
texc=0
file_text_close(f)
f=file_text_open_read(argument0)
matc=0
groupc=0
matnames=ds_map_create()
groupnames=ds_map_create()
var current_mat; current_mat=-1
var current_group; current_group=""
var current_obj; current_obj=""
clinei=0
lasttime=0
while (!file_text_eof(f)) {
    if (current_time>lasttime+100) {
        lasttime=current_time
        loading_message(strong("Loading data...#",clinei*100/linec,"%#",clinei," / ",linec))
    }
    clinei+=1
    var oline; oline=file_text_read_string(f)
    var line; line=merge_spaces(oline)
    file_text_readln(f)
    string_token_start(line," ")
    var cmd; cmd=string_token_next()
    var grid,ident;
    switch (cmd) {
        case "v": {grid=verts ident=vertc vertc+=1}
        case "vt": if (cmd=="vt") {grid=texs ident=texc texc+=1}
        case "vn": if (cmd=="vn") {grid=norms ident=normc normc+=1}
        {
            for (i=0;i<6;i+=1) {
                var tmp; tmp=string_token_next()
                if (tmp=="") break
                ds_grid_set(grid,ident,i,real(tmp))
            }
            if (cmd=="vt") {
                // flip y coordinate
                ds_grid_set(texs,ident,1,1-ds_grid_get(texs,ident,1))
            }
            // vertex colours
            if (i<6 && cmd=="v") {
                ds_grid_set(verts,ident,3,1)
                ds_grid_set(verts,ident,4,1)
                ds_grid_set(verts,ident,5,1)
            }
        }break
        case "f": {
            var face; face=ds_list_create()
            ds_list_add(face,current_obj)
            ds_list_add(face,current_group)
            ds_list_add(face,current_mat)
            // load all points
            var points,pointc; pointc=-1
            do {
                pointc+=1
                points[pointc]=string_token_next()
            } until (points[pointc]=="")
            ds_list_add(face,pointc)
            for (i=0;i<pointc;i+=1) {
                string_token_start(points[i],"/")
                repeat (3) {
                    tmp=string_token_next()
                    if (tmp!="") ds_list_add(face,real(tmp)-1)
                    else ds_list_add(face,-1)
                }
            }
            ds_list_add(faces,face)
        }break
        case "mtllib": {
            load_mtllib(string_remainder(oline))
        }break
        case "usemtl": {
            var newmat; newmat=string_token_next()
            if (ds_map_exists(matnames,newmat)) {
                current_mat=dsmap(matnames,newmat)
            } else {
                show_message("This model is missing a material '"+newmat+"'.#Those parts will appear as white.")
                current_mat=-1
            }
        }break
        case "o": {
            current_obj=string_token_next()
        }break
        case "g": {
            current_group=string_token_next()
            if (!ds_map_exists(groupnames,current_group)) {
                dsmap(groupnames,current_group,groupc)
                groupc+=1
            }
        }break
        case "s": {
            texture_set_interpolation(string_token_next()=="on")
        }break
    }
}
file_text_close(f)
