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
           
           obj.elements.Resonator   = rect(RL,RW);
           obj.elements.Coupler_L   = rect(CL,CW);
           obj.elements.Coupler_R   = obj.elements.Coupler_L.copy();

           obj.elements.Coupler_L.place("right", obj.elements.Resonator.ports.left);
           obj.elements.Coupler_R.place("left", obj.elements.Resonator.ports.right);
           
           %Define ports
           obj.ports.input  = obj.elements.Coupler_L.ports.left;
           obj.ports.output = obj.elements.Coupler_R.ports.right;
        end
    end
    
end