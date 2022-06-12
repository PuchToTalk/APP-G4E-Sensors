%Exercice 1 Matlab APP
%Partie A
disp(" ");
disp("[Premier signal]")
disp(" ")

F0 = 10^3; A1 = 2;

Fe = 16*10^3; Te = 1/Fe;
D = 2;

t = 0:Te:D;

x1 = A1*sin(2*pi*F0*t);
n = ceil(5*(Fe/F0));

figure;
plot(t(1:n),x1(1:n));
ylabel("Amplitude (V)"); xlabel("Temps (s)"); title("Graphe du signal 1")

%Partie B

X1 = (1/length(x1))*sum(x1,"all");
disp("Valeur moyenne : " + X1);
P1 = (1/length(x1))*sum(x1.*x1,"all");
disp("Puissance moyenne en W : " + P1);
P_dBm1 = 10*log10(P1/10^-3);
disp("Puissance moyenne en dBm : " + P_dBm1);
A_eff1 = sqrt(P1);
disp("Valeur efficace : " + A_eff1);

%Partie C
disp(" ");
disp("[Deuxième signal]")
disp(" ")

F0 = 10^3; A2 = 2;

Fe = 16*10^3; Te = 1/Fe;
D = 2;

t = 0:Te:D;
n = ceil(5*(Fe/F0));

x2 = abs(A2*sin(2*pi*F0*t));

figure;
plot(t(1:n),x2(1:n));
ylabel("Amplitude (V)"); xlabel("Temps (s)"); title("Graphe du signal 2");

X2 = (1/length(x2))*sum(x2,"all");
disp("Valeur moyenne : " + X2);
P2 = (1/length(x2))*sum(x2.*x2,"all");
disp("Puissance moyenne en W : " + P2);
P_dBm2 = 10*log10(P2/10^-3);
disp("Puissance moyenne en dBm : " + P_dBm2);
A_eff2 = sqrt(P2);
disp("Valeur efficace : " + A_eff2);

disp(" ");
disp("[Troisième signal]")
disp(" ")

F0 = 10^3; A3 = 1.25;

Fe = 16*10^3; Te = 1/Fe;
D = 2;

t = 0:Te:D;

x3 = A3*square(sin(2*pi*F0*t)) + 1.25;
n = ceil(5*(Fe/F0));

figure;
plot(t(1:n),x3(1:n))
ylabel("Amplitude (V)"); xlabel("Temps (s)"); title("Graphe du signal 2");

X3 = (1/length(x3))*sum(x3,"all");
disp("Valeur moyenne : " + X3);
P3 = (1/length(x3))*sum(x3.*x3,"all");
disp("Puissance moyenne en W : " + P3);
P_dBm3 = 10*log10(P3/10^-3);
disp("Puissance moyenne en dBm : " + P_dBm3);
A_eff3 = sqrt(P3);
disp("Valeur efficace : " + A_eff3);

%Partie D

disp(" ");
disp("[Quatrième signal]")
disp(" ")

F0 = 10^3; T0 = 1/F0; A4 = 1.78038 ; phi = pi/3;

Fe = 16*10^3; Te = 1/Fe;
D = 2;

t = 0:Te:D;

x4 = A4*sin(2*pi*F0*t + phi);
n = ceil(5*(Fe/F0));

P4 = (1/length(x1))*sum(x4.*x4,"all");
disp("Puissance moyenne en W : " + P4);
P_dBm4 = 10*log10(P4/10^-3);
disp("Puissance moyenne en dBm : " + P_dBm4);

figure;
plot(t(1:n),x4(1:n));
ylabel("Amplitude (V)"); xlabel("Temps (s)"); title("Graphe du signal 4")

%Partie E

N = length(x1); 
C_xx = zeros(1,N);
x1_bis = [x1;zeros(1,N)];
for i = 1:N
    C_xx(i) = sum(x1.*x1_bis(i:i+N-1)*Te); %autocorélation
end

figure;
stem(C_xx(1:n)); ylabel("Amplitude (V)"); xlabel("Temps (s)"); title("Autocorrélation") 

N = length(x4); 
C_xy = zeros(1,N);
x4_bis = [x4;zeros(1,N)];
for i = 1:N
    C_xy(i) = sum(x1.*x4_bis(i:i+N-1)*Te); %intercorélation
end

figure;
stem(C_xy(1:n)); ylabel("Amplitude"); xlabel("Temps"); title("Intercorrélation")