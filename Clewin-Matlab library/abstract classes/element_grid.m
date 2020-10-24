classdef element_grid < element
% a collection of copies of the same element. more resource efficient than
% element_array in case you want an array of copies of the same object. 
% 
%input arguments for ctor:
%

   properties
       source_element % an element object
       coordinates % a N*2 matrix specifying  the coordinates of the different copies relative to obj.ports.origin
   end
   
   methods
       function obj = element_grid(source_element, coordinates)
          % creates an instance of element_grid
           
          % define properties
          obj.source_element = source_element;
          obj.coordinates = coordinates;   
       end
       function obj = draw(obj)
          % loop on the coordinates:
           for i = 1:length(obj.coordinates)
              % shift source_element and draw:
               obj.source_element.place('origin', obj.coordinates(i,:)).draw(); 
           end
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
        
     
       
   end
end