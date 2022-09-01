function spring
  out_dir = "second_exercise_images";
  mkdir(out_dir);
  
  %Initial variables
  initial_mass = 1;
  initial_k = 1;
  initial_x = 1;
  amplitude = initial_x;
  initial_v = 0;
  phase_difference = acos(1);
  
  %Variables for the dumping
  b_1 = 0.1;
  b_2 = 1.1;
  b_crit = 2 * initial_mass * sqrt(initial_k);
  
  
  %Array for the time
  t = linspace(0,10,100);
  
  %First omega
  angular_vel = sqrt(initial_k/initial_mass);
  
  %Second omega and ganma
  angular_vel_damp_1 = sqrt( (initial_k/initial_mass) - ((b_1*b_1)/(4*initial_mass * initial_mass)));
  ganma_1 = b_1/(2*initial_mass);
  
  %Third omega and ganma
  angular_vel_damp_2 = sqrt( (initial_k/initial_mass) - ((b_2*b_2)/(4*initial_mass * initial_mass)));
  ganma_2 = b_2/(2*initial_mass);
  
  %Critical ganman and omega
  angular_vel_damp_crit = sqrt( (initial_k/initial_mass) - ((b_crit*b_crit)/(4*initial_mass * initial_mass)));
  ganma_crit = b_crit/(2*initial_mass);
  
  %Arrays for plotting graphs
  first_positions =linspace(0,0,100);
  second_positions = linspace(0,0,100);
  third_positions = linspace(0,0,100);
  fourth_positions = linspace(0,0,100);
  
  %Precompute the graphs
  for i=1:100
    current_x = amplitude * cos(angular_vel * t(i) + phase_difference);
    first_positions(i) = current_x;
    
    current_x = amplitude * e^(-ganma_1 * t(i) ) *cos(angular_vel_damp_1 * t(i) + phase_difference);
    second_positions(i) = current_x;
    
    current_x = amplitude * e^(-ganma_2 * t(i) ) *cos(angular_vel_damp_2 * t(i) + phase_difference);
    third_positions(i) = current_x;
    
    current_x = amplitude * e^(-ganma_crit * t(i) ) *cos(angular_vel_damp_crit * t(i) + phase_difference);
    fourth_positions(i) = current_x;
  endfor
  
  
  for i=1:100
    %First plot
    subplot(2,1,1);
    
    %First spring
    first_x = amplitude * cos(angular_vel * t(i) + phase_difference);
    
    plot(first_x,0.75,'ro');
    axis([-2,2,-2,2]);
    hold on
    
    line([-1,first_x],[0.75 , 0.75],"linestyle","-","color","r");
    axis([-2,2,-2,2]);
    hold on;
    
    %First dump
    second_x = amplitude * e^(-ganma_1 * t(i) ) *cos(angular_vel_damp_1 * t(i) + phase_difference);
    
    plot(second_x,0.25,'bo');
    axis([-2,2,-2,2]);
    hold on
    
    line([-1,second_x],[0.25 ,0.25],"linestyle","-","color","b");
    axis([-2,2,-2,2]);
    hold on;
    
    %Second dump
    third_x = amplitude * e^(-ganma_2 * t(i) ) *cos(angular_vel_damp_2 * t(i) + phase_difference);
    
    plot(third_x,-0.25,'go');
    axis([-2,2,-2,2]);
    hold on;
    
    line([-1,third_x],[-0.25 , -0.25],"linestyle","-","color","g");
    axis([-2,2,-2,2]);
    hold on;
    
    
    %Critical dump
    fourth_x = amplitude * e^(-ganma_crit * t(i) ) *cos(angular_vel_damp_crit * t(i) + phase_difference);
    
    plot(fourth_x,-0.75,'mo');
    axis([-2,2,-2,2]);
    hold on;
    
    line([-1,fourth_x],[-0.75 , -0.75],"linestyle","-","color","m");
    axis([-2,2,-2,2]);
    hold on;
    
    
    %Second plot, x over time
    subplot(2,1,2);
    plot(t,first_positions,'r');
    hold on;
    
    plot(t,second_positions,'g');
    hold on;
    
    plot(t,third_positions,'b');
    hold on;
    
    plot(t,fourth_positions,'m');
    hold on;
    
    plot(t(i),first_x,'ro');
    hold on;
    
    plot(t(i),second_x,'go');
    hold on;
    
    plot(t(i),third_x,'bo');
    hold on;
    
    plot(t(i),fourth_x,'mo');
    hold on;
    
    fname = fullfile(out_dir,sprintf("img%03i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    
    subplot(2,1,1);
    hold off;
    
    subplot(2,1,2);
    hold off;
  endfor

endfunction
