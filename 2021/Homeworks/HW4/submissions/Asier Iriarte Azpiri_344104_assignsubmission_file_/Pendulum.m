% DigiPen Bilbao
%
% PHY250 Spring 2021
%
% Asier Azpiri Iriarte
% asier.azpiri@digipen.edu
% 11/23/2021
%
%===============================================================================
function Pendulum
 
  %Set the variables for pendulum
  Length = 2.0;
  Gravity = 9.8;
  dTime = 0.05;
  
  %Initialize array for angular velocity (Excplicit formula)
  W0 = linspace(0,0,300);
  %Initialize array for angular velocity (Semi-implicit formula)
  W1 = linspace(0,0,300);

  %Initialize arrays for pendulum angles (Excplicit formula)
  Angle0 = linspace(0,0,300);
  %Set initial angle
  Angle0(1) = 45.0 * (pi / 180.0);
  %Initialize array for angular velocity (Semi-implicit formula)
  Angle1 = linspace(0,0,300);
  %Set initial angle
  Angle1(1) = 45.0 * (pi / 180.0);

  %Initialize time array and its first value
  Time = linspace(0,0,300);
  Time(1) = dTime;

  %Set first position of pendulum (Excplicit formula)
  X0 = Length * cos(Angle0(1));
  Y0 = Length * sin(Angle0(1));
  
  %Set first position of pendulum (Semi-implicit formula)
  X1 = Length * cos(Angle0(1));
  Y1 = Length * sin(Angle0(1));

  %Fill the arrays using Explicit formula
  for i = 2:300
    W0(i) = W0(i - 1) + dTime * (-Gravity/Length * sin(Angle0(i - 1)));
    Angle0(i) = Angle0(i - 1) + dTime * W0(i - 1);
    Time(i) = dTime * i;
  endfor
  
  %Plot the Explicit relation between angle and time
  subplot(3,1,3);
  plot(Time,Angle0);
  axis([0,15,-5,5]);
  hold on
  
  %Fill the arrays using Semi-implicit formula
  for j = 2:300
    W0(j) = W0(j - 1) + dTime * (-Gravity/Length * sin(Angle0(j - 1)));
    Angle0(j) = Angle0(j- 1) + dTime * W0(j);
  endfor
  
  %Plot the Semi-implicit relation between angle and time
  subplot(3,1,3);
  plot(Time,Angle0);
  
  %Plot the position for both pendulums
  for k = 2:300
    %Case Explicit formula
    W0(k) = W0(k - 1) + dTime * (-Gravity/Length * sin(Angle0(k - 1)));
    Angle0(k) = Angle0(k - 1) + dTime * W0(k - 1);
    X0 = Length * cos(Angle0(k));
    Y0 = Length * sin(Angle0(k));
    
    %Open a subplot for Explicit formula
    h1 = subplot(3,1,1);
    axis([-3, 3, -4, 4]);
    xlabel("Explicit formula");
    hold on
    plot(-Y0,-X0,'*');

    %Case Semi-implicit formula
    W1(k) = W1(k - 1) + dTime * (-Gravity/Length * sin(Angle1(k - 1)));
    Angle1(k) = Angle1(k - 1) + dTime * W1(k);
    X1 = Length * cos(Angle1(k));
    Y1 = Length * sin(Angle1(k));
    
    %Open a subplot for Semi-implicit formula
    h2 = subplot(3,1,2);
    axis([-3, 3, -4, 4]);
    xlabel("Semi-implicit formula");
    hold on
    plot(-Y1,-X1,'*');
    
    %Save and print the frame
    filename = sprintf('C:\\Users\\asier.azpiri\\Desktop\\PHY250_HW4\\Exercise\\%05d.jpg',k);
    print(filename);
    
    %Delete the frame and make the next one
    delete(h1);
    delete(h2);
    
  endfor

endfunction