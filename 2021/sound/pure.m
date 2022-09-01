
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



end


A(1)=1


signal=cos(w(1)*t);

 audiowrite('E:/Digipen/PHY250/2021/sound/Pure.wav', signal,fs);
 

 
 
 t2=linspace(1,1.005,200);
 

 signal2=0
 
for i=1:1

signal2=A(i)*cos(w(i)*t2)+signal2;
end 


subplot (2,1,1)
 plot(t2,signal2,'b');
  axis([1 1.005 -2 3]);
  ylabel("signal","fontsize", 16); 
 xlabel("t","fontsize", 16); 
 hold on
  title ("Fundamental");
 plot(t2,A(1)*cos(w(1)*t2),'r')

 freq=w/(2*pi)
 
  subplot (2,1,2) 
 h=bar(freq,A,0.1)
   ylabel("A_n/A_0","fontsize", 16); 
xlabel("w_n [2\\pi HZ]","fontsize", 16); 
 set (h, "facecolor", "r")

 filename=sprintf('E:/Digipen/PHY250/2021/sound/%05d.png',2);
  print(filename); 