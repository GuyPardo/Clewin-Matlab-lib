classdef SNSPD_feedline < compound_element
    %SNSPD_FEEDLINE the feedline for the SNSPD_detector.
    %   made out of an adiabatic opening, a coplanar line, and a launcher
    % ports:
    %
    % input : input (small side) of the adiabatic opening
    % pad :  center of launcher pad
    % origin : origin (center) of line
    % 
    % constructor input arguments;
    % 
    % line_l : length of coplanar line part
    % line_w : width of coplanar line part
    %
    % running SNSPD_feedline() gives the default setting:
    %  line_l = 3750; line_w = 80;
    

    
    methods
        function obj = SNSPD_feedline(line_l,line_w)
            %SNSPD_FEEDLINE Construct an instance of this class
            if nargin<1
                line_l = 3750; line_w = 80;
            end
            
            % line
            cl = coplanar_line(line_l, line_w, line_w*5/8 );
            
            % adiabatic opening input
            adiabatic_l = 80; small_w = 8; small_g = 5; large_w = 80;
            ad_in = adiabatic_opening(adiabatic_l,small_w,small_g,large_w);
            ad_in.place('output',cl.ports.input);
            
            % launcher
            contact_size = 300; lau_adiabatic_l = 300; 
            lau = launcher(contact_size, line_w,line_w*5/8,lau_adiabatic_l).reflect([0,1]).place('output', cl.ports.output);
            
            % define sub_elements:
            obj.sub_elements.line = cl;
            obj.sub_elements.adiabatic = ad_in;
            obj.sub_elements.launcher = lau;
            
            obj.rotate(pi/2);
            
            %define ports
            obj.ports.input = obj.sub_elements.adiabatic.ports.input;
            obj.ports.pad = obj.sub_elements.launcher.ports.center;
         
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

