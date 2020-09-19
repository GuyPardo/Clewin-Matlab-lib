

classdef polygon_element < element
    % subclass of element. a basic ("atomic") element that is only composed out of a single polygon
   properties 
   nodes % a Nx2 matrix of polygon vertices. 
   end
   
   methods
       % constructor
       function obj = polygon_element(nodes_mat)
         
           
           obj@element(); % calling the parent (superclass) ctor, in order to initialize obj.ports.origin
           obj.nodes = nodes_mat; % defining the nodes

       end
       
       
       % draw the element using clewin's polygon().
       function [obj] = draw(obj)
           polygon(obj.nodes);
       end

      
      % various transformation methods: all the folowing methods are also
     % implemented in the subclasses (e.g. polygon_element). the functions
     % here change the ports, and the function of the subclasses will change the nodes.
       
       
        % shifts the element rigidly.
        % inputs: shift_vec: a 2 (row) vector corresponding to the point 
        % where we want the origin of the element to move.
       function [obj] = shift(obj,shift_vec)
           % shift nodes
           obj.nodes = obj.nodes + repmat(shift_vec,length(obj.nodes),1);
           
           % call parent version of shift() in order to update the ports
           shift@element(obj, shift_vec);
       end
       
        
        % apply a general linear transformation matrix to the element.
        % arguments:
        % mat : the transfomation matrix
        % origin (optional) : the origin with respect to which the
        % transformation is applied (e.g. rotation around some point).
        % by default it is the origin of the element.
       function [obj] = apply_transformation(obj, mat, origin)
           
           % define origin if it's not supplied by user
           if nargin < 3
               origin = obj.ports.origin;
           end
            
           % transform the nodes
            obj.shift(-origin);
            obj.nodes = transpose(mat*transpose(obj.nodes));
            obj.shift(+origin);
            
            % update ports
            apply_transformation@element(obj, mat, origin);
            
       end
       
       function [pol] = convert2pol(obj)
           pol = elem2pol(obj);
       end
        function [obj_out] = pol_sub(obj1,obj2)
        %pol_sub subtracts a polygon from a polygon given that the "hole" (obj2) is
        %entirely within the area of the first polygon (obj1)

        nodes1 = [obj1.nodes; obj1.nodes(1,:)];
        nodes2 = [obj2.nodes; obj2.nodes(1,:); obj1.nodes(1,:)];

        obj_out = polygon_element([nodes1; nodes2]);
        end

    

       


   
   end
end