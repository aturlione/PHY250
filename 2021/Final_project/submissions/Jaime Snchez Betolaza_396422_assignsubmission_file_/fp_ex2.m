#################################################################
# TOTAL GRADE EXERCISE 2: 35/50p
#################################################################

# The questions were not answered ---> 0/15

#The simulation is performed correctly: --->35/35


#################################################################

function fp_ex2
  
  %Create the figure and the folder
  figure(1);
  out_dir = "ex2_images";
  mkdir(out_dir);
  
  for i=1:2
    %Cleare what was created the last frame
  endfor
  hold off; 
  %Inport the sounds
  if(i == 1)  
    [s fs] = audioread('sounds\Viola.wav');
    amplitudes = [0.05,1,0.6,0.3,0.4,0.3,0.1];
    fo = 125;
  else
    [s fs] = audioread('sounds\Violin.wav');
    amplitudes = [0.1,1,0.5,0.2,0.05,0.1,0.15];
    fo = 230;
  endif
  
  %Normalizes the s
  s = s/max(s);
  
  %Computes the fourier
  trans = abs(fft(s));
  %Computes the length
  L = length(trans);
  %Negates the bottom part
  spectrum = trans(1:L/2);
  
  %Computes the length for the spectrum
  Ls = length(spectrum);
  spectrum = spectrum/max(spectrum);
  %Writs the frequencies in terms of the sampling rate
  frequencies = fs*(1:(L/2))/L;
  %Computes the length for the frequencies
  Lf = length(frequencies);
  
  %Computes the amount of s
  n = length(s);
  %Computes the finish time (TOTAL TIME)
  t = n/fs;
  %Computes the timestep
  Ts = 1/fs;
  %Computes the array for the time
  time = [0:Ts:(t-Ts)];
  
  %Plots the signal respect to the time
  subplot(3,1,1);
  plot(time,s,'b');
  title(['Signal']);
  xlabel ("Time");
  ylabel ("Amplitude");
  axis([0.1 0.2 -0.5 0.5]);
  
  %Plots the amplitude respect to the frequencies
  subplot(3,1,2);
  plot(frequencies,spectrum,'b');
  title(['Spectrum']);
  xlabel ("Frequencies");
  ylabel ("Amplitude");
  axis([0 3000 0 1]);
  
  %Computest the cumulative frequency
  f = amplitudes(1)*cos(2*pi*fo*time);  
  for n=2:7
    f += amplitudes(n)*cos(2*pi*fo*time*n);  
  endfor 
  
  if(i == 1)
    f = f/7;
  else
    f = f/10;
  endif
  
  %Plots the function respect to the time
  subplot(3,1,1);
  hold on;
  plot(time,f,'g');
  axis([0.1 0.2 -0.5 0.5]);
  
  %Plots the amplitude respect to the frequencies
  subplot(3,1,3);
  frequencies = linspace(fo,fo*7,7);
  bar(frequencies,amplitudes,0.1,'g');
  title(['Recreated spectrum']);
  xlabel ("Frequency");
  ylabel ("Amplitude");
  axis([0 3000 0 1]);  
  
  %Save the frame in a picture
  if(i == 1)  
    fname = fullfile(out_dir, sprintf("Viola_graphs.jpg", i));
  else
    fname = fullfile(out_dir, sprintf("Violin_graphs.jpg", i));
  endif
  imwrite(getframe(gcf).cdata,fname); 
endfor 
endfunction