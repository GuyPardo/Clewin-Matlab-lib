
classdef coplanar_arc < compound_element
% written by Guy 2020_08_16
% a cicular coplanar-arc defined by a radius R,  an angle and trace_w, and gap_w, starting from the positive x
% direction and going counterclockwise. 
% 
% ports:
% center = origin - the center of the circle
% output : the edge at positive x
% input : the other edge
% 
% input arguments for constructor:
%
% R - arc radius
% angle - opening of the arc in radians
% trace_w - width of center trace
% gap_w - width of insulating gap
% boundaries  (optional) - a 2 vector. [0,0] (default) means open on both
% sides, [1,0] means closed on one side (the input) etc.
% res (optional) - resolution (no of points). by default=100 
   properties
      R
      angle
      length
      trace_w
      gap_w
      boundaries
   end
   
   methods
        function [obj] = coplanar_arc(R,angle,trace_w, gap_w,boundaries,res)
            if nargin<5
                boundaries = [0,0];
            end
            if nargin < 6
                res = 100;
            end

            
            
            obj.boundaries = boundaries;
            obj.trace_w = trace_w;
            obj.gap_w = gap_w;
            obj.length = abs(R*angle);
            obj.R = R;
            obj.angle = angle;
            
            obj.ports.center = [0,0];
            obj.ports.input = [R*cos(angle),R*sin(angle)];
            obj.ports.output = [R,0];
            
            obj.elements.outer = arc(R + trace_w/2 + gap_w/2,angle, gap_w,res);
            obj.elements.inner = arc(R - trace_w/2 - gap_w/2,angle, gap_w,res);
            
            if boundaries(1)
                obj.elements.input_cap = rect(gap_w,2*gap_w + trace_w).rotate(-(pi/2-angle)).place('right',obj.ports.input);
            end
            
            if boundaries(2)
                obj.elements.output_cap = rect(gap_w,2*gap_w + trace_w).rotate(pi/2).place('right',obj.ports.output);
            end

        end
        
   end
end