
classdef alignment_M  < compound_element
% written by Samuel, 30.08.20
% editted by Guy, 01.10.20
% Alignment Marks
    methods
        function [obj] = alignment_M(R, text_str)
            
            if nargin<1
                R=30;
                text_str = ' '; % GUY - an ugly but easy way to write nothing if no txt supplied
                
            end
            if nargin<2
                text_str = ' '; % GUY - an ugly but easy way to write nothing if no txt supplied
            end
            % call parent constructor
           obj@compound_element();
           
           obj.sub_elements.arc_L = arc(R,2*pi,R/2-5);
           obj.sub_elements.arc_S = arc(3,2*pi,2);
           
           
           obj.sub_elements.topLef = polygon_element([-R/2 R*2; -3 R*2; -3 R/2]);
           obj.sub_elements.topRig = polygon_element([R/2 R*2; 3 R*2; 3 R/2]);
           
           obj.sub_elements.lefUp = obj.sub_elements.topLef.copy().rotate(pi/2);
           obj.sub_elements.lefdown = obj.sub_elements.topRig.copy().rotate(pi/2);
           
           obj.sub_elements.botrig = obj.sub_elements.topLef.copy().rotate(pi);
           obj.sub_elements.butlef = obj.sub_elements.topRig.copy().rotate(pi);
           
           obj.sub_elements.rigUp = obj.sub_elements.topLef.copy().rotate(-pi/2);
           obj.sub_elements.rigdown = obj.sub_elements.topRig.copy().rotate(-pi/2);
           
           RectArr=duplicate(rect(10,10),[4 4],[20,20]);
           obj.sub_elements.RectArr_LeftUP   =RectArr.shift([-100,100]);
           obj.sub_elements.RectArr_Leftdown =RectArr.copy.shift([0,-200]);
           obj.sub_elements.RectArr_rightdow =RectArr.copy.shift([200,0]);
           obj.sub_elements.RectArr_rightUp  =RectArr.copy.shift([200,-200]);
           
           % GUY - add text label:
           obj.sub_elements.text = text_element(text_str, R*1.2).shift([-50, 150]);
           
        end
    end
    
end