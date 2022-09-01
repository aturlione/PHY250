%Alex Demirci
%Application that simulates two simple pendulums using
%the explicit and semi implicit methods


function exercise1
  
  out_dir = "Exercise1";
  mkdir(out_dir);
  

  w = linspace(0, 0, 300);  % explicit frequency
  wSemi = linspace(0, 0, 300); % semi implicit frequency
  angles = linspace(0, 0, 300); % angles for explicit method
  anglesSemi = linspace(0, 0, 300); % angles for semi implicit method
  
  % arrays for x, y positions for explicit method
  x = linspace(0, 0, 300);
  y = linspace(0, 0, 300);
  
  % same for semi implicit method
  xSemi = linspace(0, 0, 300);
  ySemi = linspace(0, 0, 300);
  
  % initial conditions
  w(1) = 0;
  wSemi(1) = 0;
  angles(1) = 1; % 1 radian 
  anglesSemi(1) = 1;
 
  timestep  = 0.05;
  
  
  g = -9.81; % gravitty
  l = 2; % length
  
  
  for i = 2 : 300
    
    sinAngle = sin(angles(i - 1));
    sinAngleSemi = sin(anglesSemi(i - 1));   
    
    % coompute the frequencies using the previious ones
    w(i) = w(i - 1) + timestep * ((-g / l) * sinAngle);
    wSemi(i) = wSemi(i - 1) + timestep * ((-g / l) * sinAngleSemi);
    
    % compute the corresponding angle
    angles(i) = angles(i - 1) + timestep * w(i - 1); 
    anglesSemi(i) = anglesSemi(i - 1) + timestep * wSemi(i);
    
   endfor
  
  % drawing the rods
  for j = 1 : 300
    
    % compute explicit method positions
    x(j) = l * sin(angles(j));
    y(j) = l * cos(angles(j));
    
     % compute semi implicit method positions
    xSemi(j) = l * sin(anglesSemi(j));
    ySemi(j) = l * cos(anglesSemi(j));
    
    hold off;
    axis('ij');
    plot([0, x(j)], [0, y(j)]); % draw line for explicit
    axis([-3, 3, -3, 3]);
    hold on;
    plot(x(j), y(j));  % draw the point
    axis([-3, 3, -3, 3]);
    hold on;
    plot([0, xSemi(j)], [0, ySemi(j)]); % draw the line for semi implicit
    axis([-3, 3, -3, 3]);
    hold on;
    plot(xSemi(j), ySemi(j)); % draw the point
    axis([-3, 3, -3, 3]);
    hold on;
    
    
    % take picture
    fname = fullfile (out_dir, sprintf("img%03i.png", j));
    imwrite (getframe (gcf).cdata, fname);
    
    endfor
endfunction
