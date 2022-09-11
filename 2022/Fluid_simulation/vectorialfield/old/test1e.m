a=1
v0=10 
N=40; % number of points in the grid
l=1
scale_factor = 0.03;

xx=linspace(-3,3,N); % x component

zz=linspace(-3,3,N);


[x,z]=meshgrid(xx,zz);
M=[x,z];

xp=zeros(2,N);
zp=zeros(2,N);
%vx=x+z;
%vz=x+z;

vx=-(3*v0*a^3/2)*z.*x./sqrt(x.^2+z.^2).^5;
vz=v0+(v0*a^3/2)*(1 ./sqrt(x.^2+z.^2).^3-2*(z.^2)./sqrt(x.^2+z.^2).^5);


for i=1:N
  for j=1:N
    cond= sqrt(x(i,j)^2+z(i,j)^2);
    if (cond<a)
      vx(i,j)=0;
      vz(i,j)=0;
    endif
   endfor
endfor

for i=1:2
  for j=1:N
    xp(i,j)=-2 + (4/N)*j;
    zp(i,j)=-2;
  endfor
endfor
dt=0.5


  for i=1:50
    for k=1:2
    for j=1:N
      
      
      vxp = interp2 (x, z, vx, xp(k,j), zp(k,j),'spline');
      vzp = interp2 (x, z, vz, xp(k,j), zp(k,j),'spline');

      xp(k,j) +=scale_factor*vxp*dt;
      zp(k,j) +=scale_factor*vzp*dt;



    endfor
    plot(xp,zp,'k*');
    hold on

endfor

    t = linspace(0,2*pi,100)'; 

    xc=a*cos(t);
    zc=a*sin(t);

    plot(xc,zc);

 


    h = quiver (x,  z, vx*scale_factor, vz*scale_factor,'AutoScale','off');
    axis([-2 2 -2 2])

    hold off
    
    filename=sprintf('E:/Digipen/PHY250/2021/Fluid_simulation/vectorialfield/animation/%05d.png',i);
    print(filename);
endfor



