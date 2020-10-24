classdef element_grid < element
% a collection of copies of the same element. more resource efficient than
% element_array in case you want an array of copies of the same object. 
% 
%input arguments for ctor:
%

   properties
       source_element % an element object
       coordinates % a 2*N matrix specifying  the coordinates of the different copies relative to obj.ports.origin
   end
   
   methods
       function obj = element_grid(source_element, coordinates)
          % creates an instance of element_grid
           
          % define properties
          obj.source_element = source_element;
          obj.coodinates = coordinates;   
       end
       function obj = draw(obj)
          % loop on the coordinates:
           for i = 1:length(obj.coordinates)
              % shift source_element and draw:
               obj.source_element.place('origin', obj.coordinates(i,:)).draw(); 
           end
       end
     
       
   end
end