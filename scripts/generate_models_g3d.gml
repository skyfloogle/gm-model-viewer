///generate_models
var i;


with (ModelExport) instance_destroy()
with (ModelVisible) instance_destroy()
var Y; Y=100+30
i=-1 repeat (modelc) { i+=1
    models[i,4]=true
    Y+=30+20*(models[i,1]!="")+20*(models[i,2]!="")+20*(models[i,3]>=0)

    with (instance_create(room_width-80-8+25,Y,ModelExport)) m=i
    with (instance_create(room_width-100+8,Y+4,ModelVisible)) m=i
}
with (ModelExport) event_perform(ev_other,ev_room_start)
