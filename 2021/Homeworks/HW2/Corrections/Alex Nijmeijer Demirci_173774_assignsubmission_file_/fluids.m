% DigiPen Bilbao
%
% PHY250 Fall 2021
%
% Alex Demirci
% malex.demirci@digipen.edu
% 11/10/2021
%
%===============================================================================

function fluids
  
  A = 0.6;
  B = 4;
  
  timestep = 50;
  
  x = linspace(-10, 10, timestep);
  y1 =  linspace(-10, 10, timestep);
  y2 =  linspace(-10, 10, timestep);
  
  xRow = linspace(-10, 10, timestep); % all heights share the same x positition
  
  heightMatrix = zeros(7, timestep); % matrix storing the heights at each point
  velX = zeros(1, timestep);  % array of velocities X
  velY = zeros(1, timestep);  % array of velocities Y (all 0)
  
  % compute the upper and lower bounds of the functions y1 and y2
  for index = 1:1:timestep   
    Ax = A * x(index);
    
    y1(index) = -tanh(Ax) + tanh(Ax - B) + B;
    y2(index) = -y1(index);  
  endfor
  

  figure(1);        % create the window
  title('Fluids');
  xlabel('X');
  ylabel('Y');
  axis([-10,10,-10,10]); % fix the axis
  
  plot(x, y1);  % plot upper bound
  hold on; 
  plot(x, y2); % plot lower bound
  axis([-10,10,-10,10]); % fix the axis
  
   for col = 1:1:timestep
    for row = 1:1:8 
      if(row == 1)
         heightMatrix(row, col) = y1(col) - 0.3;
      else 
        topHeight = y1(col);
        botHeight = y2(col);
  
        deltaH = abs(topHeight - botHeight);
        
        % spacing between each particle at a certain points
        particleSpacing = deltaH / 7;
         
         % height is the height of the particle above - space between them
        heightMatrix(row, col) = heightMatrix(row - 1, col) - particleSpacing;
       endif
    endfor
endfor


firstArea = pi * y1(1) * y1(1);
v0x = 0.5;
v0y = 0;

velX(1, 1) = v0x;
velY(1, 1) = v0y;

   for col = 2:1:timestep
      radius = topHeight = y1(col);  % radius at current position
      
      area = pi * radius * radius;  % cross section area
      
      velocityX = (firstArea * v0x) / area; %velocity at that point
      
      velX(1, col) = velocityX;        %store velocity
   
  endfor


  particleX = -10;
  particleY = y1(1);

  out_dir = "temp_img";
  mkdir(out_dir);



 for columns = 1:1:timestep
    for rows = 1:1:7
      velocity = velX(columns); % get velocity at this point
  
      particleX = xRow(columns) + velocity - 0.5; % add the velocity
      particleY = heightMatrix(rows, columns) - 0.1; %get the height

     plot(particleX, particleY, "bko"); % plot the particle
     hold on;
    endfor 
   fname = fullfile (out_dir, sprintf("img%03i.png", columns));
   imwrite (getframe (gcf).cdata, fname);   
  endfor
  
 endfunction