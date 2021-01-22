classdef text_element < element
% written by Guy, 2020_08_23
% an element for dealing with text and annotations 
% note that the origin of a text in clewin is the lower left corner    
   properties
       size % approximate text height in microns, = 100 by default
       txt_str
   end
   properties (GetAccess = private)
       mat % transformation matrix for clewin

   end
   
   methods
       % constructor:
       function [obj] = text_element(txt_str,size)
           if nargin < 2
               size = 100; % setting default font size
           end

           % define properties
           obj.txt_str = convertStringsToChars(txt_str);
           obj.size = size;

           % define ports
           obj.ports.center = [size*length(obj.txt_str)/2*2/3,size/2];

           obj.mat = txtScaleMat(obj.size/2000)*eye(3); % 
       end
       
       function [obj] = draw(obj)
           if isempty(obj.layer)
                obj.layer = layer(0); % if the object has no layer, put it in default layer
           end

            set_layer(obj.layer.id);
            try
                text(obj.txt_str, obj.mat);
            catch
                warning('drawing a text_element in matalb is not supported (yet), but it should work when you run in from CleWin.')
            end
            
       end
       
       function [obj] = set_layer(obj, layer_obj)
            obj.layer = layer_obj;
       end
       
       function [obj] = shift(obj, shift_vec)
          % call parent version of shift(to move ports)
          shift@element(obj, shift_vec);
          
          % shift the text
          obj.mat = txtShiftMat(shift_vec)*obj.mat;
       end
       
        function [obj] = apply_transformation(obj, mat, origin)
           
           % define origin if it's not supplied by user
           if nargin < 3
               origin = obj.ports.origin;
           end
            
           % transform the text
            text_trans_mat = [mat, [0;0];0,0,1];
            obj.mat = text_trans_mat*obj.mat;
            
            % update ports
            apply_transformation@element(obj, mat, origin);
            
        end
       
        function len =  get_length(obj)
            len = 2/3*obj.size*length(obj.txt_str); % approximate length in microes
        end
        
        function [] = convert2pol(obj)
            warning('convert2pol is not supported for text_elements.')
        end
        
        function [x_limit, y_limit]  = bounding_box(obj, tol)
            if nargin<2
                tol=0;
            end
            tol_vec = [-tol, tol];
           x_limit = [obj.ports.origin(1) - max(obj.get_length, obj.size)/2, obj.ports.origin(1) + max(obj.get_length, obj.size)/2 ]; 
           y_limit = [obj.ports.origin(2) - max(obj.get_length, obj.size)/2, obj.ports.origin(2) + max(obj.get_length, obj.size)/2 ];
           
           x_limit = x_limit + tol_vec;
           y_limit = y_limit + tol_vec;
        end
        
        function [pol] = bounding_pol(obj, tol)
            if nargin<2
               tol=0;
            end
            [x,y] =  bounding_box(obj, tol);
            pol= polyshape([x(1), x(1), x(2),x(2)],[ y(1), y(2), y(2), y(1)]);
        end
   end
       

end