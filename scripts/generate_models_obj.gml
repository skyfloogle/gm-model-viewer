///generate_models
var i;
repeat (modelc) {modelc-=1 d3d_model_destroy(models[modelc,0])}
var axto,axsc;
with (ModelFlip) {
    axto[string_pos(axis,"XYZ")-1]=image_index div 2
    axsc[string_pos(axis,"XYZ")-1]=pick(image_index mod 2,other.scale,-other.scale)
}
modelc=0
var modelmap; modelmap=ds_map_create()
var lasttime; lasttime=0
i=-1 repeat (facec) { i+=1
    if (current_time>lasttime+100) {
        lasttime=current_time
        loading_message(str_cat("Generating models...#",i*100/facec,"%#",i," / ",facec))
    }
    var f; f=ds_list_find_value(faces,i)
    var o,g,mat; o=ds_list_find_value(f,0) g=ds_list_find_value(f,1) mat=ds_list_find_value(f,2)
    var blend; if (mat>=0) blend=mats[mat,2] else blend=c_white
    var mkey; mkey=str_cat(o,"_",g,"_",mat)
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
    models[mdl,4]+=max(0,ds_list_find_value(f,3)-2)*3
    if (models[mdl,4]>32000) {
        d3d_model_primitive_end(models[mdl,0])
        d3d_model_primitive_begin(models[mdl,0],pr_trianglelist)
        models[mdl,4]=(ds_list_find_value(f,3)-2)*3
    }
    j=0 repeat (ds_list_find_value(f,3)-2) { j+=1
        var bits; bits[0]=0 bits[1]=j bits[2]=j+1
        k=pick(flip_tris,0,2) repeat (3) {
            var v,t,n;
            v=ds_list_find_value(f,bits[k]*3+4)
            t=ds_list_find_value(f,bits[k]*3+5)
            n=ds_list_find_value(f,bits[k]*3+6)
            k+=pick(flip_tris,1,-1)
            if (n>=0 && t>=0) {
                d3d_model_vertex_normal_texture_color(
                    models[mdl,0],
                    axsc[0]*ds_grid_get(verts,v,axto[0]),
                    axsc[1]*ds_grid_get(verts,v,axto[1]),
                    axsc[2]*ds_grid_get(verts,v,axto[2]),

                    axsc[0]*ds_grid_get(norms,n,axto[0]),
                    axsc[1]*ds_grid_get(norms,n,axto[1]),
                    axsc[2]*ds_grid_get(norms,n,axto[2]),
                    ds_grid_get(texs,t,0),ds_grid_get(texs,t,1),
                    make_color_rgb(
                        ds_grid_get(verts,v,3)*color_get_red(blend),
                        ds_grid_get(verts,v,4)*color_get_green(blend),
                        ds_grid_get(verts,v,5)*color_get_blue(blend),
                    ),
                    1
                )
            } else if (n>=0) {
                d3d_model_vertex_normal_color(
                    models[mdl,0],
                    axsc[0]*ds_grid_get(verts,v,axto[0]),axsc[1]*ds_grid_get(verts,v,axto[1]),axsc[2]*ds_grid_get(verts,v,axto[2]),
                    axsc[0]*ds_grid_get(norms,n,axto[0]),axsc[1]*ds_grid_get(norms,n,axto[1]),axsc[2]*ds_grid_get(norms,n,axto[2]),
                    make_color_rgb(
                        ds_grid_get(verts,v,3)*color_get_red(blend),
                        ds_grid_get(verts,v,4)*color_get_green(blend),
                        ds_grid_get(verts,v,5)*color_get_blue(blend),
                    ),
                    1
                )
            } else if (t>=0) {
                d3d_model_vertex_texture_color(
                    models[mdl,0],
                    axsc[0]*ds_grid_get(verts,v,axto[0]),axsc[1]*ds_grid_get(verts,v,axto[1]),axsc[2]*ds_grid_get(verts,v,axto[2]),
                    ds_grid_get(texs,t,0),ds_grid_get(texs,t,1),
                    make_color_rgb(
                        ds_grid_get(verts,v,3)*color_get_red(blend),
                        ds_grid_get(verts,v,4)*color_get_green(blend),
                        ds_grid_get(verts,v,5)*color_get_blue(blend),
                    ),
                    1
                )
            } else {
                d3d_model_vertex_color(
                    models[mdl,0],
                    axsc[0]*ds_grid_get(verts,v,axto[0]),axsc[1]*ds_grid_get(verts,v,axto[1]),axsc[2]*ds_grid_get(verts,v,axto[2]),
                    make_color_rgb(
                        ds_grid_get(verts,v,3)*color_get_red(blend),
                        ds_grid_get(verts,v,4)*color_get_green(blend),
                        ds_grid_get(verts,v,5)*color_get_blue(blend),
                    ),
                    1
                )
            }
        }
    }
}
ds_map_destroy(modelmap)
with (ModelExport) instance_destroy()
with (ModelVisible) instance_destroy()
var Y; Y=100+30
i=-1 repeat (modelc) { i+=1
    models[i,4]=true
    Y+=30+20*(models[i,1]!="")+20*(models[i,2]!="")+20*(models[i,3]>=0)
    d3d_model_primitive_end(models[i,0])
    with (instance_create(room_width-80-8+25,Y,ModelExport)) m=i
    with (instance_create(room_width-100+8,Y+4,ModelVisible)) m=i
}
with (ModelExport) event_perform(ev_other,ev_room_start)
