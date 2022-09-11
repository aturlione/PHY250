
a=0.4 %circle radious
v0=10 %limit velocity
N=15; % number of points in the grid
l=-1. % lower limit in space interval
u=1.  % uper limit in space interval
Np=1  %number of particles

scale_factor = 0.01; %velocity scale fator

%------------Mesh grid------------
xx=linspace(l,u,N); 

zz=linspace(l,u,N);

[x,z]=meshgrid(xx,zz);

%------------Velocity field------------

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

%------------Particles Initial Position------------

xp=zeros(Np,N);
zp=zeros(Np,N);

for i=1:2
  for j=1:N
    xp(i,j)=l + ((u-l)/N)*j;
    zp(i,j)=l;
  endfor
endfor

%------------------------time loop----------------
dt=0.2 % time step

for i=1:50
  for k=1:Np
    for j=1:N
      %velocity interpolation
      vxp = interp2 (x, z, vx, xp(k,j), zp(k,j),'spline');
      vzp = interp2 (x, z, vz, xp(k,j), zp(k,j),'spline');
      
      %actualize particle position
      xp(k,j) +=scale_factor*vxp*dt;
      zp(k,j) +=scale_factor*vzp*dt;
    endfor
    %------------------------Plot particles position----------------
    plot(xp,zp,'ko');
      
    %------------------------Plot axis properties-------------------
    title ({"Fluid Simulation";"Non viscosity - Non rotational"},"fontsize", 12);
    xlabel ("x ","fontsize", 16);
    ylabel ("y ","fontsize", 16);


    daspect ([1 1])
    axis([l u l u])
      
    hold on
  endfor
  %--------------Plot obstacle--------------------
  t = linspace(0,2*pi,100)'; 

  xc=a*cos(t);
  zc=a*sin(t);

  plot(xc,zc);
  %---------------Plot vectorial field
  h = quiver (x,  z, vx*scale_factor, vz*scale_factor,'AutoScale','off');
  hold off
  %--------------Print plot
  filename=sprintf('E:/Digipen/PHY250/2021/Fluid_simulation/vectorialfield/animation/%05d.png',i);
  print(filename);
endfor



