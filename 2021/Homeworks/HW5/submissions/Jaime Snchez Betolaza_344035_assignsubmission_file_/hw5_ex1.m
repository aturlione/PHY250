function hw5_ex1
  %Create the figure and the output folder
  figure(1);
  out_dir = "ex1_images";
  mkdir (out_dir);
  
  %Declare the omega and the amplitude
  w = 1;
  A = 1;
  
  %Get a time sample
  t = linspace(0, 20, 200);
  %Create a grid
  tx = ty = linspace(-4*pi, 4*pi, 100)';
  [xx, yy] = meshgrid (tx, ty);
  factor = 2;
  
  for i = 1:200
    %K = (2, 0)
    subplot(3, 1, 1);
    tz = sin(2*xx + 0*yy -w*t(i));
    surf(tx, ty, tz);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 2]);
    
    %K = (2, 2)
    subplot(3, 1, 2);
    tz = sin(2*xx + 2*yy -w*t(i));
    surf(tx, ty, tz);
    axis([-2*pi 2*pi -2*pi 2*pi -2 2]);
    
    %K = 2*er
    subplot(3, 1, 3);
    tz = sin(2*sqrt(xx.*xx + yy.*yy) - w*t(i));
    surf(tx, ty, tz);
    axis([-2*pi 2*pi -2*pi 2*pi -2 2]);
    
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
  endfor
  
  
  
  
endfunction
