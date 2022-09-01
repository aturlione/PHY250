l=-10;

u=10;

Nh=30;
Nv=10;
Np=2
Ny=7

v0=0.5;

x=linspace(l,u,Nh); 
y=linspace(l,u,Nv); 

[xg,yg]=meshgrid(x,y);

A=1/1.7;
B=4;

% ----------walls-----------------
y1=@(z)-tanh(z*A)+tanh(z*A-B)+B;
y2=@(z) tanh(z*A)-tanh(z*A-B)-B;

%------------tangents--------------
%(-dy/dy,dy/dx)/normal
%----------------------------------
t1x=@(z) -1/sqrt(1+(A*coth(z*A-B)-A*coth(z*A))^2)
t1y=@(z) (A*coth(z*A-B)-A*coth(z*A))/sqrt(1+(A*coth(z*A-B)-A*coth(z*A))^2) #tangent to the surface

t2x=@(z) -1/sqrt(1+(A*coth(z*A-B)-A*coth(z*A))^2)
t2y=@(z) (-A*coth(z*A-B)+A*coth(z*A)) /sqrt(1+(A*coth(z*A-B)-A*coth(z*A))^2)

%------------Velocity field---------------

vx=(v0.*B.^2 ./(-tanh(xg)+tanh(xg-B)+B).^2);
vy=0 .*xg;

xp=zeros(Np,Ny);
yp=zeros(Np,Ny);

%--------------Particles-------------------
for i=1:Np
  for j=1:Ny
    xp(i,j)=l - ((u-l)/(Np))*(i-1);
    yp(i,j)=l+(j-1)*((u-l)/(2.5*Ny))+6.5;
  endfor
endfor



dt=0.5;


k2=zeros(Np,Ny)
k1=zeros(Np,Ny);


#{
%xps=[xp] 
%yps=[yp]



plot(x,y1(x))
hold on
plot(x,y2(x))
axis([l u 2*l 2*u])
plot(xp,yp,'ko'); 
%---------------Plot vectorial field
h = quiver (xg, yg, vx, vy,'AutoScale','off');
hold off
#}


for i=1:150
disp('----')
disp(i)
disp('----')
      for j=1:Np  
        for m=1:Ny
          %velocity interpolation
          vxp = interp2 (xg, yg, vx, xp(j,m), yp(j,m),'spline');
          vyp = interp2 (xg, yg, vy, xp(j,m), yp(j,m),'spline');
          
          %actualize particle position
          xp(j,m) +=vxp*dt;
      
       
          yp(j,m) +=vyp*dt;
          
          if(yp(j,m)>y1(xp(j,m)))
            k1(j,m)=1;
            yp(j,m)=y1(xp(j,m));
            vxp=vxp*(t1x(xp(j,m)));
            vyp=vyp*(t1y(xp(j,m)));
          endif
          
        
          if(yp(j,m)<y2(xp(j,m)))
            k2(j,m)=1;
            
            yp(j,m)=y2(xp(j,m));
            vxp=vxp*(t2x(xp(j,m)));
            vyp=vyp*(t2y(xp(j,m)));
          endif
if(k2(j,m)>0)
  yp(j,m)=y2(xp(j,m));
endif

if(k1(j,m)>0)
  yp(j,m)=y1(xp(j,m));
endif

    endfor
    endfor

plot(x,y1(x))
hold on
plot(x,y2(x))
axis([l u l u])
plot(xp,yp,'ko'); 

%---------------Plot vectorial field
#h = quiver (xg, yg, vx, vy,'AutoScale','off');
hold off

%--------------Print plot
filename=sprintf('E:/Digipen/PHY250/2021/Fluid_simulation/vectorialfield/animation_sf/%05d.png',i);
print(filename);
  


%xps=[-10:0.5:xp] 
%yps=[0:0.5:yp]
endfor





  

  
