classdef (Abstract) element  <  matlab.mixin.Copyable
 % written by guy. 2020_08_15
% a completely general and abstract element. every other element in the
% library inherits from this class (or from a subclass of this class).
    properties
       % a struct with some fields with meaningfull neames. each field is a
       % 2 (row) vector corresponding to an important/usefull point in the
       % element design. all elements have at least one port which is the
       % origin. (obj.ports.origin)
       ports 
       
       % only relevant if the element has been created by subtraction. if
       % so, elemet.holes is a  a cell array of elements that have been
       % subtructed to create the element. use to refer to ports etc.
       % see method element.minus
       holes = {}; 
       layer % a layer elements. for multi layer element, leave empty.
      
%                       
%}               
    end
    
    methods (Abstract)
        draw(obj) % to be implemented in the subclasses
        convert2pol(obj) % to be implemented in the subclasses
        set_layer(obj, layer_obj) % % to be implemented in the subclasses
    end
    methods

        function [obj] = element() % ctor  
        % the constructor defines the origin port.
            obj.ports.origin = [0,0]; % define origin 
        end
        

        function [obj_copy] = copy_el(obj)
        % an envelope for matlab's copy()
            obj_copy = copy(obj);
        end
            

        function [obj] = shift(obj, shift_vec)
        % shifts the element rigidly. inputs: shift_vec: a 2 (row) vector
        % corresponding to the point where we want the origin of the
        % element to move.
        %
        % this function is also implemented in subclasses
        % (e.g polygon_element). shift@element shifts the ports,
        % shift@polygon_element shifts the nodes.
            
           % shift all the  ports of the element:
            obj.ports = structfun(@(x) x + shift_vec, obj.ports, 'uniformoutput', false);

        end 
               

        function [obj] = apply_transformation(obj, mat, origin)
        % apply a general linear transformation matrix to the element.
        % arguments:
        %               
        % mat : the transfomation matrix
        % origin (optional) : the origin with respect to which the
        % transformation is applied (e.g. rotation around some point). by
        % default it is the origin of the element.
        % 
        % this function is also implemented in subclasses (e.g
        % polygon_element). apply_tranfromation@element moves the ports,
        % apply_transformation@polygon_element moves the nodes.

           
        
        % initialize origin if it is not supplied:
            if nargin < 3
               origin = obj.ports.origin;
            end
            
            % transform the ports
           obj.ports = structfun(@(x) x - origin, obj.ports, 'uniformoutput', false);
           obj.ports = structfun(@(x) transpose(mat*transpose(x)), obj.ports,'uniformoutput', false );
           obj.ports = structfun(@(x) x + origin, obj.ports, 'uniformoutput', false);
           
        end
        

        function [obj] = rotate(obj, angle, origin)
        % same as apply_transformation, but for the specific case of a
        % rotation tranformation arguments:
        %
        % angle : angle of rotation (counter-clockwise)
        % origin (optional): point to rotate around. by default it's the 
        % origin port of the element
        %

            % initialize origin if not supplied by user
            if nargin < 3
                origin = obj.ports.origin;
            end

            R = @(x) [cos(x), -sin(x); sin(x), cos(x)];  % define rotation matrix            
                   
            obj.apply_transformation(R(angle), origin);  % apply    
        end
        
        

        function  [obj] = place(obj, port_name, position_vec)         
        % place obj such that the port indicated by port_name is at the
        % position indicated by position_vec
        %
        % arguments:
        % port_name : a string 
        % position_vec: a 2 vector
        %
        % written by guy 2020_08_16
        
            shift_vec = position_vec - obj.ports.(port_name); % calculate shift vector
            obj.shift(shift_vec); % shift
        end
        

        function [obj] = reflect(obj, axis, origin)
        % same as apply_transformation, but for the specific case of a
        % reflection tranformation
        %  
        % arguments:
        %
        % axis: a 2 vector which is the axis of reflection origin
        % (optional): a 2 vector. the  origin of the transformation.
        % by default it's the origin port of the element
           
           % initialize origin if not supplied by user
           if nargin<3
               origin = obj.ports.origin;
           end
           % define transformation (see https://en.wikipedia.org/wiki/Transformation_matrix#Reflection)
           lx = axis(1);
           ly = axis(2);
           trans_mat = 1/(lx^2+ly^2)*[lx^2-ly^2, 2*lx*ly; 2*lx*ly, ly^2-lx^2];
           % apply: 
           obj.apply_transformation(trans_mat, origin);
        end
        

       function [obj_out] = minus(obj1, obj2)
       % subtracts obj2 from obj1. returns a polygon_element if the result
       % is a single polygon. othewise it returns an element_array.
       % the output inherits the ports of obj1, and obj2 is added to the output's holes property.
           
           pol1 = obj1.convert2pol();
           pol2 = obj2.convert2pol();
           
           pol_out = subtract(pol1, pol2); % this is a matlab builtin acting on maltab polyshape objects.
           obj_out = pol2elem(pol_out); % convert back to element
           
           obj_out.ports = obj1.ports;
           obj_out.holes = [obj_out.holes, obj1.holes, {obj2}];
       end
        
       function [obj] = invert(obj, boundary_w)
       % returns an inverted  verion of obj as an element_array.
       %
       % arguments:
       %
       % boundary_w (optional, by default 0) : width of boundary to create
       % at the bounding box of the element.
            
            % define boundary_w if not supplied by user
            if nargin<2
                boundary_w = 0;
            end
            
            pol_in = obj.convert2pol(); % convert to matlab polyshape
   
            [x,y] = boundingbox(pol_in); % finding bounding box (this is a matlab builtin)
            
            % geometry of boudary
            wx = x(2)-x(1) + 2*boundary_w;
            wy = y(2)-y(1) + 2*boundary_w;
            org = [mean(x), mean(y)];
            
            % creating rectangle
            r = rect(wx,wy).shift(org);
            
            %subtracting
            obj = copy(r - obj);
 
       end
       
       function [obj_out] = xor(obj1, obj2)
       % returns an element which is the xor of obj2 and obj1. returns a polygon_element if the result
       % is a single polygon. othewise it returns an element_array.
       % the output does not hava any ports beside it's origin.
       % TODO - update obj_out.holes.
           pol1 = obj1.convert2pol();
           pol2 = obj2.convert2pol();
           
           pol_out = xor(pol1, pol2); % a matlab builtin acting on mtalab polyshape objects
           obj_out = pol2elem(pol_out);          
       end
       
       
       function [output_elem] = duplicate(obj,size, spacing, varargin)
            % written by Guy 2020_08_28 as an external function
            % made it a  method on 2020_10_10
            % editted on 2020_10_24 to use element_grid (should be much more efficient)
            % 
            % returns an element_grid object which is a 2D array of copies of
            % input_elem.
            %  
            % input arguments:
            % size : the dimensions of the array given as a 2 vector [rows, collums]
            % spacing : the spcacing between rows and collums, given as a 2 vector.
            % 
            % optional parameters (call with name_value pair or input a
            % struct):
            % return_element_array : a boolian, false by default.
            % if true the method returns an element_array instead of an
            % element_grid. this is much less efficient for a large number
            % of copies, but gives you more control (e.g you can change
            % properties of the different copies after the array is
            % created)
            % 
            
            p = inputParser;
            addParameter(p, 'return_element_array', false);
            parse(p, varargin{:});
            return_element_array = p.Results.return_element_array;
            
            if return_element_array
                arr = cell(size(1), size(2));
                for i = 1:size(1)
                    for j = 1:size(2)
                        y = -spacing(1)*(size(1)-1)/2+spacing(1)*(i-1);
                        x = -spacing(2)*(size(2)-1)/2+spacing(2)*(j-1);
                        arr{i,j} = obj.copy().shift([x,y]);                        
                    end
                end
                output_elem = element_array(arr);
            else
                coordinates = nan( size(1)*size(2),2);
                counter = 0;
                for i = 1:size(1)
                    for j = 1:size(2)
                        y = -spacing(1)*(size(1)-1)/2+spacing(1)*(i-1);
                        x = -spacing(2)*(size(2)-1)/2+spacing(2)*(j-1);
                        coordinates(counter+1,:) =  [x,y];
                        counter = counter+1;
                    end
                end
                output_elem = element_grid(obj, coordinates);
            end

        end

        function [output_elem] = duplicate_circ(obj,angle, N,varargin)
            %written by Guy 2020_08_28 as an external function
            % made into a method on 2020_10_10
            % editted on 2020_10_24 to use element_grid for resource
            % effeciency
            %   returns an element_grid object which is a circular  array of copies of
            %   input_elem
            %
            %   input arguments:
            %   angle : the angle between successive copies 
            %   N : number of copies
            %   origin  : the origin for the circle, given as a 2 vector
            %   rotate(optional): a boolian. if true, the copies are also rotated about
            %   their respective origins. by default it is true.
            %
            % optional parameters (call with name_value pair or input a
            % struct):
            % return_element_array : a boolian, false by default.
            % if true the method returns an element_array instead of an
            % element_grid. this is much less efficient for a large number
            % of copies, but gives you more control (e.g you can change
            % properties of the different copies after the array is
            % created)
            % TODO use inputParser.  rotate should be a name-value pair.
            % origin maybe an optional argument.
            
            %input parsing:
            p = inputParser;
            addOptional(p,'origin', [0,0]);
            addParameter(p, 'rotate', true);
            addParameter(p, 'return_element_array', false);
            parse(p, varargin{:});
            origin = p.Results.origin;
            rotate = p.Results.rotate;
            return_element_array = p.Results.return_element_array;
            

            pos = obj.ports.origin - origin;
            R = sqrt(pos(1)^2 + pos(2)^2);

            angle_in = atan(pos(2)/pos(1));
            
            if return_element_array
                arr = cell(1,N);
                for i = 1:N
                        angle_temp = angle_in + angle*(i-1);
                        x = R*cos(angle_temp);
                        y = R*sin(angle_temp);
                        
                        arr{i} = obj.copy().place('origin', [x,y] + origin);
                        if rotate
                            arr{i}.rotate(angle*(i-1));
                        end
                end
                output_elem = element_array(arr);
                
            else
                counter = 0;
                coordinates = nan(N,2);
                rotation_angles = zeros(1,N);
                for i = 1:N
                        angle_temp = angle_in + angle*(i-1);
                        x = R*cos(angle_temp);
                        y = R*sin(angle_temp);

                        coordinates(counter+1,:) =  [x,y];
                        counter = counter +1;
                        if rotate
                            rotation_angles(i)=(angle*(i-1));
                        end
                end
                output_elem = element_grid(obj, coordinates, rotation_angles);
            end
            
            
        end
        
        function [x_limit,y_limit] =  bounding_box(obj, tol)
            % written by guy 2020_10_23
            % this is an envelope for matlab's builtin boundingbox
            % the outputs x_limit and y_limit are 2-vectors containig the
            % lower and upper bound in each coordinate for the elements
            % bounnding box
            % tol is an optional argument (by default 0) specifying a
            % tolerance (in um) (just increasing the resulting boundaries by tol)
           if nargin<2
               tol=0;
           end
           tol_vec = [-tol, tol];
            [x_limit, y_limit] = boundingbox(obj.convert2pol());
            x_limit = x_limit + tol_vec;
            y_limit = y_limit + tol_vec;
           
        end
        
        function TF =  overlap(elem1, elem2)
            % written by guy 2020_10_23
            % this is an envelope for matlab's builtin overlaps.
            % returns true if elem1 and elem2 overlap, and false if they
            % don't.
            %TODO - generalize for cell arrays of elements
            
            TF = overlaps(elem1.convert2pol(), elem2.convert2pol());
        end
        



    end
    
end