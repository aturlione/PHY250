#################################################################
# TOTAL GRADE EXERCISE 1: 35/50p
#################################################################

# The questions were not answered ---> 0/15

#The simulation is performed correctly: --->35/35



#################################################################


function fp_ex1
  %Create the figure and the folder
  figure(1);
  out_dir = "ex1_images";
  mkdir (out_dir);
  
  %Varibles
  vo = 10;
  a = 0.4;
  size = 19;
  timestep = 0.4;
  
  %Compute the position grid
  xx = linspace(-1.5, 1.5, size);
  zz = linspace(-1.5, 1.5, size);
  [x, z] = meshgrid(xx, zz);
  
  %Compute the velocity grid
  der_x = (a^3*vo*(2*x.*x - z.*z))./(2*(z.*z + x.*x).^(5/2)) - vo;
  der_z = (3*a^3*vo*x.*z)./(2*(z.*z + x.*x).^(5/2));
  
  %Get rid of unwanted values
  for i = 1:size
    for j = 1:size
      if(x(i, j)^2 + z(i, j)^2 <= a*a)
        der_x(i, j) = 0;
        der_z(i, j) = 0;
      endif
    endfor
  endfor
  
  %Create particles
  particles_x0 = linspace(1.5, 1.5, size);
  particles_z0 = linspace(1.4, -1.4, size);
  
  for i = 1:80
    hold off;
    %Plot the grid
    scale_factor = 0.01;
    quiver(x, z, der_x*scale_factor, der_z*scale_factor, 'AutoScale', 'off');
    view(90, 90);
    hold on;
      
    %Plot the sphere
    t = linspace(0,2*pi,100)'; 
    circsx = a*cos(t); 
    circsy = a*sin(t); 
    plot(circsx,circsy); 
    hold on;
    
    
    %Plot the particles
    for j = 1:19
      %Compute the velocity of every particle
      vx = interp2(x, z, der_x, particles_x0(j), particles_z0(j))*scale_factor;
      vz = interp2(x, z, der_z, particles_x0(j), particles_z0(j))*scale_factor;
      
      %Check if the particles are inside the sphere
      dist = sqrt((particles_x0(j) + vx * timestep)^2 + (particles_z0(j) + vz * timestep)^2);
      %If they are not, update their position
      if (dist > a)
        pos_x = particles_x0(j) + vx*timestep;
        pos_z = particles_z0(j) + vz*timestep;
        %If they are just leave them
      else
        pos_x = particles_x0(j);
        pos_z = particles_z0(j);
      endif
      %Update the particles in the array
      particles_x0(j) = pos_x;
      particles_z0(j) = pos_z;
      
      %Plot the particle
      plot(pos_x, pos_z, 'o');
      hold on;
    endfor
    
    %Set the axis and the ratio
    axis([-1.5 1.5 -1.5 1.5]);
    daspect([1 1]);
    
    %Save the frame
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
  endfor
endfunction








