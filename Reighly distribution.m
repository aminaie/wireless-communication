clc
clear

var=1;
mean=0;

x1=rand(1,10000);     % uniform random varianle
x2=rand(1,10000);     % uniform random varianle
xn1=sqrt(-log(x1)).*cos(2*pi*x2);
xn2=sqrt(-log(x1)).*sin(2*pi*x2);
xry=sqrt(-2*log(x1));  % Rayleigh distribution random varianle
xrc=sqrt(xn1.^2+xn2.^2);  % Rice distribution


figure
subplot(2,2,1)
hist(x1,1000)
title('Uniform')

subplot(2,2,2)
hist(xn1,1000)
title('Normal')

subplot(2,2,3)
hist(xry,1000)
title('Rayleigh')

subplot(2,2,4)
hist(xrc,1000)
title('Rice')

% h = findobj(gca,'Type','patch');
% h.FaceColor = [0.8 0.2 0.5];
% h.EdgeColor = 'w';
% 
% hold on
% 
% hist(x1,100)
% h1 = findobj(gca,'Type','patch');
% h1.FaceColor = [0.1 0.8 0.1];
% h1.EdgeColor = 'w';

%hold on
%hist(xn2,100)
