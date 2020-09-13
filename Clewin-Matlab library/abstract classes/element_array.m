% an elements that is built out of an array of other elements
classdef element_array < element
   properties
       elements % a cell array of element objects
     end
   
   methods
       function [obj] = element_array(elements)
          obj@element(); % calling the parent ctor
          obj.elements = elements; 
          
       end
       
       function [obj] =  draw(obj)
          cellfun(@(x) x.draw(), obj.elements, 'uniformoutput', false);
       end
       
       function [obj] = shift(obj, shift_vec)
%       shift each element in the array:
            cellfun(@(x) x.shift(shift_vec), obj.elements, 'uniformoutput', false );
     % call parent version of shift() in order to update the ports (the ports of
     % obj, not of obj.elements)
            shift@element(obj, shift_vec);            
       end
       
       function [obj] = apply_transformation(obj, mat, origin)
           % if origin is not supplied by user use the origin of each element
           % in the array
           if nargin<3
                cellfun(@(x) x.apply_transformation(mat),obj.elements, 'uniformoutput', false);
           else
                cellfun(@(x) x.apply_transformation(mat,origin), obj.elements,'uniformoutput', false);
                % call parent version of shift() in order to update the ports
                apply_transformation@element(obj, mat,origin);  
            
           end                   
       end
       
        function [pol] = convert2pol(obj)
           pols = cellfun(@(x) x.convert2pol, obj.elements);

           for k=1:length(pols)
               polyVec(k) = pols(k);
           end
           
           pol = union(polyVec);
        end
       
        function [obj] = set_layer(obj, layer_obj)
            cellfun(@(x) x.set_layer(layer_obj),obj.elements ,'uniformoutput', false);
        end

       
       
   end
   
   methods (Access = protected)
      function [obj_copy] = copyElement(obj)
           obj_copy = copyElement@element(obj);           
           obj_copy.elements = cellfun(@copy, obj.elements, 'uniformoutput', false);
        end
       
   end
       
       
end