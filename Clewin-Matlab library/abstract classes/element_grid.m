classdef element_grid < element
% a collection of copies of the same element. more resource efficient than
% element_array in case you want an array of copies of the same object. 
% 
%input arguments for ctor:
%

   properties
       source_element % an element object
       coordinates % a N*2 matrix specifying  the coordinates of the different copies relative to obj.ports.origin
       rotation_angles % an N vector of angles to rotate the different copies, by default all zero
   end
   
   methods
       function obj = element_grid(source_element, coordinates, rotation_angles)
          % creates an instance of element_grid
           
          if nargin<3
              rotation_angles = zeros(1, length(coordinates));
          end
          
          % define properties
          obj.source_element = source_element;
          obj.coordinates = coordinates;   
          obj.rotation_angles = rotation_angles;
       end
       function obj = draw(obj)
           origin = obj.source_element.ports.origin;
          % loop on the coordinates:
           for i = 1:length(obj.coordinates)
              % shift source_element and draw:
               obj.source_element.rotate(obj.rotation_angles(i)).place('origin', origin + obj.coordinates(i,:)).draw();
%                obj.source_element.shift(-obj.coordinates(i,:)) % shift back
               obj.source_element.rotate(-obj.rotation_angles(i)); % rotate back
           end
           obj.source_element.place('origin', origin);
       end
        function [pol] = convert2pol(obj)
        % converts the element to a matlab polyshape object.              
           
           % convert the source element:
           source_pol = obj.source_element.convert2pol();
           % define a vector of polyshape objects 
           for k=1:length(obj.coordinates)
               polyVec(k) = source_pol.translate(obj.coordinates(k,:));
           end
           
           pol = union(polyVec); % perform union with malab builtin
        end
        
        function [obj] = set_layer(obj, layer_obj)
        % set the object's layer and the source elements layer to layer_obj.
            obj.source_element.set_layer(layer_obj);
            obj.layer = layer_obj;
        end
        
       function [obj] = shift(obj, shift_vec)
       % shifts the element rigidly
       %
       %
       % inputs:
       %
       % shift_vec: a 2 (row) vector corresponding to the point where we
       % want the origin of the element to move.  
       
%       shift the source element:
        obj.source_element.shift(shift_vec)
     % call parent version of shift() in order to update the ports (the ports of
     % obj)
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
           
           % if origin is not supplied by user, perform the transformation
           % on the source element:
           if nargin<3
                obj.source_element.apply_transformation(mat);
           else
               obj.source_element.apply_transformation(mat);
               % apply the transformation on the coordinates
                org_temp_mat = repmat(origin-obj.source_element.ports.origin,length(obj.coordinates),1);
                obj.coordinates = org_temp_mat + transpose(mat*transpose(obj.coordinates-org_temp_mat));
                
                % call parent version in order to update the ports
                apply_transformation@element(obj, mat,origin);  
            
           end                   
       end
       
       function pol = bounding_pol(obj, tol)
            % returns a matlab polyshape object which is the union of
            % bounding boxes of the sub elements.
            % tol is an optional parameter specifying tolerance in um
            if nargin<2
               tol=0;
            end
            source_box =  pol2elem(obj.source_element.bounding_pol(tol));
            pol = element_grid(source_box, obj.coordinates).convert2pol();
        end
        
     
       
   end
   
     methods (Access = protected)
      function [obj_copy] = copyElement(obj)
      % an overload for matlab's copyElement.
      % matlab's copyElement is a protected method of copiable objects that
      % is used inside the public copy() method
      
           obj_copy = copyElement@element(obj);           
           obj_copy.source_element = obj.source_element.copy();
        end
       
   end
end