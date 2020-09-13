% written by Guy 2020_08_16
classdef coplanar_line < coplanar_element
    properties
        length
    end
    

    methods
%     	constructor:
        function [obj] = coplanar_line( length,trace_w, gap_w,boundaries)
            if nargin<4
                boundaries = [0,0];
            end
            
            obj.boundaries = boundaries;
            obj.trace_w = trace_w;
            obj.gap_w = gap_w;
            obj.length = length;
            
            obj.ports.input = [-length/2,0];
            obj.ports.output = [length/2,0];
            
            obj.sub_elements.top_rect = rect(length, gap_w).shift([0,trace_w/2+gap_w/2]);
            obj.sub_elements.bottom_rect = rect(length, gap_w).shift([0,-trace_w/2-gap_w/2]);

%  this is a small test i did to check how compund elements work with element arrays. it can probably be deleted but i leave it for now            
% top_rect = rect(length, gap_w).shift([0,trace_w/2+gap_w/2]);
% bottom_rect = rect(length, gap_w).shift([0,-trace_w/2-gap_w/2]);
% 
% obj.sub_elements.rects = element_array([top_rect, bottom_rect]);

            if boundaries(1)
                obj.sub_elements.left_cap = rect(gap_w,2*gap_w + trace_w).place('right',obj.ports.input);
            end
            
            if boundaries(2)
                obj.sub_elements.right_cap = rect(gap_w,2*gap_w + trace_w).place('left',obj.ports.output);
            end

        end
    end



end