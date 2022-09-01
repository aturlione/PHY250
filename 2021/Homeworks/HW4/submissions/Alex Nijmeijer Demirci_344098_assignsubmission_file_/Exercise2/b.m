%Alex Demirci
%Simulates the motion, velocity and acceleration of a SHO and damped
% motion with b = 0.1, to b = b critical

function b
  
  out_dir = "B";
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
  wSimple = sqrt(k / mass);
  
  % DAMPING
  b = 0.1;
  b2 = 1.1;
  bCri = sqrt(4 * mass * k); 
 
 %b = 0.1
  xDamped = linspace(0, 0, prec);
  xDamped(1) = 1;
  wDamped = sqrt((k / mass) - (b^2 / (4 * mass^2)));
  gammaDamped = b / (2 * mass); % gamma
  
  % to store velocity
  vDamped = linspace(0, 0, prec);
  vDamped(1) = 0;
  vSimple = linspace(0, 0, prec);
  vSimple(1) = 0;
  
  % to store acceleration
  aSimple = linspace(0, 0, prec);
  aSimple(1) = 0;
  aDamped = linspace(0, 0, prec);
  aDamped(1) = 0;
 
  timeArray = linspace(0, 50, prec);
 
  % lerp from b = 0.1 to critical b
  bArray = linspace(b, bCri, prec);
 
  % for the lerp from b = 0.1 to b = critical
  for currentB = 1 : prec
    
    % compute for each B the x position respect to time
    for i = 2:prec
    
      xSimple(i) = cos(wSimple * timeArray(i));
      % frequency changes with B
      newW = sqrt((k / mass) - (bArray(currentB)^2 / (4 * mass^2)));
      
      % to store computation
      eVar = e^(-gammaDamped * timeArray(i));
      
      xDamped(i) = A*eVar*cos(newW * timeArray(i));
      
      % derivative of X
      vSimple(i) = -sin(wSimple * timeArray(i)) * wSimple;
      vDamped(i) = -eVar * gammaDamped * cos(newW * timeArray(i)) - eVar * newW * sin(newW * timeArray(i));
      
      % derivative of V
      aSimple(i) = -wSimple^2 * cos(wSimple * timeArray(i));
      aDamped(i) = eVar * gammaDamped^2 * cos(newW * timeArray(i)) + 2*eVar * gammaDamped * newW * sin(newW * timeArray(i)) - eVar * newW^2 * cos(newW * timeArray(i));
      
    endfor
    
    % FIRST PLOT. POSITION
   subplot(3, 1, 1);
   axis([0, 50, -1.5, 1.5]);
   plot(timeArray, xSimple, 'b'); % plot simple oscillation path
   hold on;
   axis([0, 50, -1.5, 1.5]);
   plot(timeArray, xDamped, 'r'); % plot damped path
   axis([0, 50, -1.5, 1.5]);
    ylabel("X");
   hold off;
    % SECOND PLOT, VELOCITY
   subplot(3, 1, 2);
   axis([0, 50, -1.5, 1.5]);
   plot(timeArray, vSimple, 'b');
   hold on;
   axis([0, 50, -1.5, 1.5]);
   plot(timeArray, vDamped, 'r');
   axis([0, 50, -1.5, 1.5]);
   ylabel("V");
   hold off;
   
   % THIRD PLOT, ACCELERATION
    subplot(3, 1, 3);
   axis([0, 50, -1.5, 1.5]);
   plot(timeArray, aSimple, 'b');
   hold on;
   axis([0, 50, -1.5, 1.5]);
   plot(timeArray, aDamped, 'r');
   axis([0, 50, -1.5, 1.5]);
    ylabel("A");
   hold off;
    
    % take picture
  fname = fullfile (out_dir, sprintf("img%03i.png", currentB));
  imwrite (getframe (gcf).cdata, fname);
    
  endfor
  
  
  
  
   
   

 
  
  
endfunction