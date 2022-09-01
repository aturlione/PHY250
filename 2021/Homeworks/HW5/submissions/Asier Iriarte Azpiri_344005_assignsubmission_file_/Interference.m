% DigiPen Bilbao
%
% PHY250 Spring 2021
%
% Asier Azpiri Iriarte
% asier.azpiri@digipen.edu
% 11/29/2021
%
%===============================================================================
function Interference
  
  %Initialize values of array
  X = linspace(-4*pi,4*pi,200);
  Y = linspace(-4*pi,4*pi,200);
  
  %If you modify the distance of the sources, the interferences will happen
  %Further or nearer the wave sources, as the waves need to travel more to find others
  %Decrease Y and compute first radial direction
  Y -= 5.0;
  [XX,YY] = meshgrid(X,Y);
  rDirection1 = sqrt(XX.*XX + YY.*YY);
   
  %Increase Y to its contrapoint and compute second direction
  Y += 10.0;
  [XX,YY] = meshgrid(X,Y);
  rDirection2 = sqrt(XX.*XX + YY.*YY);
  
  %Return to first value
  Y -= 5.0;
  %Time lapse between frames
  dTime = 0.1;
  
  for i = 1:200  
    %Increase time
    Time = dTime * i;

    %Best case to appreciate Interferences is in second case
    %Where the wave expands to all directions, so it will encounter 
    %With the wawves of the other source    
    
    %If you change the angular frequency, the interferences will happen quicker
    %As the waves are moving faster and taking less time to collide ---INSTRUCTOR: THE PLACES CORRESPONDING TO CONSTRUCTIVE/DESCRUCTIVE INT CHANGE, AND IF THE FREQUENCIES ARE NOT HARMONICS (ONE OF THEM IS AN INTEGER NUMBER MULTIPLIED BY THE OTHER) WE WILL NOT HAVE COMPLETE CONSTRUCTIVE/DESTRUCTIVE INT.
    Z = sin(2*rDirection1 - Time) + sin(2*rDirection2 - Time);
    S = surf(X,Y,Z);
    axis([-10,10,-12,12,-2,2]);  
    view(0,90); 
    
    filename = sprintf('C:\\Users\\34650\\Desktop\\PHY250_HW5\\Exercise1\\%05d.jpg',i);
    print(filename);
    
  endfor
  
endfunction
