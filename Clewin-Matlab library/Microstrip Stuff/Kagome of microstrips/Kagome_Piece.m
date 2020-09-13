% written by Samuel, 10.09.20
classdef Kagome_Piece  < compound_element
    methods
        function [obj] = Kagome_Piece(RL,CL,RW,CW)
            %RL = Resonator length
            %CL = Coupler Length
            %RW = Resonator Width
            %CW = Coupler Width
            
           L0 = layer(0,"Base");
           L1 = layer(1,"Elionix");
            
           % call parent constructor
           obj@compound_element();
           
           obj.sub_elements.Resonator   = rect(RL,RW).set_layer(L0);
           obj.sub_elements.Coupler_L   = rect(CL,RW).set_layer(L0);
           obj.sub_elements.Coupler_R   = obj.sub_elements.Coupler_L.copy().set_layer(L0);

           obj.sub_elements.Coupler_L.place("right", obj.sub_elements.Resonator.ports.left);
           obj.sub_elements.Coupler_R.place("left", obj.sub_elements.Resonator.ports.right);
           
           %Define ports
           obj.ports.input  = obj.sub_elements.Coupler_L.ports.left;
           obj.ports.output = obj.sub_elements.Coupler_R.ports.right;
           
           obj.sub_elements.CL_below=obj.sub_elements.Coupler_L.copy().shift([CW/2 -(RW+CW)/2]).set_layer(L1);
           obj.sub_elements.CL_above=obj.sub_elements.Coupler_L.copy().shift([CW/2 +(RW+CW)/2]).set_layer(L1);
           obj.sub_elements.CR_below=obj.sub_elements.Coupler_R.copy().shift([-CW/2 -(RW+CW)/2]).set_layer(L1);
           obj.sub_elements.CR_above=obj.sub_elements.Coupler_R.copy().shift([-CW/2 +(RW+CW)/2]).set_layer(L1);
           
        end
    end
    
end