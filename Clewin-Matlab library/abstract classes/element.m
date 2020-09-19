% written by guy. 2020_08_15
% a completely general and abstract element.
classdef (Abstract) element  <  matlab.mixin.Copyable
    
    properties
       ports  % a struct that some fields with meaningful names. each field
%               % a 2 (row) vector corresponding to an important/usefull 
%               % point in the element design. all elements have at least
%               % one port which is the origin. (obj.ports.origin)

       holes = {}; % a cell array of elements that have been subtructed to create obj. use to refer to ports
       layer % a layer elements or the str 'multi layer'
      
%                       
%}               
    end
    
    methods (Abstract)
        draw(obj) % to be implemented in the subclasses
        convert2pol(obj) % to be implemented in the subclasses
        set_layer(obj, layer_obj) % % to be implemented in the subclasses
    end
    methods
        % constructor.
        function [obj] = element() 
            obj.ports.origin = [0,0]; % define origin 
        end
        
        % an envelope for matlab's copy()
        function [obj_copy] = copy_el(obj)
            obj_copy = copy(obj);
        end
      
     % various transformation methods: all the folowing methods are also
     % implemented in the subclasses (e.g. polygon_element). the functions
     % here change the ports, and the function of the subclasses will change the nodes. 
        
        % shifts the element rigidly.
        % inputs: shift_vec: a 2 (row) vector corresponding to the point 
        % where we want the origin of the element to move.
        function [obj] = shift(obj, shift_vec)

            
           % shift all the  ports of the element:
           field_names = fieldnames(obj.ports);
           for k = 1:numel(field_names)
               obj.ports.(field_names{k}) = obj.ports.(field_names{k}) + shift_vec; 
           end

        end 
               
        % apply a general linear transformation matrix to the element.
        % arguments:
        % mat : the transfomation matrix
        % origin (optional) : the origin with respect to which the
        % transformation is applied (e.g. rotation around some point).
        % by default it is the origin of the element.
        function [obj] = apply_transformation(obj, mat, origin)
            % initialize origin if it is nor supplied:
            if nargin < 3
               origin = obj.ports.origin;
            end
            
            % transform the ports
           field_names = fieldnames(obj.ports);
           for k = 1:numel(field_names)
                obj.ports.(field_names{k}) = obj.ports.(field_names{k}) - origin; 
                obj.ports.(field_names{k}) = transpose(mat*transpose(obj.ports.(field_names{k})));
                obj.ports.(field_names{k}) = obj.ports.(field_names{k}) + origin;
           end    
        end
        
        % same as apply_transformation, but for the specific case of a
        % rotation tranformation 
%         arguments:
%         angle : angle of rotation (counter-clockwise)
%         origin (optional): point to rotate around. by default it's the origin
%         port of the element
% 
        function [obj] = rotate(obj, angle, origin)
            % initialize origin if not supplied by user
            if nargin < 3
                origin = obj.ports.origin;
            end
            
            % define rotation matrix
            R = @(x) [cos(x), -sin(x); sin(x), cos(x)];
            
            % apply
             obj.apply_transformation(R(angle), origin);      
        end
        
        
        % place obj such that the port indicated by port_name is at the
        % position indicated by position_vec
        % arguments: port_name : a string
         %          position vec: a row vector of length 2.
         %written by guy 2020_08_16
        function  [obj] = place(obj, port_name, position_vec)
            shift_vec = position_vec - obj.ports.(port_name);
            obj.shift(shift_vec);
        end
        %TODO add mirror etc.
        

       function [obj_out] = minus(obj1, obj2)
           pol1 = obj1.convert2pol();
           pol2 = obj2.convert2pol();
           
           pol_out = subtract(pol1, pol2);
           obj_out = pol2elem(pol_out);
           
           obj_out.ports = obj1.ports;
           obj_out.holes = [obj_out.holes, obj1.holes, {obj2}];
       end
        
       function [obj] = invert(obj, boundary_w)
            if nargin<2
                boundary_w = 0;
            end
            
            pol_in = obj.convert2pol();
            % finding bounding box
            [x,y] = boundingbox(pol_in);
            
            wx = x(2)-x(1) + 2*boundary_w;
            wy = y(2)-y(1) + 2*boundary_w;
            org = [mean(x), mean(y)];
            
            % creating rectangle
            r = rect(wx,wy).shift(org);
            
            %subtracting
            obj = copy(r - obj);
                
            
       end
       
       function [obj_out] = xor(obj1, obj2)
           pol1 = obj1.convert2pol();
           pol2 = obj2.convert2pol();
           
           pol_out = xor(pol1, pol2);
           obj_out = pol2elem(pol_out);
           
           
       end
        


    end
    
end