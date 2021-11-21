clc
close
clear

%initial value
fc=900*10^6;
c=3*10^8;
Pt=1.45; % watt
R=-1;    % 
ht=50;
hr=2;
Gl=1;
Gr=1;
lamda=c/fc;
d=10:10:10^5;
xx_prim=sqrt((ht+hr)^2+(d).^2);
el=sqrt((ht-hr)^2+(d).^2);

%phase shift generation
delta_phi=4*pi*ht*hr./(lamda.*d);

% received power generation // 2-ray
Pr= Pt * (lamda/(4*pi)) * abs( (sqrt(Gl)./el)  +  (R*sqrt(Gr)*exp(-i*delta_phi))./xx_prim  ).^2 ; 

% received power generation // piecewise
d0=1;

dc=4*ht*hr/(lamda);

K=1;

y1=1;
y2=5;

Pr_1= 10*log10(Pt) + K -10*y1*log10(d(1:dc/10)/d0);
Pr_2= 10*log10(Pt) + K -10*y1*log10(dc/d0) - 10*y2*log10(d(dc/10 +  1 : end)/dc);
Prr=[Pr_1 Pr_2];

% figute
figure
plot(log10(d/d0), 10*log10(Pr))
hold on
plot(log10(d/d0),Prr)
legend('2-ray','piecewise linear')
xlabel('log10(d/d0)')
ylabel('Receiveed power Pr')

