%========================================================
% PHY250 HW4
% Digipen Bilbao
% Javier Guerra  - j.guerra@digipen.edu
%========================================================

function exercise2
  precision = 300;
  m = 1;
  k = 1;
  A = 1;
  x1 = zeros(1,precision);
  x1(1) = A;
  v = zeros(1,precision);
  v(1) = 0;
  w = sqrt(k/m);
  delta_time = 0.05;
  %Create folder for the video
  out_dir = "temp_img";
  mkdir(out_dir);
  
  % 1. SHO motion
  t = linspace(0, 50, precision);
  for i = 1 : precision
      x1(i) = A * cos(w * t(i));
  endfor
  

  subplot(2,1,2)
  plot(t,x1, "Color", 'b')
  axis([0 50 -1.5 1.5])
  xlabel("t",'FontWeight','bold')
  ylabel("x",'FontWeight','bold')
  hold on;
  
  
  % 2.1 Damped motion with b = 0.1
  b = 0.1;
  gamma = b/(2*m);
  w = sqrt((k/m)- (b*b)/(4*m*m));
  x2 = zeros(1,precision);
  x2(1) = A;
  
  for i = 1 : precision
    x2(i) = A*e^(-gamma*t(i)) * cos(w * t(i));
  endfor
  subplot(2,1,2)
  plot(t,x2,"Color", 'r')
  hold on;
  
  % 2.2 Damped motion with b = 1.1
  b = 1.1;
  gamma = b/(2*m);
  w = sqrt(k/m - (b*b)/(4*m*m));
  x3 = zeros(1,precision);
  x3(1) = A;
  
  for i = 1 : precision
    x3(i) = A*e^(-gamma*t(i)) * cos(w * t(i));
  endfor
  subplot(2,1,2)
  plot(t,x3, "Color", 'g')
  hold on;
  
  % 2.3 Damped motion with b = bcri
  b = 0.1;
  gamma = b/(2*m);
  w = sqrt(k/m - (b*b)/(4*m*m));
  x4 = zeros(1,precision);
  x4(1) = A;
  
  for i = 1 : precision
    x4(i) = A*e^(-gamma*t(i)); %* cos(w * t(i));
  endfor
  
  subplot(2,1,2)
  plot(t,x4,"Color", 'm')
  
  %Plot particles doing the motion
  for i = 1:precision
    subplot(2,1,1)
    plot(x1(i),1,'o', "Color", 'b');
    hold on;
    plot(x2(i),1.2,'o',"Color", 'r');
    hold on;
    plot(x3(i),1.4,'o', "Color", 'g');
    hold on;
    plot(x4(i),1.6,'o',"Color", 'm');
    axis([-3 3 0 2]);
    hold off;
    %Create a image
    fname = fullfile (out_dir, sprintf("img%03i.png", i));
    imwrite (getframe (gcf).cdata, fname);
  endfor
  
endfunction