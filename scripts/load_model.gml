///load_model(fnname)
switch (string_lower(filename_ext(argument0))) {
case ".obj": {
    genmodels=generate_models_obj
    load_obj(argument0)
}break
case ".g3d": case ".g3z": {
genmodels=generate_models_g3d
    load_g3d(argument0)
}break
default: {
    show_message("That format isn't currently supported.")
    exit
}break
}
loading_message("Generating models...")
generate_models()
