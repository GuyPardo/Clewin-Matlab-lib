classdef   horseshoe_coupler < compound_element
%  a horseshoe coupler element. written by Guy 2020_10_23note - this assumues that the coupling gap is the line gap
%  IMPORTANT NOTE:  this design assumues that the coupling gap is the same
%  as the line gap.
%  
%  ports details
%  output:  the input of whatever you want to couple to. also the origin of
%  this element
%  input: should be the output of the feed line.
%
% input arguments for ctor:
%
% required arguments:
% coupling_l - length of coupling
%
% optional parameters (call with name-value pair or a struct input):
% trace_w - width of the trace of the (coplanar) line you want to couple to
% (default value: 8)
% gap - width of the gap of the (coplanar) line you eant to couple to (default value: 5)
% coupler_w - width of the coupling electrodes (default value: 20) 

    properties
       trace_w
       gap
       coupler_w
       coupling_l
    end
    
    methods
        function obj  = horseshoe_coupler(coupling_l, varargin)
           % input parsing
           
           % default config
           trace_w_def = 8;
           gap_def = 5;
           coupler_w_def = 20;
           
           %input parser object
           p = inputParser;
           addRequired(p, 'coupling_l');
           addParameter(p, 'trace_w', trace_w_def);
           addParameter(p, 'gap', gap_def);
           addParameter(p, 'coupler_w', coupler_w_def);
           
           parse(p, coupling_l, varargin{:});
           
           %read arguments
           [obj.coupling_l] = p.Results.coupling_l;
           [obj.trace_w, trace_w] = deal(p.Results.trace_w);
           [obj.gap, gap] = deal(p.Results.gap);
           [obj.coupler_w, coupler_w] = deal(p.Results.coupler_w);
           
           % construct object:
            nodes = [...
            coupling_l, trace_w/2+gap;
            coupling_l+gap, trace_w/2+gap;
            coupling_l+gap, trace_w/2+gap+coupler_w+gap;
            -gap-trace_w-gap, trace_w/2+gap+coupler_w+gap;
            -gap-trace_w-gap, trace_w/2;
            -gap-trace_w, trace_w/2;
            -gap-trace_w, trace_w/2+gap+coupler_w;
            coupling_l, trace_w/2+gap+coupler_w;
            coupling_l, trace_w/2+gap];
        
           obj.elements.top_part = polygon_element(nodes);
           obj.elements.bottom_part = obj.elements.top_part.copy().reflect([1,0]);
           
            
           %define ports
           obj.ports.output = [0,0];
           obj.ports.input = [-gap-trace_w, 0];
  
           
        end
    end
end

