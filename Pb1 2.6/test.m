clc
close all
clear all
F0=1000;
T0=1/F0;
A=2;
Fe=16000;
Te=1/Fe;
D=2;
t=0:Te:D;
N=length(t);
B=1.78;
phi=pi/3;

x=A*sin(2*pi*F0*t);

figure;
subplot(2,7,1)
plot(t,x);
xlabel('seconds')
ylabel('Volt')
title('Signal x in time domain - 5 periods')
grid on;
axis([0,0.005,-1.05*A,1.05*A])

valmoyenne=(1/(N+1))*sum(x,'all');
puissancemoyenne=(1/(N+1))*sum(x.^2,'all');
valeurefficace=sqrt(puissancemoyenne);

x2=sqrt(x.^2);
subplot(2,7,2)
plot(t,x2)
xlabel('seconds')
ylabel('Volt')
title('Signal x2 in time domain - 5 periods')
grid on;
axis([0,0.005,-1.05*A,1.05*A])

valmoyenne2=(1/(N+1))*sum(x2,'all');
puissancemoyenne2=(1/(N+1))*sum(x2.^2,'all');
valeurefficace2=sqrt(puissancemoyenne2);

x3=(0.75*square(2*pi*t*F0))+1.25;
subplot(2,7,3)
plot(t,x3)
xlabel('seconds')
ylabel('Volt')
title('Signal x3 in time domain - 5 periods')
grid on;
axis([0,0.005,-1.05*A,1.05*A])

valmoyenne3=(1/(N+1))*sum(x3,'all');
puissancemoyenne3=(1/(N+1))*sum(x3.^2,'all');
valeurefficace3=sqrt(puissancemoyenne3);

x4=B*sin(2*pi*F0*t+phi);
subplot(2,7,4)
plot(t,x4)
xlabel('seconds')
ylabel('Volt')
title('Signal x4 in time domain - 5 periods')
grid on;
axis([0,0.005,-1.05*A,1.05*A])

valmoyenne4=(1/(N+1))*sum(x4,'all');
puissancemoyenne4=(1/(N+1))*sum(x4.^2,'all');
valeurefficace4=sqrt(puissancemoyenne4);

Cxx=zeros(1,N);
m=round(5*T0/Te);
for k=1:N+1-m
    Cxx(k)=mean(x(1:m).*x(k:m+k-1));
end
subplot(2,7,5)
plot(t,Cxx)
xlabel('seconds')
ylabel('Volt')
title('autocorrélation de x')
grid on;
axis([0,0.05,-1.05*A,1.05*A])

Cxx4=zeros(1,N);
m=round(5*T0/Te);
for k=1:N+1-m
    Cxx4(k)=mean(x(1:m).*x4(k:m+k-1));
end
subplot(2,7,6)
plot(t,Cxx4)
xlabel('seconds')
ylabel('Volt')
title('intercorrélation de x et x4')
grid on;
axis([0,0.005,-1.05*A,1.05*A])

K=1100;

[y1,FS]=audioread('MarteauPiqueur01.mp3');
subplot(2,7,7)
plot(y1);
title('Marteau piqueur')

N1=length(y1);
Pn_mp=zeros(1,N1);
for n=K+1:1:N1-K
    Pn_mp(n)=mean(y1(n-K:n+K).^2);
end
subplot(2,7,8)
plot(Pn_mp)
title('puissance instantanée Marteau piqueur')

[y2,FS2]=audioread('Jardin01.mp3');
subplot(2,7,9)
plot(y2);
title('jardin 1')

N2=length(y2);
Pn_j1=zeros(1,N2);
for n=K+1:1:N2-K
    Pn_j1(n)=mean(y2(n-K:n+K).^2);
end
subplot(2,7,10)
plot(Pn_j1)
title('puissance instantanée jardin 1')

[y3,FS3]=audioread('Jardin02.mp3');
subplot(2,7,11)
plot(y3);
title('jardin 2')

N3=length(y3);
Pn_j2=zeros(1,N3);
for n=K+1:1:N3-K
    Pn_j2(n)=mean(y3(n-K:n+K).^2);
end
subplot(2,7,12)
plot(Pn_j2);
title('puissance instantanée jardin 2')

[y4,FS4]=audioread('Ville01.mp3');
subplot(2,7,13)
plot(y4);
title('ville 1')

N4=length(y4);
Pn_v1=zeros(1,N4);
for n=K+1:1:N4-K
    Pn_v1(n)=mean(y4(n-K:n+K).^2);
end
subplot(2,7,14)
plot(Pn_v1)
title('puissance instantanée ville 1')