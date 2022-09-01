function FluidSimulation
  figure(1);
  axis([-10,10,-10,10]);
  
  %Name for the folder to create the images at
  out_dir = "result_images";
  %Makes the directory
  mkdir(out_dir);
  
  A = 0.6;
  B = 4;
  Precision = 92;
  N_Particles = 8;
  Particle_Rad = 0.5;
  
  %Used to print the tube
  x_values = linspace(-10,10,Precision);
  
  %Arrays for the values of the tube
  low_y_values = [];
  high_y_values = [];
  
  %Stores the values for the tube
  for i=1:Precision
    high_y_values(i) = -tanh(A*x_values(i)) + tanh(A+x_values(i)-B)+B;  
    low_y_values(i) = -high_y_values(i);
  endfor
  
 
  x_val1 = -11;
  x_val2 = -10; 
  x_val3 = -9; 
  x_val4 = -8; 
  for t=1:Precision
    
    PlotTube(x_values,high_y_values,low_y_values);
    
    %Gets the positions for each column of particles      
    particle_y1 = GetPositions(x_val1,N_Particles,Particle_Rad);
    particle_y2 = GetPositions(x_val2,N_Particles,Particle_Rad);
    particle_y3 = GetPositions(x_val3,N_Particles,Particle_Rad);
    particle_y4 = GetPositions(x_val4,N_Particles,Particle_Rad);
    %Gets the velocity for each column
    v1 = GetVelocity(x_val1);
    v2 = GetVelocity(x_val2);
    v3 = GetVelocity(x_val3);
    v4 = GetVelocity(x_val4);
    
    %Plots the particles    
    PlotParticles(x_val1,particle_y1);
    hold on;
    
    PlotParticles(x_val2,particle_y2);
    hold on;
    
    PlotParticles(x_val3,particle_y3); 
    hold on;
    
    PlotParticles(x_val4,particle_y4);
    hold off;
    
    %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",t));
    imwrite(getframe(gcf).cdata,fname);   
    
    x_val1 +=v1;   
    x_val2 +=v2;   
    x_val3 +=v3;      
    x_val4 +=v4;      
  endfor
  
endfunction
function YPositions = GetPositions(X_Pos, N_Particles, Particle_Rad)
  
  A = 0.6;
  B = 4;
  %Computes the max and min, and gets all the positions
  y_max = -tanh(A*X_Pos) + tanh(A+X_Pos-B)+B;
  y_min = -y_max;  
  YPositions = linspace(y_min + Particle_Rad,y_max - Particle_Rad,N_Particles);  
endfunction

function Velocity = GetVelocity(X_Pos)
  
  A = 0.6;
  B = 4;  
  y_max = -tanh(A*X_Pos) + tanh(A+X_Pos-B)+B;
  y_min = -y_max;
  
  %Computes the dist (Used for A)
  y_dist = y_max - y_min;
  
  %Computes the initial dist (Used for A0)
  y_max0 =  -tanh(A*0) + tanh(A+0-B)+B;
  y_min0 =  -y_max0;
  
  y_dist0 = y_max0 - y_min0;
  
  A   = y_dist * y_dist * 3.1415;
  A0  = y_dist * y_dist * 3.1415;
  
  v = (0.5 * A0)/A;
  Velocity = v/2.2; %Just to make it go slower
endfunction

function PlotTube(x_values,high_y_values,low_y_values)
   %Plot for the tube
  plot(x_values,high_y_values);
  axis([-10,10,-10,10]);
  hold on;
  plot(x_values,low_y_values);
  axis([-10,10,-10,10]);  
  hold on;  
endfunction
function PlotParticles(X_Pos,Y_Pos)
    plot(X_Pos,Y_Pos,'o');
    axis([-10,10,-10,10]);
endfunction