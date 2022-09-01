

omega=0:0.1:100

phi=0;
k=1;
m=1;
A=1;
b=0.1;
g=b/(2*m);
F0=1

b_cri=sqrt(4*m*k)

w0=sqrt(k/m);




A_f =@ (w,b) F0./sqrt((w.^2-w0.^2).^2+b^2*w.^2/m^2);
#phi_f=@ (w,b) atan((w0^2-w^2)/(w*(b/m)));


 #A_f =@ (w,b) F0/(m.*sqrt(w.^2);


#plot(omega,F0./sqrt((omega.^2-w0.^2).^2+b^2*omega.^2/m^2))  

plot(omega,A_f(omega,b))  




  

