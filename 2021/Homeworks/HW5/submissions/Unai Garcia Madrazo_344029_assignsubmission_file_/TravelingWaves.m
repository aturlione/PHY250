function TravelingWaves

  figure(1);
  
  factor = 4;
  
  axis([-factor*pi factor*pi -factor*pi factor*pi -2 2]);
  
  %Name for the folder to create the images at
  out_dir = "result_images_traveling";
  %Makes the directory
  mkdir(out_dir);
  
  %Values for the function
  w = 1;
  A = 1;

  k_1 = [2,0];
  k_3 = [2,2];
  
  %Values for the axis
  min_range = -4*pi;
  max_range = 4*pi;
  
  temporal_steps = 200;
  spacial_steps = 100;
  
  %Creates the arrays for x,y and time
  t = linspace(0,20,temporal_steps);
  x = linspace(min_range,max_range,spacial_steps);
  y = linspace(min_range,max_range,spacial_steps);
  [xx,yy] = meshgrid(x,y);
  z = [];
  
  %Loops computing the values for the z and plots
  for i=1:temporal_steps
    
  subplot(3,1,1)
    z = A * sin(k_1(1)*(xx) + k_1(2)*(yy) - w*t(i));
    S = surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 2]);
    view(15,40); 
    
  subplot(3,1,2)
    z = A * sin((2*sqrt((xx.*xx)+(yy.*yy))) - w*t(i));
    surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 2]);
    view(15,40);  
    
  subplot(3,1,3)
    z = A * sin(k_3(1)*(xx) + k_3(2)*(yy) - w*t(i));
    surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 2]);   
    view(15,40); 
    
    %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    
  endfor 
endfunction
