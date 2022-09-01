% DigiPen Bilbao
%
% PHY250 Spring 2021
%
% Asier Azpiri Iriarte
% asier.azpiri@digipen.edu
% 11/29/2021
%
%===============================================================================
function TravellingWave
 
  %Initialize arrays for X and Y
  X = linspace(-4*pi,4*pi,200);
  Y = linspace(-4*pi,4*pi,200);
  %Initialize the grid
  [XX,YY] = meshgrid(X,Y);
  %Time lapse between frames
  dTime = 0.1;
  
  for i = 1:200
    %Compute direction of wave
    rDirection = sqrt(XX.*XX + YY.*YY);
    %Increase time
    Time = dTime * i;
    
    %Case 1: K(2,0)
    %Z = sin(2*XX - Time);
    
    %Case 2: Radial direction
    %Z = sin(2*rDirection - Time);
     
    %Case 3: K(2,2)
    Z = sin(2*XX + 2*YY - Time);
    
    %Set uo the figure
    S = surf(X,Y,Z);
    axis([-10,10,-10,10,-2,2]);   
    
    %Print the figure
    filename = sprintf('C:\\Users\\34650\\Desktop\\PHY250_HW5\\Exercise1\\%05d.jpg',i);
    print(filename);
  endfor
 
endfunction
