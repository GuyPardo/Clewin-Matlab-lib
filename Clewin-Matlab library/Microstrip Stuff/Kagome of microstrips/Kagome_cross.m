% written by Samuel, 10.09.20
classdef Kagome_cross  < compound_element
    methods
        function [obj] = Kagome_cross (KP)
            %KP = Kagome_Piece; Basic element of Kagome lattice
            %direction = 0,1 (0: triangle points up, 1: points down).
   
            
           % call parent constructor
           obj@compound_element();
           
           obj.elements.straight    = KP;
           obj.elements.bottom      = obj.elements.straight.copy().rotate(-2*pi/3);
           obj.elements.top         = obj.elements.straight.copy().rotate(2*pi/3);
           
           obj.elements.bottom.place("output", obj.elements.straight.ports.output);
           obj.elements.top.place("output", obj.elements.straight.ports.output);
          
           obj.ports.top=obj.elements.top.ports.input;
           obj.ports.bottom=obj.elements.bottom.ports.input;
           obj.ports.right=obj.elements.straight.ports.input;
           
           
        end
    end
    
end