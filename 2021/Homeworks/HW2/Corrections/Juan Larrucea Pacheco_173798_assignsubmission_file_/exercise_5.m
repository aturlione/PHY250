function exercise_5
  out_dir = "temp_img";
  mkdir(out_dir);
  
  %Data
  A = 0.6;
  B = 4;
  v_0 = 0.5; 
  elements_in_x = 100;
  
  %Boundary function data
  x = linspace(-10,10,elements_in_x);
  y = -tanh(A *x) + tanh(A * x - B) + B;
  minus_y = -y;
  
  
  y_for_grid = linspace(-10,10,elements_in_x);
  %Grids
  [x_grid, y_grid] = meshgrid (x, y_for_grid);
  
  %Matrices for velocity
  v_x = zeros(elements_in_x);
  v_y = zeros(elements_in_x);
  
  %Compute the original flow (rate)
  original_radius = y(1);
  original_flow = v_0* pi * original_radius * original_radius;
  
  %Compute the velocities in x
  for i=1:elements_in_x
    new_radius = y(i);
    new_area = pi * new_radius * new_radius;
    new_vel = original_flow/new_area;
    
    for j=1:elements_in_x
      v_x(j,i) = new_vel;
    endfor
  
  endfor
  
  %Particle creation
  number_of_particles = 70;
  rows = number_of_particles/10;
  columns = number_of_particles/rows;
  
  x_separation = 0.8;
  
  x_particles = zeros(rows,columns);
  y_particles = zeros(rows,columns);
  x_current_pos = -10;
  
  %Compute initial position of particles
  for i=1:columns
    current_radius = -tanh(A *x_current_pos) + tanh(A * x_current_pos - B) + B;
    current_radius -= 0.4;
    y_separation = (current_radius * 2)/(rows-1);
    y_current_pos = current_radius;
    
    for j=1:rows
      x_particles(j,i) = x_current_pos;
      y_particles(j,i) = y_current_pos;
      y_current_pos -=  y_separation;
    endfor
  
  x_current_pos += x_separation;
  endfor

  %Time
  time_step = 1/6.8;
  total_time = 200;
  
  %Interpolate the velocities and positions
  for i = 1: total_time;
    new_velocity = interp2(x_grid,y_grid,v_x,x_particles,y_particles);
    
    for j=1:columns
      x_current_pos = x_particles(1,j) + new_velocity(1,j) * time_step;
      current_radius = -tanh(A *x_current_pos) + tanh(A * x_current_pos - B) + B;
      current_radius -= 0.4;
      y_separation = (current_radius * 2)/(rows-1);
      y_current_pos = current_radius;
    
      for u=1:rows
        x_particles(u,j) = x_current_pos;
        y_particles(u,j) = y_current_pos;
        y_current_pos -=  y_separation;
      endfor
   
    endfor
  
    %Plot everything
    matrix_to_plot_x = x_particles;
    matrix_to_plot_y = y_particles;
    
    reshape(matrix_to_plot_x,1,[]); % convert matrix to row vector
    reshape(matrix_to_plot_y,1,[]); % convert matrix to row vector
    plot (matrix_to_plot_x,matrix_to_plot_y,'ro');
    axis([-10,10,-10,10]);
    hold on;
    
    plot (x,y);
    axis([-10,10,-10,10]);
    hold on;
    
    plot (x,minus_y);
    axis([-10,10,-10,10]);
    hold on;
    
    fname = fullfile(out_dir,sprintf("img%03i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    hold off;
    
    
    if(x_particles(1,1)>=10)
    break;
    endif
  
  endfor

endfunction