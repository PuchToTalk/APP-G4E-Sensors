%{
// ---------------- DEBUT EN TETE --------------------------------------//
// NOM :                    Probleme 1 - APP E G                        //
//                                                                      //
// AUTEURS : T.BOURGEOIS,P.CHU,N.DELMAS,D.PEDINIELLI,T.PETIT DE SERVINS,//
//           K.YANG                                                     //
//                                                                      //
// VERSION :    1.1       T.BOURGEOIS              avril 2022           //
//                                                                      //
// HISTORIQUE : Aucun                                                   //
//                                                                      //
// ENTREES :  				                                            //
//	  S (sensibilité micro en dBV), G (gain micro dB),                  //
//	  P_SPL (dB SPL1), Dt (en seconde, durée minamal d'un son)       	//
//	  Signal Sonor caractérisé par sa fréquence d'échantillonage Fs et  //
//	un tableau de n relevé (n = duré signal/(1/Fs) = duré Signal/Te     //
//    LoS, longeur des signaux(un par signal)                           //
//    SdB, le seuil en décibel (nous l'adapterons en fonction du signal,//
//  mais un calcul plus poussé sera fournit dans le livrable afin       //
//  d'expliquer la démarche derrière ce seuil                           //
//	  𝑆 = −48 𝑑𝐵𝑉, 𝐺 = 30 𝑑𝐵, 𝑃𝑆𝑃𝐿 = 80 𝑑𝐵 𝑆𝑃𝐿, 𝐷𝑡 = 1𝑠, 𝑑𝑡 = 0.5𝑠  	//
// SORTIES :                                                            //
//	  Courbes des signaux MarteauPiqueur, Ville01, Jardin01, Jardin02	//
//	  Courbes des puissances MarteauPiqueur, Ville01, Jardin01, Jardin02//
// MODIFIEES :                                                          //
//    courbe des puissance (en W et en dB)                              //
// LOCALES :                                                            //
//	  n, utiliser dans les boucles for de la formule                    //
//    d'un signal échantilloné            			                    //
//                                                                      //
// FONCTIONS APPELEES :                                                 //
//                                                                      //
// ALGO - REFERENCES :                                                  //
//                                                                      //
// --------------------------- FIN EN TETE -----------------------------//
%}

clc
close all
clear

%On initialise une figure afin d'afficher toutes nos courbes sur une seule fenêtre
figure; 

%On initialise nos variables dans un premier temps
S = -48;
G = 30;  
PSPL = 80;
Dt = 1; 
dt = 0.5;
K= 1500;

%On récupére nos signaux audio à l'aide de la fonction audioread
[y,Fs] = audioread("MarteauPiqueur01.mp3");%Marteau Piqueur
[y1,Fs1] = audioread("Ville01.mp3");%Ville01
[y2,Fs2] = audioread("Jardin01.mp3");%jardin01
[y3,Fs3] = audioread("Jardin02.mp3");%jardin02

%LoS
loS=length(y);
loS1=length(y1);
loS2=length(y2);
loS3=length(y3);

%On créer des liste vide pour nos puissance que nous remplirons par la
%suite à l'aide de la formule du cours et d'une boucle for
yP = zeros(0,loS);
yP1 = zeros(0,loS1);
yP2 = zeros(0,loS2);
yP3 = zeros(0,loS3);

%On créer les varibles pour les valeur en dB des puissances
yPdB = zeros(0,loS);
yP1dB = zeros(0,loS1);
yP2dB = zeros(0,loS2);
yP3dB = zeros(0,loS3);

SdB =zeros(0,loS);
S1dB=zeros(0,loS1);
S2dB=zeros(0,loS2);
S3dB=zeros(0,loS3);

%On s'attaque a présent a la partie calculatoire:
%P watt
for n=K+1:1:loS-K
    yP(n)=mean(y(n-K:n+K).^2);
end

for n=K+1:1:loS1-K
    yP1(n)=mean(y1(n-K:n+K).^2);
end

for n=K+1:1:loS2-K
    yP2(n)=mean(y2(n-K:n+K).^2);
end

for n=K+1:1:loS3-K
    yP3(n)=mean(y3(n-K:n+K).^2);
end

%P dB
for n=K+1:1:loS-K
    yPdB(n)=10*log10(yP(n)/10E-3);
end

for n=K+1:1:loS1-K
    yP1dB(n)=10*log10(yP1(n)/10E-3);
end

for n=K+1:1:loS2-K
    yP2dB(n)=10*log10(yP2(n)/10E-3);
end

for n=K+1:1:loS3-K
    yP3dB(n)=10*log10(yP3(n)/10E-3);
end

%filtrage
for n=K+1:1:loS-K
    if n ~= K+1
        if yPdB(n)>-45
            SdB(n) = yPdB(n);
        else
            SdB(n) = -45;
        end
    end
end    

for n=K+1:1:loS1-K
    if n ~= K+1
        if yP1dB(n)>-12.5
            S1dB(n) = yP1dB(n);
        else
            S1dB(n) = -12.5;
        end
    end
end 

for n=K+1:1:loS2-K
    if n ~= K+1
        if yP2dB(n)>-20
            S2dB(n) = yP2dB(n);
        else
            S2dB(n) = -20;
        end
    end
end 

for n=K+1:1:loS3-K
    if n ~= K+1
        if yP3dB(n)>-10
            S3dB(n) = yP3dB(n);
        else
            S3dB(n) = -10;
        end
    end
end 
%Pour finir on affiche les résultat
%marteau piqueur
subplot(4,3,1)
plot(y)
title("signal marteau piqueur");
ylabel("Volts");
xlabel("secondes");

subplot(4,3,2)
plot(yP)
ylabel("Watt");
xlabel("secondes");
title("Puissance instantanée du marteau piqueur");

subplot(4,3,3)
plot(yPdB)
hold on
yline(-45)
hold on
plot(SdB)
ylabel("dB");
xlabel("secondes");
title("Puissance instantanée du marteau piqueur");

%Ville01
subplot(4,3,4)
plot(y1)
title("signal Ville01");
ylabel("Volts");
xlabel("secondes");

subplot(4,3,5)
plot(yP1)
ylabel("Watt");
xlabel("secondes");
title("Puissance instantanée Ville01");

subplot(4,3,6)
plot(yP1dB)
hold on
yline(-12.5)
hold on
plot(S1dB)
ylabel("dB");
xlabel("secondes");
title("Puissance instantanée Ville01");

%Jardin01
subplot(4,3,7)
plot(y2)
title("signal Jardin01");
ylabel("Volts");
xlabel("secondes");

subplot(4,3,8)
plot(yP2)
ylabel("Watt");
xlabel("secondes");
title("Puissance instantanée jardin01");

subplot(4,3,9)
plot(yP2dB)
hold on
yline(-20)
hold on
plot(S2dB)
ylabel("dB");
xlabel("secondes");
title("Puissance instantanée Jardin01");

%Jardin02
subplot(4,3,10)
plot(y3)
title("signal Jardin02");
ylabel("Volts");
xlabel("secondes");

subplot(4,3,11)
plot(yP3)
ylabel("Watt");
xlabel("secondes");
title("Puissance instantanée jardin02");

subplot(4,3,12)
plot(yP3dB)
hold on
yline(-10)
hold on
plot(S3dB)
ylabel("dB");
xlabel("secondes");
title("Puissance instantanée Jardin02");