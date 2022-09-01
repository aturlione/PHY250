function hw4_ex1
  
  %Create figure and folder
  figure(1);
  out_dir = "ex1_images";
  mkdir (out_dir);
  
  %Length of the pendulum
  length = 2;
  %Get the initial omega and angle 
  %for he explicit and semi_explicit methods
  WE(1) = 0;
  OE(1) = 1;
  
  WS(1) = 0;
  OS(1) = 1;
  
  
  for i = 2:300
    %Compute each step the omega and the angle of the two methods
    WE(i) = WE(i-1) + 0.05*((-9.8/length) * sin(OE(i-1)));
    OE(i) = OE(i-1) + 0.05*WE(i-1);
    
    WS(i) = WS(i-1) + 0.05*((-9.8/length) * sin(OS(i-1)));
    OS(i) = OS(i-1) + 0.05*WS(i);
    
    hold off;
    
    %Draw explicit
    plot(length*sin(OE(i)), -length*cos(OE(i)), 'ok');
    axis([-2, 2, -2, 2]);
    hold on;
    line([0 length*sin(OE(i))], [0 -length*cos(OE(i))], "color", "k");
    axis([-2, 2, -2, 2]);
    hold on;
    
    %Draw semi-explicit
    plot(length*sin(OS(i)), -length*cos(OS(i)), 'or');
    axis([-2, 2, -2, 2]);
    hold on;
    line([0 length*sin(OS(i))], [0 -length*cos(OS(i))], "color", "r");
    axis([-2, 2, -2, 2]);
    hold on;
    
    
    %Save the frammes
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
  endfor
  
  
endfunction
