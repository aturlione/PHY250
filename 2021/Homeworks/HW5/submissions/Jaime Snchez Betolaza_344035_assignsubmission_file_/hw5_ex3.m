function hw5_ex3
  %Create the figure and the output folder
  figure(1);
  out_dir = "ex3_images";
  mkdir (out_dir);
  
  %Declare the omega and the amplitude
  w = 1;
  A = 1;
  
  %Get a time sample
  t = linspace(0, 20, 200);
  %Create the grid
  tx = ty = linspace(-4*pi, 4*pi, 100)';
  [xx, yy] = meshgrid (tx, ty);
  
  %A factor for the axis
  factor = 4;
  trans = 5;
  
  for i = 1:200
    %Clean frame
    hold off;
    
    %Compute the first fluctuation
    tz = A * sin((2*sqrt((xx.*xx)+((yy-trans).*(yy-trans)))) - w*t(i));
    surf(tx, ty, tz);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 4]);
    hold on;
    
    %Compute the second fluctuation
    tz = A * sin((2*sqrt((xx.*xx)+((yy+trans).*(yy+trans)))) - w*t(i));
    surf(tx, ty, tz);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 4]);
    view(0, 90);
    
    %Save the frame
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
  endfor 
endfunction