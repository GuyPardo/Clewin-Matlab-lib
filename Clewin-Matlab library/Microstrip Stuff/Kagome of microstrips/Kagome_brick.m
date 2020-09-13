% written by Samuel, 10.09.20
classdef Kagome_brick  < compound_element
    methods
        function [obj] = Kagome_brick(KagomeTriangle)
            %KP = Kagome_Piece; Basic element of Kagome lattice
            %direction = 0,1 (0: triangle points up, 1: points down).
   
            
           % call parent constructor
           obj@compound_element();
           
           obj.sub_elements.triangleU      = KagomeTriangle;
           obj.sub_elements.triangleD      = obj.sub_elements.triangleU.copy().rotate(pi);
           obj.sub_elements.triangleLU     = KagomeTriangle.copy();
           obj.sub_elements.triangleLD     = obj.sub_elements.triangleU.copy().rotate(pi);
           
           obj.sub_elements.triangleU.place("top",obj.sub_elements.triangleD.ports.top);
           obj.sub_elements.triangleLU.place("right",obj.sub_elements.triangleD.ports.right);
           obj.sub_elements.triangleLD.place("top",obj.sub_elements.triangleLU.ports.top);
           
        end
    end
    
end