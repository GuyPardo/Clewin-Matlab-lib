function elem_out = vortex_pinning_holes(wx, wy,  varargin)
    % creates an array of circles (holes for vortex pinning) in an area
    % defined by wx and wy (a rectangular area).
    %
    % input arguments:
    %
    % required arguments:
    % wx - the x-axis width of the rectangle that defines the area to fill
    % with holes
    % wy - the y-axis width of the rectangle that defines the area to fill
    % with holes
    
    % optional argument: exclusion_elements: an element or a cell array of
    % elements that we don't want the hole to overlap for example:
    % vortex_pinning_holes(500,500,circle(100)) creates holes inside a
    % 500*500 rectangle,outside a radius of 100 from the origin
    % 
    % by default it is a circle of radius eps, effectively not excluding
    % anything.
    %
    %
    % optional parameters (call with name-value pair or with a struct
    % input):
    % hole_diameter : diameter of the holes. by default 3
    % hole_dist: the distance between adjacent holes. by default 30
    % tolerance : a number from 0 to 1. indicates how much tolerance should
    % be taken to avoid the excluded elements (relative to the size of each element). by defualt: 0.1
    
    
    
    % input parsing
    % default values
    hole_diameter_def = 3;
    hole_dist_def = 30;
    tol_def = 0.1;
    
    p = inputParser;
    addRequired(p, 'wx');
    addRequired(p, 'wy');
    addOptional(p, 'exclusion_elements', {circle(eps)});
    addParameter(p, 'hole_diameter',hole_diameter_def);
    addParameter(p, 'hole_dist',hole_dist_def);
    addParameter(p, 'tolerance',tol_def);
    parse(p, wx,wy,varargin{:});
       
    exc = p.Results.exclusion_elements;
    hole_r = p.Results.hole_diameter/2;
    hole_d = p.Results.hole_dist;
    tol = p.Results.tolerance;
    
    % make sure exc is a cell array
    if ~iscell(exc)
       exc = {exc}; 
    end
    

    scale_mat = (1+tol)*eye(2);
    
    exc_elem = element_array(exc).apply_transformation(scale_mat);
    exc_pol = exc_elem.convert2pol();
    
    hole = circle(hole_r);
    
    x_num = floor(wx/hole_d);
    y_num = floor(wy/hole_d);
    hole_arr_temp = hole.duplicate([y_num, x_num], [hole_d, hole_d]);
    counter = 0;
    for i = 1:y_num
        for j = 1:x_num
            if ~overlaps(hole_arr_temp.elements{i,j}.convert2pol,exc_pol)
               hole_arr{counter+1} = hole_arr_temp.elements{i,j};
               counter =  counter+1;
            end
        end
    end
    
    elem_out = element_array(hole_arr);
    
    
    
    
    
end