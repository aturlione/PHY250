[s fs] = audioread('E:\\Digipen\\PHY250\\2021\\Final_project\\Sound\\source\\Alex_sounds\\Violin.wav'); #Load signal,fs:sampling rate
#s=s/max(abs(s));
trans=abs(fft(s)); #Fourier fast transform, only real values
L=length(trans)
spectrum=trans(1:L/2); #reject half of the harmonics,  bilateral transform: x-coordinate mirrored, not wanted effect

Ls=length(spectrum);
spectrum=spectrum/max(spectrum); #normalized spectrum
frequencies=fs*(1:(L/2))/L; #frequencies vector, total time=L/fs
Lf=length(frequencies)


n=length(s)
t=n/fs;
Ts=1/fs;
time=[0:Ts:(t-Ts)];
#figure

A=zeros(1,7);
#{
#ARC
A(1)=0.1;
A(2)=1;
A(3)=0.52;
A(4)=0.18;
A(5)=0.04;
A(6)=0.11;
A(7)=0.08;

f=200
#}

#{
#Pizz
A(1)=0.3;
A(2)=1;
A(3)=0.7;
A(4)=0.37;
A(5)=0.31;
A(6)=0.25;
A(7)=0.11;

f=200;
#}

#{
#Pizz
A(1)=1;
A(2)=0.7;
A(3)=0.7;
A(4)=0.056;
A(5)=0.022;
A(6)=0.;
A(7)=0.018;

f=235;
#}

##{
#Pizz
A(1)=0.1;
A(2)=1;
A(3)=0.5;
A(4)=0.18;
A(5)=0.04;
A(6)=0.11;
A(7)=0.07;

f=196;
#}

[frequencies_sim,signal_sim]=simulation(A,f,fs,n);
  
subplot(2,1,1)
plot(time,s,'b')
axis([0.4 0.5 -0.5 0.5])
hold on
plot(time,signal_sim,'r');


hold off
title(['Signal']);
xlabel('time(s)')
ylabel('Amplitude')

subplot(2,1,2)

plot(frequencies,spectrum)
hold on
bar(frequencies_sim,A,0.01)
axis([0 2000 0 1])
hold off
title(['Spectrum']);
xlabel('Frequencies (HZ)')
ylabel('Amplitude')


