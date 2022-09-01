#################################################################
# TOTAL GRADE EXERCISE 1: 35/50p
#################################################################

# The answer to the questions are not developed, and there are several wrong concepts ---> 5/15


# The condition to avoid penetration into the circle is wrong. --->30/35




#################################################################


%========================================================
% PHY250
% Digipen Bilbao
% Javier Guerra  - j.guerra@digipen.edu
%========================================================

function fluid
  
  out_dir = "temp_img";
  mkdir(out_dir);
  
  %the number of coordinates and velocities calculated: 
  %matrix is size precision x precision
  precision = 23;
  v0 = 10;
  %radius of the circle
  a = 0.4;
  
  %Create a mesh to then calculate the velocity in each position in the mesh
  x = linspace(-1.5, 1.5, precision);
  y = linspace(-1.5, 1.5, precision);
  vx = linspace(0, 0, precision);
  vy = linspace(0, 0, precision);
  [xx,yy] = meshgrid(x,y);
  
  %Calculate the velocities in each point using the formula in the handout
  vx = -v0 .*(((-2 .* a.^3 .* xx^2 + a.^3 * yy.^2)./(2 .* (xx.^2 + yy.^2).^(5/2))).+1);
  vy = (3*a^3 * v0 * xx .* yy)./(2.*(xx.^2 + yy.^2).^(5/2));
  
  %Set the velocities inside the circle to 0
  for i = 1:precision
    for j = 1:precision
      if(sqrt(xx(i,j)^2 + yy(i,j)^2)<a)
        vx(i, j) = 0;
        vy(i, j) = 0;
      endif
    endfor
  endfor
  
  %Initial condition of the particles
  x_particle = linspace(1.5, 1.5,precision);
  y_particle = linspace(-1.5, 1.5, precision);
  frames = 50;
  for i = 1: frames
    %scale 0.01 because velocities were to big for the size of this model
    scale = 0.01;
    %draw the arrows representing the velocity each place
    
    quiver(xx,yy,vx*scale,vy*scale, 'AutoScale', 'off');
    view(90,90);
  
    %calculate the coordinates of the points in the circle
    hold on;
    t = linspace(0,2*pi, 100);
    x_circle = a * sin(t); 
    y_circle = a * cos(t);
  
    % Draw the circle
    plot(x_circle, y_circle);
    axis([-1.5 1.5 -1.5 1.5], 'square');
    title("Fluid Simulation \n Non viscosity - Non rotational","fontsize", 15);
    xlabel('x','fontweight','bold',"fontsize", 15);
    ylabel('y','fontweight','bold',"fontsize", 15);
    
    %update particle position
    for index = 1 : precision
      %interpolate the velocity of the current particle
      velx = interp2(x,y,vx,x_particle(index), y_particle(index)) * scale;
      vely = interp2(x,y,vy,x_particle(index), y_particle(index)) * scale;
      %update the position
      x_particle(index) += velx;
      y_particle(index) += vely;
      
      #INSTRUCTOR: you didn't correct the position of the particles to avoid the penetration into the circle.
      
      %draw the particles
      hold on;
      plot(x_particle, y_particle, 'o');
      axis([-1.5 1.5 -1.5 1.5], 'square');
      title("Fluid Simulation \n Non viscosity - Non rotational","fontsize", 15);
      xlabel('x','fontweight','bold',"fontsize", 15);
      ylabel('y','fontweight','bold',"fontsize", 15);
      hold off;
    endfor
    %get the frame
    fname = fullfile(out_dir, sprintf("img%03i.png", i));
    imwrite (getframe(gcf).cdata, fname);
    
  endfor
  
endfunction
 %Questions:
 %1. Incompressible means that that the density of the fluid does not change.
 %   Non-Viscous means that the fluid does not have any resistance to flow. INSTRUCTOR: explicit more... 
 %
 %2. That the ones from the exercises were not circulation free. #INSTRUCTOR: this is wrong, we always considered that the fluid had no circulation
 %
 %3. Yes, because that formula works for incompressible fluids like this one. #INSTRUCTOR: the velocity is not constant along a perpendicular area, you should solve an integral, so the fluid volume rate is not just vA
 %
 %4. Adding viscosity, that would make it more realistic. Also, we could
 %   make the flow turbulent after the circle to make it even more realistic.



