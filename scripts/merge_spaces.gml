///merge_spaces(text)
if (string_pos("mtllib",argument0)==1) return argument0
var out; out=string_replace_all(argument0,chr(8)," ")
do {
    argument0=out
    out=string_replace_all(argument0,"  "," ")
} until (out==argument0)
return out
