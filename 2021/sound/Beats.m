fs=44100;
  t=0:1/fs:10;
n=1;

f=90;  
  

w=zeros(1,12);
A=zeros(1,12);
signal=0;

A(1)=1
A(2)=1


%for i=1:12

%w(i)=2*pi*i*f;


%signal=A(i)*cos(w(i)*t)+signal;

%end

w(1)=2*pi*f;
w(2)=2*pi*(f*1.01);


 signal=A(1)*cos(w(1)*t)+A(2)*cos(w(2)*t);

 

 audiowrite('E:/Digipen/PHY250/2021/sound/outputs/Beat.wav', signal,fs);
 
 
 t2=linspace(0.5,2,10000);
 

 signal2=0
 
for i=1:12

signal2=A(i)*cos(w(i)*t2)+signal2;
end 



 plot(t2,signal2);
 
 hold on
 
% plot(t2,A(1)*cos(w(1)*t2))
%  hold on

%  plot(t2,2*A(2)*cos((w(2)+W(1))*t2&2))
  
axis ([0.5 2 -3 3]);
ylabel("signal(x)","fontsize", 16); 
xlabel("x","fontsize", 16); 
 
   hold off
 %hold off