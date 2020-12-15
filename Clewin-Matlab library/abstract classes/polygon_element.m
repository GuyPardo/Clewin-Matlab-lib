classdef polygon_element < element
    % subclass of element. a basic ("atomic") element that is  composed of
    % a single polygon
    
   properties 
   nodes % a Nx2 matrix of polygon vertices. 
   end
   
   methods
       
       function obj = polygon_element(nodes_mat) % constructor
       % creates an instance of polygon_element with nodes given by
       % nodes_mat
           
           obj@element(); % calling the parent (superclass) ctor, in order to initialize obj.ports.origin
           obj.nodes = nodes_mat; % defining the nodes
       end
       
       
       function [obj] = draw(obj)
       % draws the element. 
       % when run from clewin, it uses clewin's polygon() function.
       % if run from matlab, it uses the polygon() function from the
       % excluded_folder to plot the element in the current figure window
       % if the polygon_element layer property is not defined, it is drawn
       % in the layer with index 0 in clewin.
           if isempty(obj.layer)
                obj.layer = layer(0); % if the object has no layer, put it in default layer
           end
           set_layer(obj.layer.id);
           polygon(obj.nodes);
       end
       
       function [obj] = set_layer(obj, layer_obj)
        % a set method for layer property.
        % input should be a layer object.
          obj.layer = layer_obj;
       end

       

       function [obj] = shift(obj,shift_vec)
       % shifts the element rigidly.
       %
       % inputs:
       %
       % shift_vec: a 2 (row) vector corresponding to the point where we
       % want the origin of the element to move.
           
           % shift nodes
           obj.nodes = obj.nodes + repmat(shift_vec,length(obj.nodes),1);
           
           % call parent version of shift() in order to update the ports
           shift@element(obj, shift_vec);
       end
       
        
       function [obj] = apply_transformation(obj, mat, origin)
       % apply a general linear transformation matrix to the element.
       % 
       % arguments:
       %               
       % mat : the transfomation matrix
       % origin (optional) : the origin with respect to which the
       % transformation is applied (e.g. rotation around some point). by
       % default it is the origin of the element.
           
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
       % converts the element to a matlab polyshape object.  
           pol = elem2pol(obj); % elem2pol is implemented in the utility folder
       end
       
        function [obj_out] = pol_sub(obj1,obj2)
        % pol_sub subtracts a polygon_elemnt from a polygon_element, but it
        % only works if the "hole" (obj2) is entirely within the area of
        % the first polygon (obj1).
        % It is therefore better to use minus (-) to perform subtraction
        % between any two elements.
        nodes1 = obj1.nodes;
        nodes2 = obj2.nodes;
        
        distances = zeros(length(nodes1), length(nodes2));
        
        for i=1:length(nodes1)
            for j = 1: length(nodes2)
                distances(i,j) = (nodes1(i,1) - nodes2(j,1)).^2 + (nodes1(i,2) - nodes2(j,2)).^2;
            end
        end
        I = find(distances==min(min(distances)));
        I=I(1)
       [row, col] = ind2sub(size(distances),I)
        
        nodes_out = [nodes1(row,:); nodes1((row+1):end,:); nodes1(1:row,:); nodes2(col,:); nodes2((col+1):end,:); nodes2(1:col,:); nodes1(row,:)];
        
%         nodes1 = [obj1.nodes; obj1.nodes(1,:)];
%         nodes2 = [obj2.nodes; obj2.nodes(1,:) obj1.nodes(1,:)];
%         
%         
%         
%         nodes1 = [obj1.nodes; ];
%         nodes2 = [obj2.nodes; obj2.nodes(1,:) obj1.nodes(1,:)];

        obj_out = polygon_element(nodes_out);
        end
        
        function pol = bounding_pol(obj, tol)
            % written by guy 2020_10_24 
            % returns the bounding box of the polygon in the format of a
            % matlab polyshape. the idea is to use this for example in
            % counpound elements to get a bounding polygon which is made
            % out of a union of the bounding boxes of the sub elements. see
            % compound_element@bounding_pol 
            % tol is an optional variable determinig tolerance in um.
            if nargin<2
               tol=0;
            end
            [x,y] =  bounding_box(obj, tol);
            pol= polyshape([x(1), x(1), x(2),x(2)],[ y(1), y(2), y(2), y(1)]);
        end


   end
end