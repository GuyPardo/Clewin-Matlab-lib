
classdef launcher < polygon_element
% a launcher for coplanar lines.
%
% ports:
%
% center: the center of the contact pad
% output: the point where the line should start. ( this is also the origin
% of this design)
%
% you can also call the ctor without input arguments: launcher()
% to get the default parameters:
% contact_size=300; line_w=8;  line_gap=5; adiabatic_l=300; boundary_w=contact_size*(line_gap/line_w);
%

   methods
       function [obj] = launcher(contact_size,line_w, line_gap,adiabatic_l, boundary_w)
           if nargin<1
                contact_size=300; line_w=8;  line_gap=5; adiabatic_l=300; boundary_w=contact_size*(line_gap/line_w);
           end
           if nargin< 5
               boundary_w=contact_size*(line_gap/line_w);
           end
           
           
           obj@polygon_element(launcher_nodes(contact_size,line_w, line_gap,adiabatic_l, boundary_w));
           obj.ports.output = [0,0];
           obj.ports.center = [-adiabatic_l - contact_size/2,0];
       end
   end
end