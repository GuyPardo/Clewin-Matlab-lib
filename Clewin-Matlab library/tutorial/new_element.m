classdef new_element < compound_element
    % write here class documentation
    % you can (and should) write a long and detailed documentation
    % parafraph
    %
    % you can add line seperations for clarity 
    %
    % empty line sohuld also be commented
    
    % this line is already not a part of the class documentation paragraph
    % and thus, it will not show when someone runs:
    % help new_element
    properties
        property1 % documentation for property1
        property2 % documentation for property2
        % some other properties
    end
    
    methods
        function [output] = method1(obj)
         % write here documentation paragraph for method1 
            output = obj.property1 + obj.property2;
        end
        % some other methods 
       
    end
end