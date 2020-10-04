classdef adiabatic_opening < compound_element
    %adiabatic_opening coplanar adiabatic opening
    %   ports:
    %   input
    %   output
    
    properties
        length
        trace_w_in
        trace_w_out
        gap_w_in
        gap_w_out
    end
    
    methods
        function obj = adiabatic_opening(length,trace_w_in, gap_w_in, trace_w_out, gap_w_out)
            %adiabatic_opening Construct an instance of this class
            %   input arguments:
            %   length
            %   trace_w_in
            %   gap_w_in
            %   trace_w_out
            %   gap_w_out (optional) - if not supplied, keep the same ratio
            %   trace/gap
            if nargin<5
                gap_w_out = trace_w_out*(gap_w_in/trace_w_in);
            end
            
            % defining properties
            obj.trace_w_in = trace_w_in;
            obj.trace_w_out = trace_w_out;
            obj.gap_w_in = gap_w_in;
            obj.gap_w_out = gap_w_out;
            obj.length = length;
            % building element
                % defining basic polygon
                 pol_nodes = [0 trace_w_in/2;
                              0 trace_w_in/2+gap_w_in;
                              length trace_w_out/2+gap_w_out;
                              length trace_w_out/2];
                 pol = polygon_element(pol_nodes);
                 
                 % defining sub elements from basic polygon
                 obj.sub_elements.top = pol.copy().shift([-length/2,0]);
                 obj.sub_elements.bottom = obj.sub_elements.top.copy().reflect([1,0]);
                 
                 % defining ports
                 obj.ports.input = [-length/2,0];
                 obj.ports.output = [length/2,0];
                 
        end
        

    end
end

