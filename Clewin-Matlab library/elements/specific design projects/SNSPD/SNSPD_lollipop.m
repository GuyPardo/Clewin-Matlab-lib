classdef SNSPD_lollipop < compound_element
    % lollipop shape for bosch layer in SNSPD
    % composed of a circular arc, a neck which is a short coplanar line and
    % then a long coplanar adiabatic opening, and a "stop" (a small
    % rectangle) at the end for easy breaking.
    %
    % ctop input arguments:
    % (running lollipop() gives the default parameters)
%                 diameter = 2497  
%                 cut_w = 200; 
%                 neck_w = 400;
%                 neck_l = 500;
%                 adiabatic_l = 3050;
%                 final_w = 900;
%                 stop_l = final_w/2; 
    
    
    properties
        Property1
    end
    
    methods
        function obj = SNSPD_lollipop(diameter, adiabatic_l,  neck_l, final_w, neck_w, cut_w, stop_l)  
            if nargin<1
                diameter = 2497; %diameter of desired lolipop
                cut_w = 200; 
                neck_w = 400;
                neck_l = 500;
                adiabatic_l = 3050;
                final_w = 900;
                stop_l = final_w/2; 
            end
            
            
            % circular part
            Rin = 0.5*diameter;
            R_arc  = Rin + cut_w/2;
            opening_angle = 2*asin(neck_w/Rin/2);

            circ = arc(R_arc, 2*pi-opening_angle, cut_w).rotate(pi/2+opening_angle/2);

            % neck
            neck = coplanar_line(neck_l,neck_w, cut_w).rotate(pi/2);

            % adiabatic
            adiabatic = adiabatic_opening(adiabatic_l, neck_w, cut_w, final_w, cut_w).rotate(pi/2);
            
            % stop
            stop = rect(stop_l,cut_w);
            
            obj.elements.circ = circ;
            obj.elements.neck = neck.place('input',(obj.elements.circ.ports.input_inner+obj.elements.circ.ports.output_inner)/2 );
            obj.elements.adiabatic = adiabatic.place('input', obj.elements.neck.ports.output);
            obj.elements.stop = stop.place('bottom', obj.elements.adiabatic.ports.output);
        end
        
    end
end

