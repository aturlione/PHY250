function spring_2
  out_dir = "second_exercise_images_2";
  mkdir(out_dir);
  
  %Initial variables
  initial_mass = 1;
  initial_k = 1;
  initial_x = 1;
  amplitude = initial_x;
  b = 0.1;
  F0= 1;
  angular_vel = sqrt(initial_k/initial_mass);
  omega_delta = 0.01;
  initial_omega =0.01;
  g = b/(2*initial_mass);
  
  %Arrays for plotting
  t = linspace(0,50,300);
  first_positions = linspace(0,0,300);
  first_A0 = linspace(0,0,300);
  first_W = linspace(0,0,300);
  
  
  
  %Precompute the third graph (Omega over amplitude)
  for i=1:300
    A0 = (F0)/(initial_mass * sqrt( (initial_omega^2 - angular_vel^2)^2 + b^2 * (initial_omega^2/initial_mass^2)));
    first_W(i) = initial_omega;
    first_A0(i) = A0;
    
    initial_omega +=omega_delta;
  endfor
  
  %Reset omega
  initial_omega = 0.01;
  
  for i=1:300
    
    %Compute the amplitude and the phase difference
    A0 = (F0)/(initial_mass * sqrt( (initial_omega^2 - angular_vel^2)^2 + b^2 * (initial_omega^2/initial_mass^2)));
    Phase0 = atan((angular_vel^2 - initial_omega^2)/(initial_omega * (b/initial_mass)));
    
    %Compute the respective x
    current_x = A0 * sin(initial_omega * t(i) + Phase0);
    
    %First plot, movement of x
    subplot(3,1,1);
    plot(current_x,0.75,'ro');
    axis([-15,15,0.6,2]);
    hold on;
    
    
    %Plot of the sin animation respect to the time
    subplot(3,1,2);
    
    for j = 1:300
      new_x = A0 * sin(initial_omega * t(j) + Phase0);
      first_positions(j) = new_x;
    endfor
    
    plot(t,first_positions,'r');
    axis([0,50,-15,15]);
    hold on;
    
    plot(t(i),current_x,'ro');
    axis([0,50,-15,15]);
    hold on;
    
    %Third plot, omega over amplitude
    subplot(3,1,3);
    
    plot(first_W,first_A0,'r');
    axis([0,2,0,15]);
    hold on;
    
    plot(initial_omega,A0,'ro');
    axis([0,2,0,15]);
    hold on;
    
    fname = fullfile(out_dir,sprintf("img%03i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    
    subplot(3,1,1);
    hold off;
    
    subplot(3,1,2);
    hold off;
    
    subplot(3,1,3);
    hold off;
    
    %Update the omega
    initial_omega +=omega_delta;
  
  
  endfor
  
  
endfunction
