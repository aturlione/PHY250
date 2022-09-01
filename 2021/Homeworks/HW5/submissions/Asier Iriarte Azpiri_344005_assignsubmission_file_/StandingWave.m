% DigiPen Bilbao
%
% PHY250 Spring 2021
%
% Asier Azpiri Iriarte
% asier.azpiri@digipen.edu
% 11/29/2021
%
%===============================================================================
function StandingWave
  
  %Initialize arrays for X and Y
  X = linspace(-4*pi,4*pi,300);
  Y = linspace(-4*pi,4*pi,300);
  %Initialize the grid
  [XX,YY] = meshgrid(X,Y);
  %Time lapse between frames
  dTime = 0.05;
  %Set up the harmonics
  n = 2;
  m = 3;
  
  for i = 1:300
    %Increase time
    Time = dTime * i;
    %Z is computed by the following formula (explained in class)
    Z = sin(n*pi*XX).*sin(m*pi*YY).*cos(Time);
  
    %Set up the figure
    S = surf(X,Y,Z);
    axis([-1,1,-1,1,-2,2]);  
    view(45,45); 
    
    %Plot the figure
    filename = sprintf('C:\\Users\\34650\\Desktop\\PHY250_HW5\\Exercise1\\%05d.jpg',i);
    print(filename);
  endfor
  
endfunction
