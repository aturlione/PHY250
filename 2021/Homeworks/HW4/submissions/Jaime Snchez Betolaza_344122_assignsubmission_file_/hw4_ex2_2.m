function hw4_ex2_2
  %Create figure and folder
  figure(1);
  out_dir = "ex2_2_images";
  mkdir (out_dir);
  
  %Set the variables
  w = 0;
  b = 0.1;
  m = 1;
  k = 1;
  Fo = 1;
  wo = 1;
  
  %Get a sample for the force and the time
  w = linspace(0, 2, 300);
  t = linspace(0, 50, 300);
  
  for i = 2:300
    %Compute the amplitude, the resonance and the x position
    temp = (w(i)*w(i) - wo*wo);
    A(i) = Fo/(m*sqrt( temp*temp + ((b*b*w(i)*w(i))/m*m)));
    R(i) = atan((wo*wo* - w(i)*w(i))/w(i));
    x(i) = A(i)*sin(w(i)*t(i) + R(i));
    x_show(i) = 2 * cos(t(i));
  endfor
  
  for i = 2:300
    
    %Plot the two particles moving
    subplot (3, 1, 1);
    plot(x(i), 1.6, 'or');
    hold on;
    plot(2*cos(t(i)), 1, 'ob');
    axis([-15, 15, 0.4, 2]);
    
    %Plot the graph of the Amplitude respect to the time 
    %for each frame
    subplot(3, 1, 2);
    for j = 1:300
       temp_x(j) = A(i) * cos(wo*t(j));
    endfor
    plot(t, temp_x, 'r');
    hold on;
    plot(t(i), temp_x(i), '*r')
    hold on;
    plot(t, x_show, 'b')
    axis([0, 50, -15, 15]);
    
    %Plot the Amplitude increment respect to the time
    subplot(3, 1, 3);
    plot(w, A, 'r');
    hold on;
    plot(w(i), A(i), '*r')
    axis([0, 2, 0, 15]);
    
    %Save the frammes
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
    
    %Erase everything for the next frame
    hold off;
    subplot(3, 1, 2);
    hold off;
    subplot(3, 1, 1);
    hold off;
  endfor
  
  
  
  
  
  
  
  
  plot(w, A);
  axis([0, 2, 0, 15]);
  
  
  
  
  
endfunction
