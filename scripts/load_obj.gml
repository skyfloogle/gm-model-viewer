///load_obj(fname)
var f; f=file_text_open_read(argument0)
if (f<0) {
    show_error("OBJ file "+argument0+" does not exist.",false)
    exit
}
set_working_directory(filename_path(argument0))
vertc=0
normc=0
texc=0
facec=0
matc=0
groupc=0
matnames=ds_map_create()
groupnames=ds_map_create()
var current_mat; current_mat=-1
var current_group; current_group=""
var current_obj; current_obj=""
while (!file_text_eof(f)) {
    var oline; oline=file_text_read_string(f)
    var line; line=merge_spaces(oline)
    file_text_readln(f)
    string_token_start(line," ")
    var cmd; cmd=string_token_next()
    var varname;
    switch (cmd) {
        case "v": varname="vert"
        case "vt": if (cmd=="vt") varname="tex"
        case "vn": if (cmd=="vn") varname="norm"
        {
            for (i=0;i<6;i+=1) {
                var tmp; tmp=string_token_next()
                if (tmp=="") break
                variable_local_array2_set(varname+"s",variable_local_get(varname+"c"),i,real(tmp))
            }
            if (cmd=="vt") {
                // flip y coordinate
                texs[texc,1]=1-texs[texc,1]
            }
            // vertex colours
            if (i<6 && cmd=="v") {
                verts[vertc,3]=1
                verts[vertc,4]=1
                verts[vertc,5]=1
            }
            variable_local_set(varname+"c",variable_local_get(varname+"c")+1)
        }break
        case "f": {
            faces[facec,0]=current_obj
            faces[facec,1]=current_group
            faces[facec,2]=current_mat
            // load all points
            var points,pointc; pointc=-1
            do {
                pointc+=1
                points[pointc]=string_token_next()
            } until (points[pointc]=="")
            faces[facec,3]=pointc
            for (i=0;i<pointc;i+=1) {
                string_token_start(points[i],"/")
                for (j=0;j<3;j+=1) {
                    tmp=string_token_next()
                    if (tmp!="") faces[facec,4+i*3+j]=real(tmp)-1
                    else faces[facec,4+i*3+j]=-1
                }
            }
            facec+=1
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
