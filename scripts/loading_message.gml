draw_set_color(c_black)
draw_rectangle(room_width-100,140+25,room_width,400,false)
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_text_ext(room_width-50,140+25,argument0,-1,100)
draw_set_halign(fa_left)
screen_refresh()
io_handle()
