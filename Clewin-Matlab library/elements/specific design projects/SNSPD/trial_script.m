%% detector
    % meander
    trace_w = .200; gap_w = .200; segment_l = 10; 
    mea = SNSPD_meander(trace_w , gap_w, segment_l);
    % adiabatic opening
    adiabatic_l = 18; final_w = 18;
    ad = adiabatic_opening(adiabatic_l,trace_w,gap_w,18).place('input',mea.ports.output);

detector = compound_element();
detector.sub_elements.meander = mea;
detector.sub_elements.adiabatic = ad;
detector.ports.input =  detector.sub_elements.adiabatic.ports.output;
detector.ports.outpout =  detector.sub_elements.meander.ports.input;

SNSPD = compound_element();


SNSPD.sub_elements.detector = detector.rotate(pi/2);

clf; SNSPD.draw()



