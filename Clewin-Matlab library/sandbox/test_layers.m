
L1 = layer(1,"Layer 1");
L2 = layer(2, "Layer 2");

l = coplanar_line(1000,8,5);
arc = coplanar_arc(100, pi, 8,5).place('input', l.ports.output);

L1.append(l)
L1.append(arc)
L1.draw()

r = rect(20,404).rotate(pi/3);

L2.append(r);
 L2.draw()