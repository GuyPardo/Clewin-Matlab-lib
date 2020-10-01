%% full design

% detector array
size = [4,6];
spacing = [8000,5000];
SNSPD = SNSPD_full().place('center', [0,0]);
 SNSPD_arr = duplicate(SNSPD, size,spacing).draw(); 

% id alignmet marks
id_am = alignment_M().shift(SNSPD.ports.origin - [0,1000]).set_layer(layer(0));

id_am_arr =  duplicate(id_am, size,spacing).draw();