% written by Samuel, 10.09.20
classdef Kagome_brick  < compound_element
    methods
        function [obj] = Kagome_brick(KagomeTriangle)
            %KP = Kagome_Piece; Basic element of Kagome lattice
            %direction = 0,1 (0: triangle points up, 1: points down).
   
            
           % call parent constructor
           obj@compound_element();
           
           obj.elements.triangleU      = KagomeTriangle;
           obj.elements.triangleD      = obj.elements.triangleU.copy().rotate(pi);
           obj.elements.triangleLU     = KagomeTriangle.copy();
           obj.elements.triangleLD     = obj.elements.triangleU.copy().rotate(pi);
           
           obj.elements.triangleU.place("top",obj.elements.triangleD.ports.top);
           obj.elements.triangleLU.place("right",obj.elements.triangleD.ports.right);
           obj.elements.triangleLD.place("top",obj.elements.triangleLU.ports.top);
           
        end
    end
    
end