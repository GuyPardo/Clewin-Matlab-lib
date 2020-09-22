
classdef coplanar_resonator < coplanar_element
% written by Guy 2020_08
% a meandering coplanar resonator with total length total_l.
%  built from a coplanar_meander and additional coplanar_lines to reach the
%  desired total_l
   properties
       length
   end
   
   methods
       function [obj] = coplanar_resonator(total_l, trace_w, gap_w, segment_l, distance, boundaries)
          if nargin < 6 
               boundaries = [0,0];
          end
          obj.boundaries = boundaries;
          
          
          % find optimal N
          for n= 1:100
            mea  = coplanar_meander(trace_w, gap_w,segment_l,distance, n);
            
            if mea.get_length() > total_l
                break
            end
            
            if n==100
                error("didn't reach with N = 100. try different parameters (segment_l etc..)")
            end
                
          end
            
        
          
          
          N = n-1;
          
          % defining meander
          obj.sub_elements.meander = coplanar_meander(trace_w, gap_w, segment_l,distance, N);
          
          % calculation extra length needed:
          add_l = total_l - obj.sub_elements.meander.length;
          
          % adding lines
          obj.sub_elements.line_in = coplanar_line(add_l/2, trace_w, gap_w, [boundaries(1),0]).place('output',obj.sub_elements.meander.ports.input);
          obj.sub_elements.line_out = coplanar_line(add_l/2, trace_w, gap_w, [0,boundaries(2)]).place('input',obj.sub_elements.meander.ports.output);
          
          % defining ports
          obj.ports.input = obj.sub_elements.line_in.ports.input;
          obj.ports.output = obj.sub_elements.line_out.ports.output;
          obj.ports.center = obj.sub_elements.meander.ports.center;
          
          obj.trace_w = trace_w;
          obj.gap_w = gap_w;
          obj.length = obj.sub_elements.meander.get_length() + add_l;
         end
          
       end
       
end
    
