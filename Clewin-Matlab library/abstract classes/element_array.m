classdef element_array < element
    % an elements that is built out of an array of other elements. usful
    % when you can't or don't want to give each sub element a name. 
    % input argument for constructor:
    % elements: a cell array of elements (of any type, mixed types are also supported)
    
   properties
       elements % a cell array of element objects
     end
   
   methods
       function [obj] = element_array(elements) % ctor
       % creates an element_array object from elements
       %
       % input arguments:
       % elements: a cell array of elements (of any type, mixed types are also supported)
       
          obj@element(); % calling the parent ctor 
          obj.elements = elements; % defining the array  
       end
       
       function [obj] =  draw(obj)
       % draws the element. 
       % when run from clewin, it uses clewin's polygon() function.
       % if run from matlab, it uses the polygon() function from the
       % excluded_folder to plot the element in the urrent figure window           
       
            % draw each element in the array:
            cellfun(@(x) x.draw(), obj.elements, 'uniformoutput', false); 
       end
       
       function [obj] = shift(obj, shift_vec)
       % shifts the element rigidly.
       %
       % inputs:
       %
       % shift_vec: a 2 (row) vector corresponding to the point where we
       % want the origin of the element to move.  
       
%       shift each element in the array:
            cellfun(@(x) x.shift(shift_vec), obj.elements, 'uniformoutput', false );
     % call parent version of shift() in order to update the ports (the ports of
     % obj, not of obj.elements)
            shift@element(obj, shift_vec);            
       end
       
       function [obj] = apply_transformation(obj, mat, origin)
       % apply a general linear transformation matrix to the element.
       % 
       % arguments:
       %               
       % mat : the transfomation matrix
       % origin (optional) : the origin with respect to which the
       % transformation is applied (e.g. rotation around some point). if
       % not supplied by user, each element in the array is transformed
       % with respect to it's own origin.
       % TODO - maybe this is confusing. maybe the default should still be
       % the big origin and add an optional feature to choose.
           
           % if origin is not supplied by user, use the origin of each element
           % in the array
           if nargin<3
                cellfun(@(x) x.apply_transformation(mat),obj.elements, 'uniformoutput', false);
           else
                cellfun(@(x) x.apply_transformation(mat,origin), obj.elements,'uniformoutput', false);
                % call parent version in order to update the ports
                apply_transformation@element(obj, mat,origin);  
            
           end                   
       end
       
        function [pol] = convert2pol(obj)
        % converts the element to a matlab polyshape object.              
           
           % convert each array element:
           pols = cellfun(@(x) x.convert2pol, obj.elements);
           % define a vector of polyshape objects
            for k=1:length(pols)
               polyVec(k) = pols(k);
           end
           
           pol = union(polyVec); % perform union with malab builtin
        end
       
        function [obj] = set_layer(obj, layer_obj)
        % set the object's layer and it's sub elements layer to layer_obj.
            cellfun(@(x) x.set_layer(layer_obj),obj.elements ,'uniformoutput', false);
            obj.layer = layer_obj;
        end

       
       
   end
   
   methods (Access = protected)
      function [obj_copy] = copyElement(obj)
      % an overload for matlab's copyElement.
      % matlab's copyElement is a protected method of copiable objects that
      % is used inside the public copy() method
      
           obj_copy = copyElement@element(obj);           
           obj_copy.elements = cellfun(@copy, obj.elements, 'uniformoutput', false);
        end
       
   end
       
       
end