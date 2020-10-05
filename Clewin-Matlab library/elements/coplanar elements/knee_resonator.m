classdef knee_resonator < coplanar_element 
   properties
       length
   end
   
   methods
       %cosntructor
       function [obj] = knee_resonator(trace_w, gap_w, total_l,segment_l, distance, coupling_l, boundaries )
           if nargin < 7
                boundaries = [0,0];
           end
           
       obj.boundaries = boundaries;    
       obj.elements.CouplingKnee=coplanar_line(coupling_l,trace_w,gap_w,[1 0]);
       obj.elements.res_arc=coplanar_arc(distance/2,pi/2,trace_w,gap_w).place('input', obj.elements.CouplingKnee.ports.output);
       
       target_l =  total_l - obj.elements.CouplingKnee.length - obj.elements.res_arc.length;          
           for N=1:100
                    test_res=coplanar_meander(trace_w,gap_w,segment_l,distance,N);
                    if test_res.get_length()> target_l
                        NO_hor=N-1;
                        break
                    end          
           end
           
           obj.elements.mea = coplanar_meander(trace_w, gap_w, segment_l, distance, NO_hor).rotate(-pi/2);
           
           add_l = target_l - obj.elements.mea.get_length();
           
           obj.elements.downLine=coplanar_line(add_l/2,trace_w,gap_w).rotate(-pi/2).place('input', obj.elements.res_arc.ports.output);
           obj.elements.mea.place('input', obj.elements.downLine.ports.output);
           obj.elements.outLine =  coplanar_line(add_l/2,trace_w,gap_w).rotate(-pi/2).place('input', obj.elements.mea.ports.output);
          
           obj.ports.input = obj.elements.CouplingKnee.ports.input;
           obj.ports.output = obj.elements.outLine.ports.output;
           
           
            % defining ports etc

          obj.ports.center = obj.elements.mea.ports.center;
          obj.trace_w = trace_w;
          obj.gap_w = gap_w;
          obj.length = obj.get_length();
           
       end
         
       function [len] = get_length(obj)
        % loop on elements
        field_names = fieldnames(obj.elements);
        len = 0;   
            for k = 1:numel(field_names)
                   len = len + obj.elements.(field_names{k}).length;
            end      
            
       end
           
       end
       
end
   
    

















