
classdef launcher < polygon_element
% a launcher for coplanar lines.
%
% input arguments for ctor:
%
% optional agruments (call with name-value pair or input a struct):
% contact_size (default value: 300)
% line_w (default value: 8)
% line_gap (default value: 5)
% adiabatic_l (default value: 300)
%
% ports:
%
% center: the center of the contact pad
% output: the point where the line should start. ( this is also the origin
% of this design)
%



   methods
       function [obj] = launcher(varargin)
           % input parsing
            % default values
            contact_size_def=300; line_w_def=8;  line_gap_def=5; adiabatic_l_def=300; 
        
           p = inputParser;
           addParameter(p,'contact_size', contact_size_def);
           addParameter(p,'line_w', line_w_def);
           addParameter(p,'line_gap', line_gap_def);
           addParameter(p,'adiabatic_l', adiabatic_l_def);
           parse(p, varargin{:});
           contact_size=p.Results.contact_size;
           line_w=p.Results.line_w;
           line_gap=p.Results.line_gap;
           adiabatic_l=p.Results.adiabatic_l;
          
           boundary_w=contact_size*(line_gap/line_w);
           
           obj@polygon_element(launcher_nodes(contact_size,line_w, line_gap,adiabatic_l, boundary_w));
           obj.ports.output = [0,0];
           obj.ports.center = [-adiabatic_l - contact_size/2,0];
       end
   end
end