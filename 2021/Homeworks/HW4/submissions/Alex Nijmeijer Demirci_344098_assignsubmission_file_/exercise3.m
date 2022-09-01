%Alex Demirci
%Application that calucaltes the first 40 terms
% of the Fourier expansion for a square wave and
% makes an animation


function exercise3
  
  out_dir = "Exercise3";
  mkdir(out_dir);
  
  precision = 1000;
  
  % y coordinate
  fx = linspace(0, 0, precision);
  % x coordinates from -1 to 1
  x = linspace(-1, 1, precision);
  
  % to store the total sumation at a specific x position
  totalResults = linspace(0, 0, precision);

   % number of Fourier iterations
  iterations = 40;
  
  currentResult = 0;
  
  % iterations
  for n = 1 : iterations
    
    nCurr = 2 * n - 1;
    
    % for every iteration, compute the y coordinate at the x position
    for j = 1 : precision  
      
      % compute the current value
     currentResult = (2 / (nCurr * pi)) * (-1)^((nCurr - 1) / 2) * cos(nCurr * pi * x(j));
     
     % compute fx
      fx(j) = (1 / 2) + currentResult + totalResults(j);
      
      % add the current value to the sum (sumation)
      totalResults(j) += currentResult;  
    endfor
    

    % drawing the square wave
    drawSquareWave();
    axis([-1, 1, -0.2, 1.4]);
    % draw fx
    plot(x, fx, 'r');
    axis([-1, 1, -0.2, 1.4]);
    hold off;
    
    % take picture
    fname = fullfile (out_dir, sprintf("img%03i.png", n));
    imwrite (getframe (gcf).cdata, fname);
   
  endfor
  
 endfunction
 
 function drawSquareWave
   
   % draws the square wave by intervals
   
  plot([-1, -0.5], [0, 0], 'b');
  axis([-1, 1, -0.2, 1.4]);
  hold on;
  plot([-0.5, -0.5], [0, 1], 'b');
  axis([-1, 1, -0.2, 1.4]);
  hold on;
  plot([-0.5, 0.5], [1, 1], 'b');
  axis([-1, 1, -0.2, 1.4]);
  hold on;
  plot([0.5, 0.5], [1, 0], 'b');
  axis([-1, 1, -0.2, 1.4]);
  hold on;
  plot([0.5, 1], [0, 0], 'b');
  axis([-1, 1, -0.2, 1.4]);
  hold on;
   
 endfunction
