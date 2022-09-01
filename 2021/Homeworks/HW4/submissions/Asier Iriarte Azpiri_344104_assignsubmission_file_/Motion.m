% DigiPen Bilbao
%
% PHY250 Spring 2021
%
% Asier Azpiri Iriarte
% asier.azpiri@digipen.edu
% 11/23/2021
%
% This program only obtains the result of the first two parts, the rest aren't done
%===============================================================================
function Motion

  %Set up initial values
  m = 1.0;
  k = 1.0;
  w = sqrt(k / m);
  dTime = 0.05;
  b0 = 0.1;
  b1 = 1.1;
  b2 = 4*m*k;
  
  %Initialize sigma values for dumped motion
  sigma0 = b0 / (2*m);
  sigma1 = b1 / (2*m);
  sigma2 = b2 / (2*m);
  
  %Initialize angular velocities for dumped motion
  W0 = sqrt((k/m) - ((b0 * b0) / (4*m*m)));
  W1 = sqrt((k/m) - ((b1 * b1) / (4*m*m)));
  W2 = sqrt((k/m) - ((b2 * b2) / (4*m*m)));
 
  %Initialize position arrays for each case
  %Case SHO
  X0 = linspace(0,0,300);
  %Case Dumped (b = 0.1)
  X1 = linspace(0,0,300);
  %Case Dumped (b = 1.1)
  X2 = linspace(0,0,300);
  %Case Dumped (b = 4km)
  X3 = linspace(0,0,300);
  
  %Initialize time array
  Time = linspace(0,0,300);
  
  %Fill the arrays with data
  for i = 1:300
    %Increase time
    Time(i) = dTime * i;
    %Case SHO
    X0(i) = cos(w * Time(i));
    %Case Dumped (b = 0.1)
    X1(i) = e^(-sigma0*Time(i)) * cos(W0*Time(i));
    %Case Dumped (b = 1.1)
    X2(i) = e^(-sigma1*Time(i)) * cos(W1*Time(i));
    %Case Dumped (b = 4km)
    X3(i) = e^(-sigma2*Time(i)) * cos(W2*Time(i));
  endfor
    
  for m = 1:300
    %Open a subplot for the mass positions and print them
    h1 = subplot(2,1,1);
    axis([-2, 2, 1, 2]);
    ylabel("X");
    hold on
    plot(X0(m),1.1,'*');
    hold on
    plot(X1(m),1.3,'*');
    hold on
    plot(X2(m),1.5,'*');
    hold on
    plot(X3(m),1.7,'*');
    hold on
    
    %Open a subplot for the relation between time and angle and print them
    h2 = subplot(2,1,2);
    axis([0, 10, -1, 1]);
    ylabel("X");
    xlabel("Time");
    hold on
    plot(Time,X0);
    hold on
    plot(Time,X1);
    hold on
    plot(Time,X2);
    hold on
    plot(Time,X3);
    hold on
    %Print the velocity the position is changing over time
    plot(Time(m),X0(m),'*');
    hold on
    plot(Time(m),X1(m),'*');
    hold on
    plot(Time(m),X2(m),'*');
    hold on
    plot(Time(m),X3(m),'*');
    hold on
    
    %Save and print the frame
    filename = sprintf('C:\\Users\\asier.azpiri\\Desktop\\PHY250_HW4\\Exercise\\%05d.jpg',m);
    print(filename);
    
    %Delete the frame and make the next one
    delete(h1);
    delete(h2);  
  endfor
  
endfunction


#INSTRUCTOR: FORCED OSCILLATIONS NOT SOLVED
# EXERSICE 3 NOT SOLVED