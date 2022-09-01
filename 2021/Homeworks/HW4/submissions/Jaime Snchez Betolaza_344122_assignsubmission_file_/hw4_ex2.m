function hw4_ex2
  %Create figure and folder
  figure(1);
  out_dir = "ex2_images";
  mkdir (out_dir);
  
  
  m = 1;
  k = 1;
  %Compute the four omegas
  w_p_1 = sqrt(  k/m);
  w_p_2 = sqrt( (k/m) - ((0.1*0.1)/(4*m*m)) );
  w_p_3 = sqrt( (k/m) - ((1.1*1.1)/(4*m*m)) );
  w_p_4 = 0;
  b_4 = sqrt(4*k*m);
  A = 1;
  %Create the four arrays for the x position
  x_1(1) = 1;
  x_2(1) = 1;
  x_3(1) = 1;
  x_4(1) = 1;
  %Set a time step
  t = 0.1;
  
  for i = 2:1000
    %Compute each four positions arrays
    x_1(i) = A                    *cos(w_p_1*t);
    x_2(i) = A*exp(-(0.1/(2*m))*t)*cos(w_p_2*t);
    x_3(i) = A*exp(-(1.1/(2*m))*t)*cos(w_p_3*t);
    x_4(i) = A*exp(-(b_4/(2*m))*t)*cos(w_p_4*t);
    t += 0.1;
  endfor
    
  time = linspace(0, 100, 1000);
  for i = 1:300
    
    hold off;
    subplot (2, 1, 1);
    hold off;
    
    %Plot the four spheres
    plot(x_1(i), 1, 'ob');
    hold on;
    plot(x_2(i), 1.2, 'or');
    hold on;
    plot(x_3(i), 1.4, 'og');
    hold on;
    plot(x_4(i), 1.6, 'om');
    axis([-3, 3, 0.4, 2]);
    hold on;
    
    subplot (2, 1, 2);
    
    %Plot the four graphs
    plot(time, x_1, 'b');
    hold on;
    plot(time(i), x_1(i), '*b');
    hold on;
    
    plot(time, x_2, 'r');
    hold on;
    plot(time(i), x_2(i), '*r');
    hold on;
    
    plot(time, x_3, 'g');
    hold on;
    plot(time(i), x_3(i), '*g');
    hold on;
    
    plot(time, x_4, 'm');
    hold on;
    plot(time(i), x_4(i), '*m');
    hold on;
    axis([0, 50, -1.5, 1.5]);
    
    %Save the frammes
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
  endfor
  
endfunction
