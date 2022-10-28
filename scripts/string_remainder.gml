///string_remainder(str)
// Returns the string with the first word removed.
var start; start=string_pos(" ",argument0)
do {
    start+=1
} until (string_char_at(argument0,start)!=" ");
return string_copy(argument0,start,string_length(argument0))
