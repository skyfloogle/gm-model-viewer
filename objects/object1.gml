#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
load_obj("C:\Users\Floogle\Downloads\banana\OBJ_BANANA_01_LOD150.obj")
generate_models()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
d3d_transform_set_scaling(200,200,200)
d3d_transform_add_translation(400,304,0)
i=-1 repeat (modelc) { i+=1
    var mat; mat=models[i,2]
    var tex;
    if (mat>=0) tex=background_get_texture(mats[mat,1]) else tex=-1
    d3d_model_draw(models[i,0],0,0,0,tex)
}
d3d_transform_set_identity()
