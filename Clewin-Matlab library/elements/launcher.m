
% a launcher for coplanar lines.
%ports:
 % center: the center of the contact pad
% output: the point where the line should start. ( this is also the origin of this design)
classdef launcher < polygon_element
   methods
       function [obj] = launcher(contact_size,line_w, line_gap,adiabatic_l, boundary_w)
           obj@polygon_element(launcher_nodes(contact_size,line_w, line_gap,adiabatic_l, boundary_w));
           obj.ports.output = [0,0];
           obj.ports.center = [-adiabatic_l - contact_size/2,0];
       end
   end
end