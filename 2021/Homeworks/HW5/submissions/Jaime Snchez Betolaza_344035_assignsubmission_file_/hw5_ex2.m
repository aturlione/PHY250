function hw5_ex2
  %Create the figure and the output folder
  figure(1);
  out_dir = "ex2_images";
  mkdir (out_dir);
  
  %Declare the two lengths
  Lx = 1;
  Ly = 1;
  %Declare the omega and the amplitude
  w = 1;
  A = 1;
  
  %Get a time sample
  t = linspace(0, 20, 200);
  %Create the grid
  tx = ty = linspace(-1, 1, 100)';
  [xx, yy] = meshgrid (tx, ty);
  
  %A factor for the axis
  factor = 2;
  
  for i = 1:200
    %Nx = 1, Ny = 1
    subplot(2, 2, 1);
    tz = 2*A*sin((1*pi)/Lx*xx).* sin((1*pi)/Ly*yy) * cos(w*t(i));
    surf(tx, ty, tz);
    axis([-1 1 -1 1 -2 2]);
    
    %Nx = 2, Ny = 1
    subplot(2, 2, 2);
    tz = 2*A*sin((2*pi)/Lx*xx).* sin((1*pi)/Ly*yy) * cos(w*t(i));
    surf(tx, ty, tz);
    axis([-1 1 -1 1 -2 2]);
    
    %Nx = 1, Ny = 2
    subplot(2, 2, 3);
    tz = 2*A*sin((1*pi)/Lx*xx).* sin((2*pi)/Ly*yy) * cos(w*t(i));
    surf(tx, ty, tz);
    axis([-1 1 -1 1 -2 2]);
    
    %Nx = 2, Ny = 2
    subplot(2, 2, 4);
    tz = 2*A*sin((2*pi)/Lx*xx).* sin((2*pi)/Ly*yy) * cos(w*t(i));
    surf(tx, ty, tz);
    axis([-1 1 -1 1 -2 2]);
        
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
  endfor
  
  
endfunction
