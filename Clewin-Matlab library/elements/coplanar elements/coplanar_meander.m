classdef coplanar_meander < compound_element
%   written by Guy 2020_08
%   a meandering coplanar line. all dimensions are in microns
%   
%   required input arguments for ctor:
%    N - number of line segments including the two shorter (half length) in
%       the input and in the output. 
%   optional parameter : call with name-value pair or with a struct input:
%   trace_w: width of the trace (metal) . default value: 8
%   gap_w: width of the gap (insulator . default value: 5
%   segment_l : the length of the bulk N-2 segments of the meander. there
%               are another two segments of length segmentl/2 in the input and in the
%               output. default value: 500
%   distance : the distance between the segments ( = the diameter of the
%   arcs). default value: 200
%
%   to make a tight-meander , set distance = trace_w + gap_w;
%
%  ports:
%
%  input
%  output
%  center=origin    
   properties
      length
      N
      trace_w
      gap_w
      boundaries
   end
   
   
   methods
       function [obj] = coplanar_meander(N, varargin)
        
        %% input parsing %%
        % default parameters:
        trace_w_def = 8;
        gap_w_def = 5;
        boundaries_def = [0,0];
        segment_l_def = 500;
        distance_def = 200;
        
        % input parser objecrt
        p = inputParser;
        addParameter(p, 'trace_w', trace_w_def);
        addParameter(p, 'gap_w', gap_w_def);
        addRequired(p,'N');
        addParameter(p, 'boundaries', boundaries_def);
        addParameter(p, 'segment_l', segment_l_def);
        addParameter(p, 'distance', distance_def);
        parse(p, N, varargin{:}); % parsing
        
        
        % reading parameters
        trace_w = p.Results.trace_w;
        gap_w = p.Results.gap_w;
        segment_l = p.Results.segment_l;
        distance = p.Results.distance;
        boundaries = p.Results.boundaries;
        

           
        %% constructing     
         R = distance/2;
        if N<3
            segment_l = 2*segment_l + 2*R;
        end
           
           
        arc_in = coplanar_arc(R,pi/2,trace_w, gap_w,[boundaries(1),0]).place('input', [-(N-1)/2*distance-R,0]);
        arcs_array = {arc_in};
        
        
        lines_array = cell(1,N);
            for i=1:N
                if i==1||i==N
                    L = segment_l/2-R;
                    
                else
                    L = segment_l;
                    
                end
                

                
                lines_array{i} = coplanar_line(L, trace_w, gap_w).rotate(pi/2*(-1)^i).place('input', arcs_array{i}.ports.output);
                if i==N
                    break
                end
                arcs_array = [arcs_array,  {coplanar_arc(R,pi*(-1)^i, trace_w, gap_w).place('input',lines_array{i}.ports.output)}];
                
            end
             
            arc_out = coplanar_arc(R,pi/2*(-1)^N,trace_w, gap_w, [0,boundaries(2)]).rotate(pi/2*(-1)^N).place('input', lines_array{end}.ports.output);
            
                     
            
            arcs_array = [arcs_array, {arc_out}];
            obj.elements.lines = element_array(lines_array);
            obj.elements.arcs  = element_array(arcs_array);
            
            
            % define other ports
            obj.ports.output = obj.elements.arcs.elements{end}.ports.output;
            obj.ports.center = obj.ports.origin;
            obj.ports.input = obj.elements.arcs.elements{1}.ports.input;
            
            % define properties
            obj.length = obj.get_length();
            obj.trace_w = trace_w;
            obj.gap_w = gap_w;
            obj.N=N;
            obj.boundaries = boundaries;
         
       end
       
       function [len] = get_length(obj)
           len=0; 
           for i = 1:numel(obj.elements.lines.elements)
            len = len + obj.elements.lines.elements{i}.length;   
           end
           
           for j = 1:numel(obj.elements.arcs.elements)
            len = len + obj.elements.arcs.elements{j}.length;   
           end


        end
    end
      
   
end
    