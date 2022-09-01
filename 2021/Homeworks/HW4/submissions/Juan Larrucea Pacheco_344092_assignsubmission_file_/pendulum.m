function pendulum
  out_dir =  "first_exercise_images";
  mkdir(out_dir);
  
  %Initial variables
  length = 2;
  initial_angle= deg2rad(50);
  gravity = 9.8;
  initial_w = 0;
  delta_t = 0.05;
  
  %Variables for the semi implicit method
  w_0_semi = initial_w;
  w_1_semi = w_0_semi;
  angle_0_semi = initial_angle;
  angle_1_semi = angle_0_semi;
  
  %Variables for the explicit method
  w_0_exp = initial_w;
  w_1_exp  = w_0_exp;
  angle_0_exp = initial_angle;
  angle_1_exp  = angle_0_exp;
  
  %Arrays for the graphics
  angles_exp = linspace(0,0,300);
  angles_semi = linspace(0,0,300);
  t = linspace(0,6,300);
  
  for i=1:300
    
    %Set the angles
    angles_exp(i) = angle_1_exp;
    angles_semi(i) = angle_1_semi;
    
    %Compute x and y semi implicit
    current_y = -1 * cos(angle_0_semi) * length;
    current_x = sin(angle_0_semi) * length;
    
    %Plot the semi implicit method
    plot(current_x,current_y,'ro');
    axis([-2,2,-2,2]);
    hold on
    
    line([0,current_x],[0 , current_y],"linestyle","-","color","r");
    axis([-2,2,-2,2]);
    hold on;
    
    
    %Update variables (semi implicit)
    w_1_semi = w_0_semi + delta_t * ( (-gravity/length) * sin(angle_0_semi));
    angle_1_semi = angle_0_semi + delta_t * w_1_semi;
    w_0_semi = w_1_semi;
    angle_0_semi = angle_1_semi;
    
    %Compute x and y explicitly
    current_y = -1 * cos(angle_0_exp) * length;
    current_x = sin(angle_0_exp) * length;
    
    %Plot the explicity method
    plot(current_x,current_y,'bo');
    axis([-2,2,-2,2]);
    hold on
    
    line([0,current_x],[0 , current_y],"linestyle","-","color","b");
    axis([-2,2,-2,2]);
    hold on;
    
    
    %Update variables (explicity)
    w_1_exp = w_0_exp+ delta_t * ( (-gravity/length) * sin(angle_0_exp));
    angle_1_exp = angle_0_exp + delta_t * w_0_exp;
    w_0_exp = w_1_exp;
    angle_0_exp = angle_1_exp;
    
    fname = fullfile(out_dir,sprintf("img%03i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    hold off;
  endfor

  %Plot angles over time
  plot(t,angles_exp,'bo');
  hold on;
  
  plot(t,angles_semi,'ro');
  
  
endfunction
