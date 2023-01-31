///merge_spaces(text)
var out; out=argument0
while (string_pos(" ",out)==1 || string_pos(chr(9),out)==1) {
    out=string_delete(out,1,1)
}
if (string_pos("mtllib",out)==1) return out
out=string_replace_all(out,chr(9)," ")
do {
    argument0=out
    out=string_replace_all(argument0,"  "," ")
} until (out==argument0)
return out
