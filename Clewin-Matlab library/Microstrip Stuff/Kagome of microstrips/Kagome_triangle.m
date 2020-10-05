% written by Samuel, 10.09.20
classdef Kagome_triangle  < compound_element
    methods
        function [obj] = Kagome_triangle(KP)
            %KP = Kagome_Piece; Basic element of Kagome lattice
            %direction = 0,1 (0: triangle points up, 1: points down).
   
            
           % call parent constructor
           obj@compound_element();
           
           obj.elements.bottom      = KP;
           obj.elements.left        = obj.elements.bottom.copy().rotate(pi/3);
           obj.elements.right       = obj.elements.bottom.copy().rotate(-pi/3);
           
           obj.elements.left.place("input", obj.elements.bottom.ports.input);
           obj.elements.right.place("output", obj.elements.bottom.ports.output);
          
           obj.ports.top=obj.elements.left.ports.output;
           obj.ports.left=obj.elements.left.ports.input;
           obj.ports.right=obj.elements.right.ports.output;
        end
    end
    
end