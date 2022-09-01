%Alex Demirci
%Simulates the motion of a SHO and damped
% motion with b = 0.1, b = 1.1 and b = b critical

function a
  
  out_dir = "A";
  mkdir(out_dir);
  
  prec  = 300;
  
  mass = 1;
  k = 1;
  x0 = 1;
  v0 = 0;
  A = 1;
  
  % array of x positions for simple oscillation
  xSimple = linspace(0, 0, prec);
  xSimple(1) = 1;
  wSimple = sqrt(k / mass); % simple frequency
  
  % DAMPING
  b = 0.1;
  b2 = 1.1;
  bCri = sqrt(4 * mass * k); 
 
 %b = 0.1
  xDamped = linspace(0, 0, prec);
  xDamped(1) = 1;
  wDamped = sqrt((k / mass) - (b^2 / (4 * mass^2)));
  gammaDamped = b / (2 * mass);
  
  %b2 = 1.1
  xDamped2 = linspace(0, 0, prec);
  xDamped2(1) = 1;
  wDamped2 = sqrt((k / mass) - (b2^2 / (4 * mass^2)));
  gammaDamped2 = b2 / (2 * mass);
 
 
 
  %bCri = critical
  xDampedCri = linspace(0, 0, prec);
  xDampedCri(1) = 1;
  wDampedCri = 0;
  gammaDampedCri = bCri / (2 * mass);

  % time with timestep
  timeArray = linspace(0, 50, prec);
 
  % compute the x value at a given time for the oscillations
  for i = 2:prec
    
   xSimple(i) = cos(wSimple * timeArray(i));
   
   xDamped(i) = A*e^(-gammaDamped * timeArray(i))*cos(wDamped * timeArray(i)); #INSTRUCTOR: you forgot to change the gamma (-5p)
   xDamped2(i) = A*e^(-gammaDamped * timeArray(i))*cos(wDamped2 * timeArray(i));
   xDampedCri(i) = A*e^(-gammaDamped * timeArray(i))* cos(wDampedCri * timeArray(i));
  endfor
  
  
   
  % drawing
 for i = 1 : prec
  
  % FIRST PLOT
  subplot(2, 1, 1);
  
  % simulate motion of a particle through the wave
  axis([0, 50, -1.5, 1.5]);
  plot(timeArray(i), xSimple(i), '*b');
  hold on;
  axis([0, 50, -1.5, 1.5]);
  plot(timeArray(i), xDamped(i), '*r');
  hold on;
  axis([0, 50, -1.5, 1.5]);
  plot(timeArray(i), xDamped2(i), '*g');
  hold on;
  axis([0, 50, -1.5, 1.5]);
  plot(timeArray(i), xDampedCri(i), '*m');
  
  axis([0, 50, -1.5, 1.5]);
  % draw the oscillation paths
   plot(timeArray, xSimple ,'b--');
   hold on;
   plot(timeArray, xDamped, 'r');
    hold on;
   plot(timeArray, xDamped2, 'g');
    hold on;
   plot(timeArray, xDampedCri, 'm');
   xlabel("Time");
   ylabel("Position");
   axis([0, 50, -1.5, 1.5]);
   
   hold off;
  
  % SECOND PLOT
  subplot(2, 1, 2);
  axis([-3, 3, 0.6, 2]);

  % draw the oscillation of a particle
  plot(xSimple(i), 1, 'ob');
  hold on;
  plot(xDamped(i), 1.2, 'or');
  hold on;
  plot(xDamped2(i), 1.4, 'og');
  hold on;
  plot(xDampedCri(i), 1.6, 'om');
  axis([-3, 3, 0.6, 2]);
   xlabel("X");
   ylabel("Y");
  hold off;
  
  % take picture for each frame
  fname = fullfile (out_dir, sprintf("img%03i.png", i));
  imwrite (getframe (gcf).cdata, fname);
  
  endfor
  
  
 
endfunction
