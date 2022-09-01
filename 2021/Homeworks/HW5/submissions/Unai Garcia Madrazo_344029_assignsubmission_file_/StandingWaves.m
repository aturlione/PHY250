function StandingWaves
  
  figure(1);
  
  factor = 1;
  
  axis([-factor factor -factor factor -2 2]);
  
  %Name for the folder to create the images at
  out_dir = "result_images_standing";
  %Makes the directory
  mkdir(out_dir);
  
  %Initial values
  Lx = 1;
  Ly = 1;
  w = 1;
  A = 1;
  n_1 = [1,1];
  n_2 = [2,6];
  n_3 = [6,2];
  
  range = 1;
  %Values for the arrays  
  temporal_steps = 200;
  spacial_steps = 100;
  
  %Initializes the arrays
  t = linspace(0,20,temporal_steps);
  x = linspace(-range,range,spacial_steps);
  y = linspace(-range,range,spacial_steps);
  [xx,yy] = meshgrid(x,y);
  z = [];
  
  %Computes the values for the z and draws
  for i=1:temporal_steps
    
    subplot(3,1,1)
    z = A * sin((n_1(1)*pi*xx)/Lx).* sin((n_1(2)*pi*yy)/Ly) * cos(w*t(i));
    S = surf(x,y,z);
    axis([-factor factor -factor factor -2 2]);
    view(15,40); 
    
    subplot(3,1,2)
    z = A * sin((n_2(1)*pi*xx)/Lx).* sin((n_2(2)*pi*yy)/Ly) * cos(w*t(i));
    S = surf(x,y,z);
    axis([-factor factor -factor factor -2 2]);
    view(15,40);
   
    subplot(3,1,3)
    z = A * sin((n_3(1)*pi*xx)/Lx).* sin((n_3(2)*pi*yy)/Ly) * cos(w*t(i));
    S = surf(x,y,z);
    axis([-factor factor -factor factor -2 2]);
    view(15,40);  
    
        
    %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname);   
  endfor    
endfunction
