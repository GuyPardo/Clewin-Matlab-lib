
classdef compound_element < element
% an element that is made out of several sub_elements
% written by Guy 2020_08_16
   properties
       sub_elements % a struct which has fields that are elements (they can be any kind of element).
   end
   
   methods
       function [obj] = draw(obj)
       % draws the element. 
       % when run from clewin, it uses clewin's polygon() function.
       % if run from matlab, it uses the polygon() function from the
       % excluded_folder to plot the element in the current figure window
           
           % TODO - try using structfun instead
           field_names = fieldnames(obj.sub_elements);
           for k = 1:numel(field_names)
               obj.sub_elements.(field_names{k}).draw();
           end
       end
       
       function [obj] = shift(obj, shift_vec)
       % shifts the element rigidly.
       %
       % inputs:
       %
       % shift_vec: a 2 (row) vector corresponding to the point where we
       % want the origin of the element to move.  
       
           % call the parent version (to update ports)
            shift@element(obj, shift_vec);
            
            % shift the sub_elements
            % TODO - try using structfun instead
            field_names = fieldnames(obj.sub_elements);
            for k = 1:numel(field_names)
               obj.sub_elements.(field_names{k}).shift(shift_vec);
            end
       end
       
       function [obj] = apply_transformation(obj,mat, origin)
       % apply a general linear transformation matrix to the element.
       % 
       % arguments:
       %               
       % mat : the transfomation matrix
       % origin (optional) : the origin with respect to which the
       % transformation is applied (e.g. rotation around some point). by
       % default it is the origin of the element.
       
       % define origin if it's not supplied by user
           if nargin<3
               origin = obj.ports.origin;
           end
           
        % call the parent function (to update ports)
           apply_transformation@element(obj, mat,origin);
       
       % transform the sub-elements
       % TODO - try using structfun instead
            field_names = fieldnames(obj.sub_elements);
            for k = 1:numel(field_names)
                obj.sub_elements.(field_names{k}).apply_transformation(mat,origin);
            end  
       end
       
       function [pol] = convert2pol(obj)
       % converts the element to a matlab polyshape object.          
           
            % TODO - try using structfun
            field_names = fieldnames(obj.sub_elements);
            for k = 1:numel(field_names)
                polyVec(k) = obj.sub_elements.(field_names{k}).convert2pol();
            end
           
            pol = union(polyVec);
       end
       
       function [obj] = set_layer(obj, layer_obj)
           %TODO - use structfun instead
           field_names = fieldnames(obj.sub_elements);
           for k = 1:numel(field_names)
               obj.sub_elements.(field_names{k}).set_layer(layer_obj);
           end 
        end
       
   end
   

       
   methods (Access = protected)
      function [obj_copy] = copyElement(obj)
      % an overload for matlab's copyElement.
      % matlab's copyElement is a protected method of copiable objects that
      % is used inside the public copy() method
           
            obj_copy = copyElement@element(obj); % copying the element
           
           % copying the sub_elements
           % TODO - try using structfun
           sub_elements_names = fieldnames(obj_copy.sub_elements);
           for k=1:numel(sub_elements_names)
                obj_copy.sub_elements.(sub_elements_names{k}) = copyElement(obj.sub_elements.(sub_elements_names{k}));
           end 
        end
       
   end
end