%Alex Demirci
%Excercise2 for Homework5
% 29/11/2021

function excercise2
  
  out_dir = "Excercise2";
  mkdir(out_dir);
  
  % harmonics
  n1 = 1;
  n2 = 2;
  n3 = 3;
  
  precision = 100;
  
  % frequency
  w = 1;
  
  % length in x and y
  Lx = 1;
  Ly = 1;
  
  % wavenumbers... Lx = Ly so we use one of them
  k1 = (n1 * pi) / Lx;
  k2 = (n2 * pi) / Lx;
  k3 = (n3 * pi) / Lx;
  

  % x and y positions
  x = linspace(-1,  1, precision);
  y = linspace(-1, 1, precision);
  
  % meshgrid
  [xx, yy] = meshgrid(x, y);
  
  time = 0;
  timeSamples = 200;
  timeStep = 0.1
  
  for i = 1 : timeSamples
    
    % compute the z value using the standing waves equation
    z = 2 * sin(k1*xx).*sin(k1*yy) * cos(w * time);
    
    % plot the surface
    S = surf(x, y, z);
    axis([-1  1  -1 1 -2 2]);
     
     time += timeStep;
     
    fname = fullfile (out_dir, sprintf("img%03i.png", i));
    imwrite (getframe (gcf).cdata, fname);
  endfor
  
  
endfunction
