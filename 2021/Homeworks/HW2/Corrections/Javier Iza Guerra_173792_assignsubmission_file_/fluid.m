% DigiPen Bilbao
% 540000517
% 12-10-2021

function fluid
  %Code taken from mat300 to make a video using octave
  out_dir = "temp_img"; %create folder to save images (COPY-PASTE IN YOUR CODE)
  mkdir (out_dir); %create folder to save images (COPY-PASTE IN YOUR CODE)

    
  X = linspace(-10, 10, 200); %array to store x-coordinate of curve
  Y1=[]; % array to store y-coordinate of curve
  Y2=[]; % array to store y-coordinate of curve
  A = 0.06;
  B = 4;
  
  %Surrounding functions
  Y1 = -tanh(A*X) + tanh((A*X) - B) + B;
  Y2 = -Y1;

  
  plot(X,Y1,'b') %plot curve
  hold on 
  plot(X,Y2,'r') % plot below curve
  axis([-10, 10, -10, 10],"square") % fix axis
  
  %Create a matrix with particle positions
  MX=zeros(7,1)
  MX(:,1) = [-10 -10 -10 -10 -10 -10 -10];
  v0 = 0.5;
  A0 = pi* (-tanh(A*-10) + tanh((A*-10) - B) + B) * (-tanh(A*-10) + tanh((A*-10) - B) + B);
  
  
  
  for i=1:29 % LOOP FOR CREATING EACH FRAME 
  
   
   for i=1:numel(MX)
     %update positions of the particles
     

     %Force points to be inside the functions
     max = -tanh(A*MX(i)) + tanh((A*MX(i)) - B) + B;
     min = -max;
     
     A1 = pi * max * max;
     velocity = (A0*v0)/A1
     MX(i)+= velocity;
     
     y = linspace(min+0.5, max-0.5, 7);

     %plot
     plot(MX(i,:), y, 'o');
     hold on
   endfor
   
   plot(X,Y1,'b') %plot curve
   hold on 
   plot(X,Y2,'r') % plot current point
   axis([-10, 10, -10, 10],"square") % fix axis
   hold off
   
   fname = fullfile (out_dir, sprintf ("img%03i.png", i)); % save image (COPY-PASTE IN YOUR CODE)
   imwrite (getframe (gcf).cdata, fname); %(COPY-PASTE IN YOUR CODE)
    
  end
end