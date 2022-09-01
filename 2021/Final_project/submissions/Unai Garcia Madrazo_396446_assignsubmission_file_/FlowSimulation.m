#################################################################
# TOTAL GRADE EXERCISE 1: 40/50p
#################################################################

# The answers to questions need more development and most of them are wrong ---> 5/15

#The simulatio is implemented correctly: --->35/35

#################################################################



function FlowSimulation
  figure(1);

  %Name for the folder to create the images at
  out_dir = "result_images_flow";
  %Makes the directory
  mkdir(out_dir);
  
  %Initial values
  a = 0.4;
  v0 = 10;
  coord_limit = 1.5;
  spatial_steps = 15;
  scale_factor = 0.02;
  timestep = 0.4;
  max_iterations = 50;
  number_of_particles = 20; 
    
  %Calculates the spatial grid 
  xx = linspace(-coord_limit,coord_limit,spatial_steps);
  yy = linspace(-coord_limit,coord_limit,spatial_steps);
  [x,y] = meshgrid(xx,yy);
  
  %Calculates the gradient of the velocity
  fn_dx = (a^3*v0*(2*x.^2 - y.^2))./(2*(x.^2 + y.^2).^(5/2)) - v0;
  fn_dy = (3*a^3*v0*x.*y)./(2*(y.^2+x.^2).^(5/2));
  
  %Removes the values of the velocity inside the circle
  for i=1:spatial_steps    
    for j=1:spatial_steps     
      if(x(i,j)^2 + y(i,j)^2 <= a^2)      
        fn_dx(i,j) = 0;
        fn_dy(i,j) = 0;    
      endif      
    endfor   
  endfor
  
  %Arrays for the x and y for the particle sets
  x01 = linspace(1.3,1.3,number_of_particles);
  y01 = linspace(1.4,-1.4,number_of_particles);

  x02 = linspace(1.4,1.4,number_of_particles);
  y02 = linspace(1.4,-1.4,number_of_particles);
  
  x03 = linspace(1.5,1.5,number_of_particles);
  y03 = linspace(1.4,-1.4,number_of_particles);
  for i=1:max_iterations
   
   hold off; 
    
   %Draws the velocity fieldd
   quiver(x,y,fn_dx,fn_dy,'k');
   axis([-coord_limit,coord_limit,-coord_limit,coord_limit]);
   view(90,90); 
   daspect([1,1]);
   hold on;
  
   %Draws the circle
   t = linspace(0,2*pi,100)'; 
   circx = a.*cos(t); 
   circy = a.*sin(t); 
   plot(circx,circy,'m');
   axis([-coord_limit,coord_limit,-coord_limit,coord_limit]);
   view(90,90);
   daspect([1,1]);
   hold on; 
  
  %Computes the position for the set 1 of particles
  for j=1:number_of_particles
      
      vxp = (interp2(x,y,fn_dx,x01(j),y01(j))*scale_factor);
      vyp = (interp2(x,y,fn_dy,x01(j),y01(j))*scale_factor);
      
      dist = sqrt((x01(j) + vxp*timestep)^2 + (y01(j) + vyp*timestep)^2);      
      
      if(dist > a)    
        xp = x01(j) + vxp*timestep;
        yp = y01(j) + vyp*timestep;
      else  
        xp = x01(j);
        yp = y01(j);
      endif
      
      x01(j) = xp;
      y01(j) = yp;
      
      plot(xp,yp,'o');
      axis([-coord_limit,coord_limit,-coord_limit,coord_limit]);
      view(90,90);
      daspect([1,1]);
      hold on; 
  endfor
  %Computes the position for the set 2 of particles
  for j=1:number_of_particles
      
      vxp = (interp2(x,y,fn_dx,x02(j),y02(j))*scale_factor);
      vyp = (interp2(x,y,fn_dy,x02(j),y02(j))*scale_factor);
      
      dist = sqrt((x02(j) + vxp*timestep)^2 + (y02(j) + vyp*timestep)^2);
      
      if(dist > a)    
        xp = x02(j) + vxp*timestep;
        yp = y02(j) + vyp*timestep;
      else  
        xp = x02(j);
        yp = y02(j);
      endif
      
      x02(j) = xp;
      y02(j) = yp;
      
      plot(xp,yp,'o');
      axis([-coord_limit,coord_limit,-coord_limit,coord_limit]);
      view(90,90);
      daspect([1,1]);
      hold on; 
  endfor
  %Computes the position for the set 3 of particles
  for j=1:number_of_particles
      
      vxp = (interp2(x,y,fn_dx,x03(j),y03(j))*scale_factor); 
      vyp = (interp2(x,y,fn_dy,x03(j),y03(j))*scale_factor);
      
      dist = sqrt((x03(j) + vxp*timestep)^2 + (y03(j) + vyp*timestep)^2);
      
      if(dist > a)    
        xp = x03(j) + vxp*timestep;
        yp = y03(j) + vyp*timestep;
      else  
        xp = x03(j);
        yp = y03(j);
      endif     
      
      x03(j) = xp;
      y03(j) = yp;
      
      plot(xp,yp,'o');
      axis([-coord_limit,coord_limit,-coord_limit,coord_limit]);
      view(90,90);
      daspect([1,1]);
      hold on; 
  endfor  
   %Writes into file images at the end   
   fname = fullfile(out_dir, sprintf("img%0.3i.jpg",i));
   imwrite(getframe(gcf).cdata,fname); 
  endfor
endfunction

% What does "incompressible, non-viscous, circulation-free liquid" mean?
% Means that the particles that represent the fluid can't overlap on each other
% which is not very preccise in my simulation---INSTRUCTOR: expand more...

% What  is  the  difference  between  this  fluid  and  the  one  we  
% considered  when  wesolved problems during the course?
% This fluid changes path when encountered when an object, which on our case we didn't consider that--#INSTRUCTOR: this is not the most important difference.

% Do you think that the volume rate flow is just "vA" in this case?  Why yes o whynot?
% Yes, as we are not considered any other external force #INSTRUCTOR: No, in this case the velocity is not constant along a perpendicular surface, so to caculate the fluid volume rate you have to solve an integral

% How would you improve this model?
% By making particles not go into the ball at all without overlapping on each other 