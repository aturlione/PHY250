%Alex Demirci
%Excercise3 for Homework5
% 29/11/2021

function  excercise3
  
  % QUESTIONS
  
  % 1. The right one is case 2, as we want to simulate the interference
  %     pattern produced by two sources in water, we can obviosuly see
  %     that the obtained pattern resembles what we see in real life.
  %     The interference produces standing waves. INSTRUCTOR: the standing waves are produced only when the medium is limitated.
  
  % 2. If the distnace d is increased, the constructive and destructive interference
  %    points change INSTRUCTOR: how? -2p
  
  
  %  3. If the frequency of one of the waves is changed, this wave travels
  %  faster or slower (depending if the frequency was increased or decreased), hence
  %  reaching the other wave at a different point and thus having constructive and 
  % destructive interference points in other regions
  
  
  out_dir = "Excercise3";
  mkdir(out_dir);
  
  
  precision = 100;
  
  % amplitude
  A = 1;
  % distance
  d = 5;
  
  % frequency for wave 1
  w1 = 1;
  % frequency for wave 2
  w2 = 1;
  
  % arrays for x and y positions
  x = linspace(-4 * pi, 4 * pi, precision);
  y = linspace(-4 * pi, 4 * pi, precision);
  
  % mesh
  [xx, yy] = meshgrid(x, y);
  
  time = 0;
  timeSamples = 200;
  timeStep = 0.1;
  
  
  for i = 1 : timeSamples
    
    % uncomment the line below to see the plot from above
    %view(0, 90);
    length = sqrt(xx.*xx + yy.*yy);
    z = A * sin(2 * length - w1 * time);
    % displaced d units to one side
    surf(x + d, y, z);
    axis([-4 * pi 4 * pi  -4 * pi  4 * pi -8 4]);
   
     
    hold on;
    
    % uncomment the line below to see the plot from above
    %view(0, 90);
    
   
    z2 = A * sin(2 * length - w2 * time);
     % displaced d units to the other side
    surf(x - d, y, z2);
    axis([-4 * pi 4 * pi  -4 * pi  4 * pi -8 4]);
    hold off;
    
    time += timeStep;
    
    fname = fullfile (out_dir, sprintf("img%03i.png", i));
    imwrite (getframe (gcf).cdata, fname);
    
  endfor
 endfunction