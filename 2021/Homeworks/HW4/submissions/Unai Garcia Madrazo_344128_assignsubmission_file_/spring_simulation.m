function spring_simulation
  
  figure(1)
  title("Spring simulation");
  axis([-3,3,-3,3]);
  
  %Name for the folder to create the images at
  out_dir = "result_images_spring";
  %Makes the directory
  mkdir(out_dir);
  
  m = 1; %1kg mass
  k = 1;
  
  intial_x = 1;
  intia_vel = 0;
  
  %Values for the Simple Harmonic Oscillation
  SHO_Omega = sqrt(k/m);
  SHO_Theta = atan(intia_vel/(SHO_Omega*intial_x));
  SHO_Amplitude = intial_x/cos(SHO_Theta);
  SHO_Y = [];
  SHO_V = [];
  SHO_A = [];
  
  %Values for the damped oscillation
  Damped_Amplitude = SHO_Amplitude;
  
  Damped_Y_01 = [];
  Damped_Y_11 = [];
  Damped_Y_Crit = [];
  
  Damped_V_01 = [];
  Damped_V_11 = [];
  Damped_V_Crit = [];
  
  Damped_A_01 = [];
  Damped_A_11 = [];
  Damped_A_Crit = [];
  
  Crit_B = sqrt(4*m*k);
  
  Gamma_01 = 0.1/(2*m);
  Gamma_11 = 1.1/(2*m);
  Gamma_Crit = Crit_B/(2*m);
  
  Omega_01 = sqrt((k/m)-(pow2(0.1)/(4*pow2(m))));
  Omega_11 = sqrt((k/m)-(pow2(1.1)/(4*pow2(m))));
    
    
  Element_Number = 300;
  
  Array_Time = linspace(0,51,Element_Number);
  
  Y_Axis_Val = 3;
  
  for i=1:Element_Number
    
  %Calculates the values for the positions  
    SHO_Y(i) = SHO_Amplitude * cos(SHO_Omega*Array_Time(i) + SHO_Theta);  
    Damped_Y_01(i)   = Damped_Amplitude * power(e,-Gamma_01*Array_Time(i))*cos(Omega_01*Array_Time(i));  
    Damped_Y_11(i)   = Damped_Amplitude * power(e,-Gamma_11*Array_Time(i))*cos(Omega_11*Array_Time(i));  
    Damped_Y_Crit(i) = Damped_Amplitude * power(e,-Gamma_Crit*Array_Time(i));
  %Calculates the values for the velocities (derivative of the position formula)
    SHO_V(i) = -(SHO_Amplitude *SHO_Omega)  * sin(SHO_Omega*Array_Time(i) + SHO_Theta);    
    Damped_V_01(i)    = -Damped_Amplitude * power(e,-Gamma_01*Array_Time(i))*(Omega_01*sin(Omega_01*Array_Time(i)) + Gamma_01*cos(Omega_01*Array_Time(i)));  
    Damped_V_11(i)    = -Damped_Amplitude * power(e,-Gamma_11*Array_Time(i))*(Omega_11*sin(Omega_11*Array_Time(i)) + Gamma_11*cos(Omega_11*Array_Time(i)));  
    Damped_V_Crit(i)  = -Damped_Amplitude * Gamma_Crit * power(e,-Gamma_Crit*Array_Time(i));
  %Calculates the values for the accelerations  
    SHO_A(i) = -(SHO_Amplitude *pow2(SHO_Omega))  * cos(SHO_Omega*Array_Time(i) + SHO_Theta);
    Damped_A_01(i) = Damped_Amplitude * power(e,-Gamma_01*Array_Time(i)) * (2*Gamma_01*Omega_01*sin(Omega_01*Array_Time(i))+(pow2(Omega_01)-pow2(Gamma_01))*cos(Gamma_01*Array_Time(i)));
    Damped_A_11(i) = Damped_Amplitude * power(e,-Gamma_11*Array_Time(i)) * (2*Gamma_11*Omega_11*sin(Omega_11*Array_Time(i))+(pow2(Omega_11)-pow2(Gamma_11))*cos(Gamma_11*Array_Time(i)));
    Damped_A_Crit(i) = -Damped_Amplitude * pow2(Gamma_Crit) * power(e,-Gamma_Crit*Array_Time(i));

  endfor 
    
  for i=1:Element_Number
   
  %Plots the hole graph of the positions
  
    subplot(3,1,1);
    
    plot(Array_Time,SHO_Y,'c-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);  
    hold on;  

    plot(Array_Time,Damped_Y_01,'r-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on;
  
    plot(Array_Time,Damped_Y_11,'g-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on;  

    plot(Array_Time,Damped_Y_Crit,'b-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);  
    hold on;
  
  %Plots the particles in their corresponding lines
  
    plot(Array_Time(i),SHO_Y(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_Y_01(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_Y_11(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_Y_Crit(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold off; 
       
  %Plots the graph for the velocities  
    subplot(3,1,2);
    
    plot(Array_Time,SHO_V,'c-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);  
    hold on;  

    plot(Array_Time,Damped_V_01,'r-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on;
  
    plot(Array_Time,Damped_V_11,'g-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on;  

    plot(Array_Time,Damped_V_Crit,'b-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);  
    hold on;
  
  %Plots the particles in their corresponding lines
  
    plot(Array_Time(i),SHO_V(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_V_01(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_V_11(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_V_Crit(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold off;    
    
  %Plots the graph for the accelerations 
    subplot(3,1,3);
    
    plot(Array_Time,SHO_A,'c-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);  
    hold on;  

    plot(Array_Time,Damped_A_01,'r-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on;
  
    plot(Array_Time,Damped_A_11,'g-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on;  

    plot(Array_Time,Damped_A_Crit,'b-');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);  
    hold on;
  
  %Plots the particles in their corresponding lines
  
    plot(Array_Time(i),SHO_A(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_A_01(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_A_11(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]);   
    hold on; 
    
    plot(Array_Time(i),Damped_V_Crit(i),'ko');
    axis([0,50,-Y_Axis_Val,Y_Axis_Val]); 
    title("Spring simulation");  
    hold off;    
       
  %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    
  endfor
  
endfunction

#INSTRUCTOR: FORCE OSCILLATION NOT SOLVED