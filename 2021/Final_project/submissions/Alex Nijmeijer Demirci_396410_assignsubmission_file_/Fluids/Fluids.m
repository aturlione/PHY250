#################################################################
# TOTAL GRADE EXERCISE 1: 30/50p
#################################################################

# The answer to the questions are  ok ---> 15/15
#There are several errors in the simulation: --->15/35

#1. The condition to avoid penetration into the circle is wrong.
#2. Your considered that the velocity is the same for the 3 rows
#3. You missed the time step when performing the Euler integration for the position.



#################################################################


% PHY250 FALL 2021 ==============================
%
% Alex Demirci Nijmeijer
% alex.demirci@digipen.edu
% 145/12/2021
%
% This program simulates a fluid flowing through a
% circle using the Navier-Stokes equation
%===================================================


% Questions
%
% 1. What does "incompressible, non-viscous, circulation-free liquid" mean?
% - An incompressible fluid is a fluid that has constant density. Non-viscous
%   means that, as its name suggests, it has no viscosity (viscosity coefficient = 0)
%   This means that there is no friction inside the fluid and that, for example, the
%   particles would flow along a wall without reducing their speed.
%   
%
% 2. What is the difference between this fluid and the one we considered when we
%    solved problems during the course?
% -  In the problems we solved in class the streamlines could be obtained based on
%    the pressure, area and velocity at a given point, but in this case, the velocity
%    is obtained through a gradient using the Navier-Stokes equation. In addition to that, 
%    in this case we are not considering presure ---INSTRUCTOR: The equations are more complicated because 
                                                    #the velocity trought a perpendicular area is not constant. So, to solve the continuity equation we have to solve an integral. 
                                                    
%
% 3. Do you think that the volume rate flow is just "vA" in this case? Why yes o why not?
% - It would not be "vA" because that is only true for plane cross-sectional areas.
%   In addition to that, we can't obtain the streamlines based on a single velocity and
%   the area in a specific point. #INSTRUCTOR: In this case, the Bernoulli's equation is valid in a streamline, but not between two arbitrary points in the fluid.
%
% 4. How would you improve this model?
% - We could improve this model by making the fluid viscous in order to 
%   simulate the properties of fluids in a more realistic way and making
%   the particles interact with each other


function Fluids
  
  
  out_dir = "temp_img";
  mkdir(out_dir);
  
  samples = 21;
  
  % radius and initial velocity
  a = 0.4;
  v0 = 10;
  
  xx = linspace(-1.5, 1.5, samples);
  yy = linspace(-1.5, 1.5, samples);
  [x, y] = meshgrid(xx, yy);
  
  % gradient of the Navier-Stokes equation stored in matrices
  vx = -v0*(((-2*a^3 * x.^2  + a^3 * y.^2)./ ((2 * (x.^2 + y.^2).^(5/2)))) + 1);
  vy = (3 * a^3 * v0 * x.* y)./ (2 * (x.^2 + y.^2).^(5/2));
  
 % radius to the square
  aSquare = a^2; 

  % remove the arrows inside the circle
  for row = 1: length(x)
    for col = 1:length(y);
      
      velX = x(row, col);
      velY = y(row, col);
    
      if(velX^2 + velY^2 < aSquare)
        vx(row, col) = 0;
        vy(row, col) = 0;  
      endif
      
    endfor   
  endfor
  

  % first row of particles
  pX = linspace(1.5, 1.5, samples);
  pY = linspace(-1.5, 1.5, samples);
  
   % second row of particles
  pX2 = linspace(1.6, 1.6, samples);
  pY2 = linspace(-1.5, 1.5, samples);

   % third row of particles
  pX3 = linspace(1.7, 1.7, samples);
  pY3 = linspace(-1.5, 1.5, samples);
    
  time = 300;
  
  for timestep = 1 : time
    hold off;
  
    % draw the circle
    t = linspace(0,2*pi,100); 
    circsx = a.*cos(t) + 0; 
    circsy = a.*sin(t) + 0; 
    plot(circsx,circsy);
    axis([-1.5 1.5 -1.5 1.5], "square");
    title("Fluid Simulation \n Non viscosity - Non rotational", "fontsize", 20);
  
    hold on;
  
    scale = 0.01;
    % draw the arrows
    quiver(x, y, vx * scale, vy *scale, 'AutoScale', 'off');
    view(90,90);
    hold on;
  
     % for each particle
    for index = 1 : samples
  
      % interpolation of the current position and the position-velocity values
      velPosX = interp2(x,y,vx,pX(index), pY(index),'spline') * scale;
      velPosY = interp2(x,y,vy,pX(index), pY(index),'spline') * scale;

      
      % if traversing the circle, shift the particles to another position
      #INSTRUCTOR: the condition to avoid penetration inside the circle have to be done on the coordinates of the particles, not the velocity. 
      #the particles are penetrating the circle.
      if(abs(velPosX) < 0.05)
        velPosX = interp2(x,y,vx,pX(index - 1), pY(index)) * scale;
      endif
      
      % move the particle by the x velocity
      pX(index) += velPosX;  #INSTRUCTOR: the three rows of particles do not have the same velocity...The difference is more evident as the particles approaches the circle.
      pX2(index) += velPosX; #you are mising the timestep 
      pX3(index) += velPosX;
      
      % move the particle byu the y velocity
      pY(index) += velPosY;
      pY2(index) += velPosY;
      pY3(index) += velPosY;
      
      % plot the three rows
      plot(pX(index), pY(index), 'ob');
      axis([-1.5 1.5 -1.5 1.5], "square");
      view(90,90);
      hold on;  
      plot(pX2(index), pY2(index), 'ob');
      axis([-1.5 1.5 -1.5 1.5], "square");
      view(90,90);
      hold on;
       plot(pX3(index), pY3(index), 'ob');
      axis([-1.5 1.5 -1.5 1.5], "square");
      view(90,90);
      hold on;
    endfor;
   
    % capture the frame and save it
    fname = fullfile('E:\\Digipen\\PHY250\\2021\\Final_project\\submissions\\Alex Nijmeijer Demirci_396410_assignsubmission_file_\\Fluids\\frames', sprintf("img%03i.png", timestep));
    imwrite (getframe(gcf).cdata, fname);
 
  endfor

endfunction
