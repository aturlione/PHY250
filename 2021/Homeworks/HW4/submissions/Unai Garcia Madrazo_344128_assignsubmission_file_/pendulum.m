function pendulum
  clc %clear the console
  
  figure(1);
  title("Simple pendulum");
  axis([-3,3,-3,3]);
  axis('ij');
  
  %Name for the folder to create the images at
  out_dir = "result_images";
  %Makes the directory
  mkdir(out_dir);
  
  L = 2;
  
  Initial_Angle_Euler = 1; %Angle in radians
  Initial_W_Euler = 0; %Velocity m/s
  
  Initial_Angle_Semi = 1; %Angle in radians
  Initial_W_Semi = 0; %Velocity m/s
  
  N_Elements = 300;
    
  TimeStep  = 0.05;
  
  Array_Time = linspace(0,15,TimeStep);
  
  %Arrays for euler integration
  Array_Angle_Euler = [];
  Array_W_Euler = [];
   
  Array_X_Euler = [];
  Array_Y_Euler = [];
  
  %Arrays for semi euler integration
  Array_Angle_Semi = [];
  Array_W_Semi = [];
  
  Array_X_Semi = [];
  Array_Y_Semi = [];
  
  Div = (-9.8)/L;
  
  for i=1:N_Elements
  
    %Perform euler integration and draws
    Array_W_Euler(i) = Initial_W_Euler + TimeStep *(Div * sin(Initial_Angle_Euler));
    Array_Angle_Euler(i) = Initial_Angle_Euler + TimeStep * Initial_W_Euler;
      
    Initial_Angle_Euler = Array_Angle_Euler(i);
    Initial_W_Euler = Array_W_Euler(i);
        
    Array_X_Euler(i) = L * sin(Array_Angle_Euler(i));
    Array_Y_Euler(i) = L * cos(Array_Angle_Euler(i));
    
    plot(Array_X_Euler(i),Array_Y_Euler(i),'o');
    axis([-3,3,-3,3]);
    axis('ij');
    hold on;
    
    %Performs semi euler integration and draws
    Array_W_Semi(i) = Initial_W_Semi + TimeStep *(Div * sin(Initial_Angle_Semi));
    Array_Angle_Semi(i) = Initial_Angle_Semi + TimeStep * Array_W_Semi(i);
    
    Initial_Angle_Semi = Array_Angle_Semi(i);
    Initial_W_Semi = Array_W_Semi(i);
    
    Array_X_Semi(i) = L * sin(Array_Angle_Semi(i));
    Array_Y_Semi(i) = L * cos(Array_Angle_Semi(i));  
    
    plot(Array_X_Semi(i),Array_Y_Semi(i),'ro');
    axis([-3,3,-3,3]);
    axis('ij');
    title("Simple pendulum");
    hold off;
    
    %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname); 
  endfor

figure(2)
axis([-1,1,-1,1]);

 
for i=1:N_Elements
  
  plot(Array_Angle_Euler(i),Array_Time(i));
  axis([-1,1,-1,1]);
  hold on;
endfor

endfunction
