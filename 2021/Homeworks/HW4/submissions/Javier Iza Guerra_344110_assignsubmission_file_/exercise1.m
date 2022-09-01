%========================================================
% PHY250 HW4
% Digipen Bilbao
% Javier Guerra  - j.guerra@digipen.edu
%========================================================

function exercise1
  l = 2;
  g = 9.8;
  precision = 300;
  delta_time = 0.05;
  angle = zeros(precision);
  w = zeros(precision);
  x = zeros(precision);
  y = zeros(precision);
  %Initial conditions
  w(1) = 0;
  angle(1)=45;
  x(1) = l * sin(angle(1));
  y(1) = l * cos(angle(1));
  %Create folder for the video
  out_dir = "temp_img";
  mkdir(out_dir);
  
  %Fill data with formulas of pendulum seen in class
  for i = 2 : precision
    w(i)     = w(i-1) + delta_time * ((-g/l) * sin(angle(i-1)));
    angle(i) = angle(i-1) + delta_time * w(i);
    x(i)     = l * sin(angle(i));
    y(i)     = l * cos(angle(i));
  endfor
  
  for i = 1 : precision
    %Plot the point
    plot(x(i),y(i),'*', 'Color', 'r')
    hold on;
    %Plot the line from the pendulum to the center
    plot([x(i), 0],[y(i), 0], 'Color', 'r')
    axis([-l - 0.3, l + 0.3, -l - 0.3, l + 0.3], "ij")
    hold off;
    
    %Create a image
    fname = fullfile (out_dir, sprintf("img%03i.png", i));
    imwrite (getframe (gcf).cdata, fname);
  endfor
  
endfunction

#INSTRUCTOR: you are only considering the semi-explicit method, you had to compare this results with the obtained considering an explicit method.