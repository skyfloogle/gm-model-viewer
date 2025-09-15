///load_g3d(fname)

repeat (modelc) {modelc-=1 d3d_model_destroy(models[modelc,0])}

modelc=0
with (ModelExport) instance_destroy()
with (ModelVisible) instance_destroy()
screen_redraw()
loading_message("Deallocating old model...")
i=0 repeat (ds_list_size(faces)) {ds_list_destroy(ds_list_find_value(faces,i)) i+=1}
ds_list_clear(faces)
facec=0

modelc=1

models[0,0]=d3d_model_create_and_load(argument0)
models[0,1]=""
models[0,2]=""
models[0,3]=-1
models[0,4]=1
