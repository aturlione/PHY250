#################################################################
# TOTAL GRADE EXERCISE 2: 50/50p
#################################################################

#The simulation is performed correctly ---> 35/35 p
#The questions are correctly answered ---> 15/15 p

#################################################################


%========================================================
% PHY250
% Digipen Bilbao
% Javier Guerra  - j.guerra@digipen.edu
%========================================================

function frequencies
  %decides which instrument it plots, viola or cello
    ##{
  instrument = menu('Choose', 'Viola', 'Cello');
  
  %Read frequencies and amplitudes from the real sound and plot them
  if(instrument == 0);
    [s fs] = audioread('viola.wav');
  else
    [s fs] = audioread('cello.wav');
  endif

  s=s/max(abs(s));
  trans = abs(fft(s));
  L = length(trans);
  spectrum = trans(1:L/2);
  
  Ls = length(spectrum);
  spectrum = spectrum / max(spectrum);
  frequencies = fs*(1:(L/2))/L;
  Lf = length(frequencies);
  
  n = length(s);
  t = n/fs;
  Ts = 1/fs;
  time = [0:Ts:(t-Ts)];
  
  subplot(2,1,1);
  plot(time, s, 'b');
  title("Signal");
  xlabel("time(s)");
  ylabel("Amplitude");
  axis([0.4 0.5 -0.5 0.5]);
  
  subplot(2,1,2);
  plot(frequencies, spectrum);
  title("Spectrum");
  xlabel("Frequencies(HZ)");
  ylabel("Amplitude");
  axis([0 2000 0 1]);
 
  %Vector of frequencies
  f = linspace(0,0,length(time));
  %first frequency of each sound
  if(instrument == 0);
    f0 = 125; %viola
  else
    f0 = 230; %cello
  endif
  %Array with first 7 amplitudes of the sounds
  if(instrument == 0);
    A = [0.05 1 0.6 0.3 0.4 0.3 0.1];%viola
  else
    A = [1 0.75 0.61 0.04 0.03 0 0.02];%cello
  endif
  precision = length(A);
  
  %compute the rest of the frequencies with the formulas given in class
  for n = 1 : precision;
    f += A(n) .* cos(2.*pi.*n.*f0.*time);
  endfor
  
  %scale the frequencies to match the scale of the interval of the plot
  if(instrument == 0);
    f = f/7.0;%viola
  else
    f = f/10.0;%cello
  endif
  
  %plot the amplitud over the time
  subplot(2,1,1);
  hold on;
  plot(time, f, 'r');
  
  %calculate the frequencies over the amplitud and plot them
  frequencies = linspace(f0, f0*7, 7);
  subplot(2,1,2)
  hold on;
  bar(frequencies, A, 0.01, 'r');
  #}
endfunction

 %Questions:
 % 4.The first difference is that in my plot the amplitud stays the same
 % all the time, but in the ral one changes over time, so my aproximation
 % had to be scaled to fit properly the scale in which we are ploting,
 % but would have to be rescaled by other magnitud to fit other interval.
 % The second one is that we are not taking into account other frequencies
 % from other waves, as for example the ones the soundbox of the viola or cello
 % make different minumums not appear.
 % Last, there is the amplitud shift. In our model, the distance between the 
 % maximums stays the same, but in the real wave it changes over time. That is
 % another reason why the aproximation of our model only works in this interval.
 %
 %5. The way to improve the quality would be to take into consideration
 %   the aspects mentioned in the previous question.

