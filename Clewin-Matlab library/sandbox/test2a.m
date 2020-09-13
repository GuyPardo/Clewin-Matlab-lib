L0 = layer(0, 'Layer 0');
L1 = layer(1, 'Layer 1');

r = rect(100,200);
tx = text_element("hello").set_layer(L1).draw();
% r.set_layer(L0)
r.draw();

L1;
l = coplanar_resonator(6000, 8,5,100,100, [1,0]).set_layer(L1).draw();                              