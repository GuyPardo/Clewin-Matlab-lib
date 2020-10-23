clf;
%% feedline


% 2 laucnhers:
lau_in = launcher();
lau_out = launcher().reflect([0,1]);

% line
line_l = 5000; trace_w = 8; gap_w = 5;
line = coplanar_line(line_l, trace_w,gap_w);

% placing launchers relative to line
lau_in.place('output', line.ports.input);
lau_out.place('output', line.ports.output);

% define feedline
feedline = compound_element(line, lau_in, lau_out);

feedline.draw();

%% knee resonators
res_length = 7000;
coupling_l = 200;
coupling_gap = 25;
% define resonator
res = knee_resonator(res_length, coupling_l);

% place resonator
res.place('input', feedline.ports.origin  - [coupling_l,  coupling_gap]);

% duplicate resonators
arr1 = res.duplicate([1,5], [0,800]).draw();
arr2 = arr1.copy().reflect([1,0]).draw();


