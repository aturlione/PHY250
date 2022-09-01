% DigiPen Bilbao
%
% phy250 Fall 2021
%
% Jaime Betolaza Sánchez
% jaime.s@digipen.edu
% 10/10/2021
%
%===============================================================================
function fluid_demo
  
  %Create a figure and the output directory for the frames
  figure(1);
  out_dir = "temp_img";
  mkdir (out_dir);
  
  %Compute the bounding functions
  x = linspace(-10, 10, 20);
  y1 = -tanh(0.6*x) + tanh(0.6*x - 4) + 4;
  y2 = -y1;
  
  %Compute the initial positions of the particles
  particle_columns = 40;
  points = meshgrid(linspace(-particle_columns/2, 0, particle_columns), linspace(-4, 4, 7));
  
  %Iterator
  i = 1;
  while(i < 101)
    %Compute the tube bounds
    max_y = -tanh(0.6*points(1, :)) + tanh(0.6*points(1, :) - 4) + 4;
    min_y = -max_y; 
    
    %Compute the velocity corresponding to each column of particles
    y = transpose(linspace(min_y + 0.5, max_y - 0.5, 7));
    v = arrayfun(@(v) (0.001)/((v * 0.01)*(v * 0.01) * 3.14159), max_y);
    
    %Erase the previous particles
    hold off;
    
    %Plot the tube
    plot(x, y1);
    axis([-10, 10, -10, 10]);
    hold on;
    plot(x, y2);
    axis([-10, 10, -10, 10]);
    hold on;
    
    %Plot the particles
    plot(points, y, 'ok');
    axis([-10, 10, -10, 10]);
    hold on;
    
    %Save the frammes
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
    
    %Update the x position of the particles
    for j = 1:particle_columns
      points(:, j) = points(:, j) + v(j);
    endfor
    i++;
  endwhile

endfunction