classdef SNSPD_meander < compound_element
    % written by Guy 2020_09_30
    % a tight square meander  
  
    
    properties
        trace_w
        gap_w
        length
        boundaries
    end
    
    methods
        function obj = SNSPD_meander(trace_w, gap_w, segment_l, boundaries )

            
            if nargin < 4
                boundaries = [0,0];
            end
            obj.trace_w = trace_w;
            obj.gap_w = gap_w;
            obj.boundaries = boundaries;
            
            distance = trace_w + gap_w;
            N = round((segment_l - trace_w)/(trace_w + gap_w)) + 2;
            obj.sub_elements.meander = coplanar_meander(trace_w, gap_w, segment_l, distance,N);
            obj.sub_elements.in_cap = coplanar_line(gap_w/2, trace_w, gap_w,[boundaries(1),0]).place('output', obj.sub_elements.meander.ports.input);
            obj.sub_elements.out_cap = coplanar_line(gap_w/2, trace_w, gap_w, [0,boundaries(2)]).place('input', obj.sub_elements.meander.ports.output);
            
            obj.length = obj.sub_elements.meander.length + obj.sub_elements.in_cap.length + obj.sub_elements.out_cap.length;
            
            
            %ports
            
            obj.ports.input = obj.sub_elements.in_cap.ports.input;
            obj.ports.output = obj.sub_elements.out_cap.ports.output;
            
        end

    end
end

