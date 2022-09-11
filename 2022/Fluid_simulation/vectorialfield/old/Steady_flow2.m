l=-10;

u=10;

Nh=30;
Nv=10;
Np=10

v0=0.5;

x=linspace(l,u,Nh); 
y=linspace(l,u,Nv); 

[xg,yg]=meshgrid(x,y);

A=1/20;
B=7;


y1=@(z)-tanh(z)+tanh(z-B)+B;
y2=@(z) tanh(z)-tanh(z-B)-B;



%------------Velocity field------------

vx=(v0.*B.^2 ./(-tanh(xg)+tanh(xg-B)+B).^2);
vy=0 .*xg;

xp=zeros(1,Np);
yp=zeros(1,Np);
for i=1:Np
xp(i)=-5 - ((u-l)/Np)*(i-1)
yp(i)=-6 
endfor



dt=0.5;



%xps=[xp] 
%yps=[yp]
k=0

for i=1:100
disp(i) 
      for j=1:Np  

          %velocity interpolation
          vxp = interp2 (xg, yg, vx, xp(j), yp(j),'spline');
          vyp = interp2 (xg, yg, vy, xp(j), yp(j),'spline');

          %actualize particle position
          xp(j) +=vxp*dt;
          yp(j) +=vyp*dt;
          
          if(yp(j)>y1(xp(j)))
            yp(j)=y1(xp(j));
            norm=sqrt(yp(j)^2+xp(j)^2);
            vxp=vxp*xp/norm; #the velocity is wrong, this is the projection on the position vector, not the tangent. correct!
            vyp=vyp*yp/norm;
            vyp=vyp*yp/norm;
          endif
          
        
          if(yp(j)<y2(xp(j)))
            k=1
            yp(j)=y2(xp(j));
            norm=sqrt(yp(j)^2+xp(j)^2);
            vxp=vxp*xp/norm;
            vyp=vyp*yp/norm;
          endif

      endfor

plot(x,y1(x))
hold on
plot(x,y2(x))
axis([l u 2*l 2*u])
plot(xp,yp,'ko'); 
%---------------Plot vectorial field
h = quiver (xg, yg, vx, vy,'AutoScale','off');
hold off

%--------------Print plot
filename=sprintf('E:/Digipen/PHY250/2021/Fluid_simulation/vectorialfield/animation_sf/%05d.png',i);
print(filename);
  


%xps=[-10:0.5:xp] 
%yps=[0:0.5:yp]
endfor





  

  
