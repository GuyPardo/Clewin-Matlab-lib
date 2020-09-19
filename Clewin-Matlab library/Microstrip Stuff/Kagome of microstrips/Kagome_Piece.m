% written by Samuel, 10.09.20
classdef Kagome_Piece  < compound_element
    methods
        function [obj] = Kagome_Piece(RL,CL,RW,CW)
            %RL = Resonator length
            %CL = Coupler Length
            %RW = Resonator Width
            %CW = Coupler Width
            
            L0 = layer(0,"Layer 1");
            L1 = layer(1, "Layer 2");
            
            % call parent constructor
           obj@compound_element();
           
           obj.sub_elements.Resonator   = rect(RL,RW);
           obj.sub_elements.Coupler_L   = rect(CL,CW);
           obj.sub_elements.Coupler_R   = obj.sub_elements.Coupler_L.copy();

           obj.sub_elements.Coupler_L.place("right", obj.sub_elements.Resonator.ports.left);
           obj.sub_elements.Coupler_R.place("left", obj.sub_elements.Resonator.ports.right);
           
           %Define ports
           obj.ports.input  = obj.sub_elements.Coupler_L.ports.left;
           obj.ports.output = obj.sub_elements.Coupler_R.ports.right;
        end
    end
    
end