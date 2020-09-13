% written by Samuel, 10.09.20
classdef Kagome_cross  < compound_element
    methods
        function [obj] = Kagome_cross (KP)
            %KP = Kagome_Piece; Basic element of Kagome lattice
            %direction = 0,1 (0: triangle points up, 1: points down).
   
            
           % call parent constructor
           obj@compound_element();
           
           obj.sub_elements.straight    = KP;
           obj.sub_elements.bottom      = obj.sub_elements.straight.copy().rotate(-2*pi/3);
           obj.sub_elements.top         = obj.sub_elements.straight.copy().rotate(2*pi/3);
           
           obj.sub_elements.bottom.place("output", obj.sub_elements.straight.ports.output);
           obj.sub_elements.top.place("output", obj.sub_elements.straight.ports.output);
          
           obj.ports.top=obj.sub_elements.top.ports.input;
           obj.ports.bottom=obj.sub_elements.bottom.ports.input;
           obj.ports.right=obj.sub_elements.straight.ports.input;
           
           
        end
    end
    
end