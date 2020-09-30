classdef lollipop < compound_element
    %lollipop the lollipop shape for bosch layer in SNSPD
    
    
    properties
        Property1
    end
    
    methods
        function obj = lollipop(diameter, adiabatic_l,  neck_l, final_w, neck_w, cut_w, stop_l)  
            if nargin<1
                diameter = 2497; %diameter of desired lolipop
                cut_w = 200; 
                neck_w = 400;
                neck_l = 500;
                adiabatic_l = 3000;
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
            
            obj.sub_elements.circ = circ;
            obj.sub_elements.neck = neck.place('input',(obj.sub_elements.circ.ports.input_inner+obj.sub_elements.circ.ports.output_inner)/2 );
            obj.sub_elements.adiabatic = adiabatic.place('input', obj.sub_elements.neck.ports.output);
            obj.sub_elements.stop = stop.place('bottom', obj.sub_elements.adiabatic.ports.output);
        end
        
    end
end

