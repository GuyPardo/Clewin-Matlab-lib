classdef coplanar_meander < coplanar_element
%   written by Guy 2020_08
%   a meandering coplanar line. all dimensions are in microns 
%   trace_w: width of the trace (metal) 
%   gap_w: width of the gap (insulator
%   segment_l : the length of the bulk N-2 segments of the meander. theree
%               are another two segments of length segmentl/2 in the input and in the
%               output
%   distance : the distance between the segments
%   N : total number of segments
%   to make a tight-meander , set distance = trace_w + gap_w;
%  ports:
%  input
%  output
%  center=origin    
   properties
      length
      N
   end
   
   
   methods
       function [obj] = coplanar_meander(trace_w, gap_w, segment_l, distance, N, boundaries)
        R = distance/2;
        if N<3
            segment_l = 2*segment_l + 2*R;
        end
           

        if nargin < 6
            boundaries = [0,0];
        end
        obj.boundaries = boundaries;
    
        arc_in = coplanar_arc(R,pi/2,trace_w, gap_w,[boundaries(1),0]).place('input', [-(N-1)/2*distance-R,0]);
        arcs_array = {arc_in};
        
        
        lines_array = cell(1,N);
            for i=1:N
                if i==1||i==N
                    L = segment_l/2-R;
                    
                else
                    L = segment_l;
                    
                end
                

                
                lines_array{i} = coplanar_line(L, trace_w, gap_w).rotate(pi/2*(-1)^i).place('input', arcs_array{i}.ports.output);
                if i==N
                    break
                end
                arcs_array = [arcs_array,  {coplanar_arc(R,pi*(-1)^i, trace_w, gap_w).place('input',lines_array{i}.ports.output)}];
                
            end
             
            arc_out = coplanar_arc(R,pi/2*(-1)^N,trace_w, gap_w, [0,boundaries(2)]).rotate(pi/2*(-1)^N).place('input', lines_array{end}.ports.output);
            
                     
            
            arcs_array = [arcs_array, {arc_out}];
            obj.sub_elements.lines = element_array(lines_array);
            obj.sub_elements.arcs  = element_array(arcs_array);
            
            
            % define other ports
            obj.ports.output = obj.sub_elements.arcs.elements{end}.ports.output;
            obj.ports.center = obj.ports.origin;
            obj.ports.input = obj.sub_elements.arcs.elements{1}.ports.input;
            
            obj.length = obj.get_length();
            obj.trace_w = trace_w;
            obj.gap_w = gap_w;
            obj.N=N;
         
       end
       
       function [len] = get_length(obj)
           len=0; 
           for i = 1:numel(obj.sub_elements.lines.elements)
            len = len + obj.sub_elements.lines.elements{i}.length;   
           end
           
           for j = 1:numel(obj.sub_elements.arcs.elements)
            len = len + obj.sub_elements.arcs.elements{j}.length;   
           end


        end
    end
      
   
end
    