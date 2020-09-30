% config
diameter = 2497; %diameter of desired lolipop
cut_w = 200; 
neck_w = 400;
neck_l = 500;
adiabatic_l = 3000;
final_w = 900;
stop_l = final_w/2;


lollipop(diameter, adiabatic_l, neck_l, final_w, neck_w, cut_w,stop_l).draw()

clf
lollipop().draw()
