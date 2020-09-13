% written by Samuel, 10.09.20
classdef Kagome_triangle  < compound_element
    methods
        function [obj] = Kagome_triangle(KP)
            %KP = Kagome_Piece; Basic element of Kagome lattice
            %direction = 0,1 (0: triangle points up, 1: points down).
   
            
           % call parent constructor
           obj@compound_element();
           
           obj.sub_elements.bottom      = KP;
           obj.sub_elements.left        = obj.sub_elements.bottom.copy().rotate(pi/3);
           obj.sub_elements.right       = obj.sub_elements.bottom.copy().rotate(-pi/3);
           
           obj.sub_elements.left.place("input", obj.sub_elements.bottom.ports.input);
           obj.sub_elements.right.place("output", obj.sub_elements.bottom.ports.output);
          
           obj.ports.top=obj.sub_elements.left.ports.output;
           obj.ports.left=obj.sub_elements.left.ports.input;
           obj.ports.right=obj.sub_elements.right.ports.output;
        end
    end
    
end