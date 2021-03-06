classdef walking_cane < compound_element
    properties
        length % total length
        R % radius of arc
        trace_w
        gap_w
    end
    
    methods
        % constructor
        function [obj] = walking_cane(length, R, trace_w, gap_w)
            %1. building the cane:
            
                % define arc
                arc = coplanar_arc(R, pi,trace_w, gap_w, [0,1]);
                % calculate line length
                line_l = length - arc.length;
                % define line
                line = coplanar_line(line_l,trace_w, gap_w, [1,0] ).rotate(pi/2);

                % place arc
                arc.place('input', line.ports.output);

                % build the object by defining obj.elements: 
                obj.elements.arc = arc;
                obj.elements.line = line;
                
            %2.  define properties
                obj.length = obj.elements.arc.length + obj.elements.line.length;
                obj.trace_w = trace_w;
                obj.gap_w = gap_w;
            
            %3. define ports
                obj.ports.input = obj.elements.line.ports.input;
                obj.ports.output = obj.elements.arc.ports.output;
        end
       
    end
end