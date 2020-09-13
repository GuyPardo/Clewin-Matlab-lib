% written by Guy 2020_08_16
classdef compound_element < element
   properties
       sub_elements % a struct which has fields that are elements (they can be compound element themselves) .
   end
   methods
       function [obj] = draw(obj)
           field_names = fieldnames(obj.sub_elements);
           for k = 1:numel(field_names)
               obj.sub_elements.(field_names{k}).draw();
           end
       end
       
       function [obj] = shift(obj, shift_vec)
            % call the parent function (to update ports)
            shift@element(obj, shift_vec);
            
            % shift the sub_elements
            field_names = fieldnames(obj.sub_elements);
            for k = 1:numel(field_names)
               obj.sub_elements.(field_names{k}).shift(shift_vec);
            end
       end
       
       function [obj] = apply_transformation(obj,mat, origin)
       if nargin<3
           origin = obj.ports.origin;
       end
           
        % call the parent function (to update ports)
       apply_transformation@element(obj, mat,origin);
       
       % transform the sub-elements
        field_names = fieldnames(obj.sub_elements);
           for k = 1:numel(field_names)
               obj.sub_elements.(field_names{k}).apply_transformation(mat,origin);
           end  
       end
       
       function [pol] = convert2pol(obj)
           field_names = fieldnames(obj.sub_elements);

           for k = 1:numel(field_names)
               polyVec(k) = obj.sub_elements.(field_names{k}).convert2pol();
           end
           
           pol = union(polyVec);
       end
       
       
   end
       
   methods (Access = protected)
      function [obj_copy] = copyElement(obj)
           obj_copy = copyElement@element(obj);
           
           sub_elements_names = fieldnames(obj_copy.sub_elements);
           for k=1:numel(sub_elements_names)
                obj_copy.sub_elements.(sub_elements_names{k}) = copyElement(obj.sub_elements.(sub_elements_names{k}));
           end 
        end
       
   end
end