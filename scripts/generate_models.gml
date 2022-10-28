///generate_models
repeat (modelc) {modelc-=1 d3d_model_destroy(models[modelc,0])}
var axto,axsc;
with (ModelFlip) {
    axto[string_pos(axis,"XYZ")-1]=image_index div 2
    axsc[string_pos(axis,"XYZ")-1]=pick(image_index mod 2,other.scale,-other.scale)
}
modelc=0
var modelmap; modelmap=ds_map_create()
i=-1 repeat (facec) { i+=1
    var o,g,mat; o=faces[i,0] g=faces[i,1] mat=faces[i,2]
    var blend; if (mat>=0) blend=mats[mat,2] else blend=c_white
    var mkey; mkey=strong(o,"_",g,"_",mat)
    var mdl; if (ds_map_exists(modelmap,mkey)) {
        mdl=dsmap(modelmap,mkey)
    } else {
        mdl=modelc
        models[mdl,0]=d3d_model_create()
        d3d_model_primitive_begin(models[mdl,0],pr_trianglelist)
        models[mdl,1]=o
        models[mdl,2]=g
        models[mdl,3]=mat
        models[mdl,4]=0
        dsmap(modelmap,mkey,mdl)
        modelc+=1
    }
    models[mdl,4]+=max(0,faces[i,3]-2)*3
    if (models[mdl,4]>32000) {
        d3d_model_primitive_end(models[mdl,0])
        d3d_model_primitive_begin(models[mdl,0],pr_trianglelist)
        models[mdl,4]=(faces[i,3]-2)*3
    }
    j=0 repeat (faces[i,3]-2) { j+=1
        var bits; bits[0]=0 bits[1]=j bits[2]=j+1
        k=pick(flip_tris,0,2) repeat (3) {
            var v,t,n;
            v=faces[i,bits[k]*3+4]
            t=faces[i,bits[k]*3+5]
            n=faces[i,bits[k]*3+6]
            k+=pick(flip_tris,1,-1)
            if (n>=0 && t>=0) {
                d3d_model_vertex_normal_texture_color(
                    models[mdl,0],
                    axsc[0]*verts[v,axto[0]],axsc[1]*verts[v,axto[1]],axsc[2]*verts[v,axto[2]],
                    axsc[0]*norms[n,axto[0]],axsc[1]*norms[n,axto[1]],axsc[2]*norms[n,axto[2]],
                    texs[t,0],texs[t,1],
                    make_color_rgb(
                        verts[v,3]*color_get_red(blend),
                        verts[v,4]*color_get_red(blend),
                        verts[v,5]*color_get_red(blend),
                    ),
                    1
                )
            } else if (n>=0) {
                d3d_model_vertex_normal_color(
                    models[mdl,0],
                    axsc[0]*verts[v,axto[0]],axsc[1]*verts[v,axto[1]],axsc[2]*verts[v,axto[2]],
                    axsc[0]*norms[n,axto[0]],axsc[1]*norms[n,axto[1]],axsc[2]*norms[n,axto[2]],
                    make_color_rgb(
                        verts[v,3]*color_get_red(blend),
                        verts[v,4]*color_get_red(blend),
                        verts[v,5]*color_get_red(blend),
                    ),
                    1
                )
            } else if (t>=0) {
                d3d_model_vertex_texture_color(
                    models[mdl,0],
                    axsc[0]*verts[v,axto[0]],axsc[1]*verts[v,axto[1]],axsc[2]*verts[v,axto[2]],
                    texs[t,0],texs[t,1],
                    make_color_rgb(
                        verts[v,3]*color_get_red(blend),
                        verts[v,4]*color_get_red(blend),
                        verts[v,5]*color_get_red(blend),
                    ),
                    1
                )
            } else {
                d3d_model_vertex_color(
                    models[mdl,0],
                    axsc[0]*verts[v,axto[0]],axsc[1]*verts[v,axto[1]],axsc[2]*verts[v,axto[2]],
                    make_color_rgb(
                        verts[v,3]*color_get_red(blend),
                        verts[v,4]*color_get_red(blend),
                        verts[v,5]*color_get_red(blend),
                    ),
                    1
                )
            }
        }
    }
}
ds_map_destroy(modelmap)
with (ModelExport) instance_destroy()
var Y; Y=100
i=-1 repeat (modelc) { i+=1
    Y+=30+20*(models[i,1]!="")+20*(models[i,2]!="")+20*(models[i,3]>=0)
    d3d_model_primitive_end(models[i,0])
    (instance_create(room_width-80,Y,ModelExport)).m=i
}
with (ModelExport) event_perform(ev_other,ev_room_start)
