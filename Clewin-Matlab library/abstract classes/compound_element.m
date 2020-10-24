
classdef compound_element < element
% an element that is made out of several sub_elements
% written by Guy 2020_08_16
%
% el = compound_element() creates an empty compound_element
% el = compound_element(element1, element2, element3) with element1,
% element2, element3 some element objects, creates a compound_element whose
% sub elements are element1, element2, element3.
% (works for any number of elements).
%
%important: the elemnets must all have names. for example: 
% el = compound_element(rect(4,3), rect(3,3))
% will return an error
% but :
% r1 = rect(4,3); r2 = rect(3,3);
% el = compound_element(r1,r2);
% will work, and then el.elements will have field r1 and r2. 
% if you want to make composite elements without having to name the sub
% elements you should use the class element_array instead.
%

   properties
       elements % a struct which has fields that are elements (they can be any kind of element).
   end
   
   methods
       function [obj] = compound_element(varargin)
           % ctor. create an instance of this class. see class doc above
           % for more details
            for m = 1:nargin
                obj.elements.(inputname(m)) = varargin{m};
            end
       end
       function [obj] = draw(obj)
       % draws the element. 
       % when run from clewin, it uses clewin's polygon() function.
       % if run from matlab, it uses the polygon() function from the
       % excluded_folder to plot the element in the current figure window
           
         structfun(@(x) x.draw(), obj.elements, 'uniformoutput', false); % draw() each sub_element
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
            structfun(@(x) x.shift(shift_vec), obj.elements, 'uniformoutput',false);
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
%             field_names = fieldnames(obj.sub_elements);
%             for k = 1:numel(field_names)
%                 obj.sub_elements.(field_names{k}).apply_transformation(mat,origin);
%             end  
        structfun(@(x) x.apply_transformation(mat, origin), obj.elements, 'uniformoutput', false);
       end
       
       function [pol] = convert2pol(obj)
       % converts the element to a matlab polyshape object.          
            polyVec = structfun(@(x) x.convert2pol(), obj.elements);            
            pol = union(polyVec);
       end
       
       function [obj] = set_layer(obj, layer_obj)
       % set the object's layer and it's sub elements layer to layer_obj
           structfun(@(x) x.set_layer(layer_obj), obj.elements, 'uniformoutput', false);          
           obj.layer = layer_obj;
       end
        
        function pol = bounding_pol(obj, tol)
            % returns a matlab polyshape object which is the union of
            % bounding boxes of the sub elements.
            % tol is an optional parameter specifying tolerance in um
            if nargin<2
               tol=0;
            end
            polVec =  structfun(@(x) x.bounding_pol(tol), obj.elements);
            pol = union(polVec);
        end
       
   end
   

       
   methods (Access = protected)
      function [obj_copy] = copyElement(obj)
      % an overload for matlab's copyElement.
      % matlab's copyElement is a protected method of copiable objects that
      % is used inside the public copy() method
           
            obj_copy = copyElement@element(obj); % copying the element
           
           % copying the sub_elements
            obj_copy.elements = structfun(@copyElement, obj.elements, 'uniformoutput', false);
        end
       
   end
end