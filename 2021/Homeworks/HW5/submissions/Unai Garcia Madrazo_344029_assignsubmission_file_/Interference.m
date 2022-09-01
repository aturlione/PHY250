function Interference
  figure(1);
  
  factor = 4;
  
  axis([-factor*pi factor*pi -factor*pi factor*pi -2 2]);
  
  %Name for the folder to create the images at
  out_dir = "result_images_interference";
  out_dir_2 = "result_images_interference_not_rotated";
  %Makes the directory
  mkdir(out_dir);
  mkdir(out_dir_2);

  %Initial values
  w = 1;
  A = 1;
  
  %Values for the arrays
  min_range = -4*pi;
  max_range = 4*pi;
  
  temporal_steps = 200;
  spacial_steps = 100;
  
  %Initializes the arrays
  t = linspace(0,20,temporal_steps);
  x = linspace(min_range,max_range,spacial_steps);
  y = linspace(min_range,max_range,spacial_steps);
  [xx,yy] = meshgrid(x,y);
  z = [];
  
  traslation = 5;
  
  
  %Computes the z values and draws (Rotated so only sees from the top)
  for i=1:temporal_steps
    z = A * sin((2*sqrt((xx.*xx)+((yy-traslation).*(yy-traslation)))) - w*t(i));
    surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 4]);
    view(0,90);
    hold on;
   
    z = A * sin((2*sqrt((xx.*xx)+((yy+traslation).*(yy+traslation)))) - w*t(i));
    surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 4]);
    view(0,90);   
    hold off;    
 
    %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname);   
  endfor  
  
  %Computes the z values and draws
  figure(2)
  for i=1:temporal_steps
    z = A * sin((2*sqrt((xx.*xx)+((yy-traslation).*(yy-traslation)))) - w*t(i));
    surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 4]);
    view(15,40);
    hold on;
   
    z = A * sin((2*sqrt((xx.*xx)+((yy+traslation).*(yy+traslation)))) - w*t(i));
    surf(x,y,z);
    axis([-factor*pi factor*pi -factor*pi factor*pi -2 4]);
    view(15,40);   
    hold off;    
 
    %Writes into file images at the end   
    fname = fullfile(out_dir_2, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname);   
  endfor  
endfunction


%Questions:

%1. choose one of the three cases of the exercise 2 to simulate the sources. Which oneis the right choice? why?

  %The function will be the second one as is the only one of the three with a movement similar to a wave on water

%2. What happens when you increase the distanced?

  % The higher the distance between both, the more points where there are destructive interferences are created
  
%3. What happens when you modify the frequency of one of the sources?

  % If just one of the frequencies is changed the overlapping will not be repetitive or symetric, 
  % meaning that the maximums and minimums will not appear in a pattern
