classdef doze_test_lines < compound_element
    %Doze_test_lines creates horizontal and vertical lines for doze testing
    % with text indicating the width of the lines
    % argumaents for ctor:
    % line_w : width of each line
    %
    % optional parameters: (call with name-value pair)
    % n_lines (default value: 4) number of horizontal and vertical lines
    % line_l (default value: 100) : length of each line 
    % gap (default value: same as line_w) : gap between the lines
    %
    % ports:  just the origin, which is located at the center of
    % the design
    
    properties
        n_lines
        line_w
        line_l
        gap
    end
    
    methods
        function obj = doze_test_lines(line_w, varargin)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            
            %parse input
            p = inputParser;
            p.addParameter('n_lines', 4);
            p.addParameter('line_l', 100);
            p.addParameter('gap', line_w);
            
            p.parse(varargin{:});
            obj.n_lines = p.Results.n_lines;
            obj.line_l = p.Results.line_l;
            obj.gap = p.Results.gap;
            obj.line_w = line_w;
            dist = obj.line_w + obj.gap;
            shift = obj.n_lines*dist/2;
            % actual ctor starts here
            unit_vert = rect(obj.line_w, obj.line_l).place('bottom', [0,0]);
            unit_horz = rect(obj.line_l, obj.line_w).place('right', unit_vert.ports.bottom);
            obj.elements.vert_array = unit_vert.duplicate([1,obj.n_lines], [0,dist]).shift([-shift,0]);
            obj.elements.horz_array = unit_horz.duplicate([obj.n_lines,1], [dist,0]).shift([0,shift]);
            
            txt_str = sprintf('%g um',obj.line_w );
            
            obj.elements.text = text_element(txt_str,obj.line_l*0.3).shift([-obj.line_l*1.15,obj.line_l*1.15])
            obj.shift([obj.line_l/2,-obj.line_l/2]);
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

