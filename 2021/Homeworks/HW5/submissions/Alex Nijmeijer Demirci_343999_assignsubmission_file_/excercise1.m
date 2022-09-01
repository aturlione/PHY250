%Alex Demirci
%Excercise1 for Homework5
% 29/11/2021


function excercise1
  
  out_dir = "Excercise1";
  mkdir(out_dir);
  
  precision = 100;
  
  % amplitude and frequency
  A = 1;
  w = 1;
  
  % wave numbers
  k1 = [2, 0];
  k2 = [2, 2];
  

  % for x and y positions
  x = linspace(-4 * pi, 4 * pi, precision);
  y = linspace(-4 * pi, 4 * pi, precision);
  
  
  [xx, yy] = meshgrid(x, y);
  
  time = 0;
  timeSamples = 200;
  timeStep = 0.1;
  
  for i = 1 : timeSamples
    
   
    
    % first plit k = (2, 0)
    subplot(3, 1, 1);

     % compute the z value for k1
    z = A * sin(k1(1) * xx + k1(2) * yy - w * time);
    S = surf(x, y, z);
    axis([-2 * pi 2 * pi  -2 * pi  2 * pi -2 4]);
    axis('ji');
    xlabel("K = (2, 0)");
    
    % second plot k = 2 * Er
    subplot(3, 1, 2);
    length = sqrt(xx.*xx + yy.*yy);
    z = A * sin(2 * length - w * time);
    S = surf(x, y, z);
    axis([-2 * pi 2 * pi  -2 * pi  2 * pi -2 4]);
    axis('ji');
    xlabel("K = 2·ˆer");  
    
    
      % third plot k = (2, 2)
    subplot(3, 1, 3);
    z = A * sin(k2(1) * xx + k2(2) * yy - w * time);
    S = surf(x, y, z);
    axis([-2 * pi 2 * pi  -2 * pi  2 * pi -2 4]);
    axis('ji');
    xlabel("K = (2, 2)");
     
     time += timeStep;
     
    fname = fullfile (out_dir, sprintf("img%03i.png", i));
    imwrite (getframe (gcf).cdata, fname);
    
  endfor
endfunction
