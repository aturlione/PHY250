
 fs=44100;  % Sampling frequency---define the time step
 t=0:1/fs:10;  % Time vector of 10 second
  
n=1;

w=zeros(1,16);
A=zeros(1,16);
dB=zeros(1,16);
f=zeros(1,16);

signal=0

dB(1)=-22.8
dB(2)=-31.4
dB(3)=-28.9
dB(4)=-36.7
dB(5)=-46.2
dB(6)=-46
dB(7)=-65.3
dB(8)=-55.3
dB(9)=-37.9
dB(10)=-56.2
dB(11)=-74.3
dB(12)=-55.4
dB(13)=-61.7
dB(14)=-67.7
dB(15)=-61.4
dB(16)=-57.9



f=440

for i=1:16


w(i)=2*pi*i*f;

A(i)=(1/i)*sqrt(10^(dB(i)/10)/(10^(dB(1)/10)))


signal=A(i)*cos(w(i)*t)+signal;

end




 audiowrite('Y:/PHY250/Final_project/Sound/Clarinet.wav', signal,fs);
 

 
 
 t2=linspace(1,1.005,200);
 

 signal2=0
 
for i=1:16

signal2=A(i)*cos(w(i)*t2)+signal2;
end 



% plot(t2,signal2,'b');

% hold on
 
% plot(t2,A(1)*cos(w(1)*t2))
 
 freq=w/(2*pi)
 
 h=bar(freq,A,0.1)
 
 set (h, "facecolor", "r")

