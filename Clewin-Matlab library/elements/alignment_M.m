
classdef alignment_M  < compound_element
% written by Samuel, 30.08.20
% editted by Guy, 01.10.20
% Alignment Marks
    methods
        function [obj] = alignment_M(R, text_str)
            
            if nargin<1
                text_str = ' '; % GUY - an ugly but easy way to write nothing if no txt supplied
                R=30;
                text_str = ' '; % GUY - an ugly but easy way to write nothing if no txt supplied
                
            end
            if nargin<2
                text_str = ' '; % GUY - an ugly but easy way to write nothing if no txt supplied
            end
            % call parent constructor
           obj@compound_element();
           
           obj.elements.arc_L = arc(R,2*pi,R/2-5);
           obj.elements.arc_S = arc(3,2*pi,2);
           
           
           obj.elements.topLef = polygon_element([-R/2 R*2; -3 R*2; -3 R/2]);
           obj.elements.topRig = polygon_element([R/2 R*2; 3 R*2; 3 R/2]);
           
           obj.elements.lefUp = obj.elements.topLef.copy().rotate(pi/2);
           obj.elements.lefdown = obj.elements.topRig.copy().rotate(pi/2);
           
           obj.elements.botrig = obj.elements.topLef.copy().rotate(pi);
           obj.elements.butlef = obj.elements.topRig.copy().rotate(pi);
           
           obj.elements.rigUp = obj.elements.topLef.copy().rotate(-pi/2);
           obj.elements.rigdown = obj.elements.topRig.copy().rotate(-pi/2);
           
           RectArr=duplicate(rect(10,10),[4 4],[20,20]);
           obj.elements.RectArr_LeftUP   =RectArr.copy().shift([-100,100]);
           obj.elements.RectArr_Leftdown =RectArr.copy().shift([-100,-100]);
           obj.elements.RectArr_rightdow =RectArr.copy().shift([100,-100]);
           obj.elements.RectArr_rightUp  =RectArr.copy().shift([100,100]);
           
           % GUY - add text label:
           obj.elements.text = text_element(text_str, R*1.2).shift([-50, 150]);
           
        end
    end
    
end