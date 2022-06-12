%{
// ---------------- DEBUT EN TETE --------------------------------------//
// NOM :                    Probleme 1 - APP E G                        //
//                                                                      //
// AUTEURS : T.BOURGEOIS,P.CHU,N.DELMAS,D.PEDINIELLI,T.PETIT DE SERVINS,//
//           K.YANG                                                     //
//                                                                      //
// VERSION :    1.7.3       T.BOURGEOIS              avril 2022         //
//                                                                      //
// HISTORIQUE : Aucun                                                   //
//                                                                      //
// ENTREES :  				                                            //
//	  S (sensibilité micro en dBV), G (gain micro dB),                  //
//	  P_SPL (dB SPL1), Dt (en seconde, durée minamal d'un son)       	//
//	  Signal Sonor caractérisé par sa fréquence d'échantillonage Fs et  //
//	un tableau de n relevé (n = duré signal/(1/Fs) = duré Signal/Te)    //
//    LoS, longeur du signal                                            //
//    seuil, le seuil en dB                                             //
//    Sw, le tableau de valeur du signal filtré en W                    //
//	  𝑆 = −48 𝑑𝐵𝑉, 𝐺 = 30 𝑑𝐵, 𝑃𝑆𝑃𝐿 = 80 𝑑𝐵 𝑆𝑃𝐿, 𝐷𝑡 = 1𝑠, 𝑑𝑡 = 0.5𝑠  	//
// SORTIES :                                                            //
//	  Courbe du signal 	                                                //
//	  Courbe de puissance en Watt et en dB                              //
//    Courbe filtré du bruit et du silence en dB                        //
//    D, duré du Signal, Cxx, coéficient d'autocorélation               //
// MODIFIEES :                                                          //
//    courbe de puissance (en W et en dB)                               //
// LOCALES :                                                            //
//	  n, utiliser dans les boucles for de la formule                    //
//   d'un signal échantilloné            			                    //
//    sauv, variable servant de check pour vérifier la duré d'un        //
//    var, désignant les point de la courbes entre t0 et t1             //
//  fragment du signal                                                  //
// FONCTIONS APPELEES :                                                 //
//                                                                      //
// ALGO - REFERENCES :                                                  //
//                                                                      //
// --------------------------- FIN EN TETE -----------------------------//
%}

clc
close all
clear

file = "Jardin01.mp3"; %fichier audio à sélectionner
seuil = -20; %a modifier

%On initialise une figure afin d'afficher toutes nos courbes sur une seule fenêtre
figure; 

%On initialise nos variables dans un premier temps
%S = -48;
%G = 30;  
%PSPL = 80;
Dt = 1; 
dt = 0.5;
K= 1500;


%On récupére nos signaux audio à l'aide de la fonction audioread
[y,Fs] = audioread(file);%fichier audio

%LoS
loS=length(y);

%On créer une liste vide pour nos puissance que nous remplirons par la
%suite à l'aide de la formule du cours et d'une boucle for
yP = zeros(0,loS);

%On créer les varibles pour les valeur en dB des puissances
yPdB = zeros(0,loS);
SdB =zeros(0,loS);
Sw = zeros(0,loS);


%On s'attaque a présent a la partie calculatoire:
%P watt
for n=K+1:1:loS-K
    yP(n)=mean(y(n-K:n+K).^2);
end
%P dB
for n=K+1:1:loS-K
    yPdB(n)=10*log10(yP(n)/10E-3);
end

%filtrage
n=K+1;
while n <= length(yPdB)
    if n ~= K+1
        sauv = n;
        if yPdB(n)>=seuil
            while yPdB(n)>=seuil
                if n==length(yPdB)
                    break
                end
                n = n+1;
            end
            if ((1/Fs)*(n-sauv))>Dt
                for var=sauv:1:n
                    SdB(var) = yPdB(var);
                end
            else
                for var = sauv:1:n
                    SdB(var) = seuil;
                end
            end
        else
            while yPdB(n)<seuil
                if n==length(yPdB)
                    break
                end
                n = n+1;
            end
            if ((1/Fs)*(n-sauv))<dt
                for var=sauv:1:n
                    SdB(var) = yPdB(var);
                end
            else
                for var = sauv:1:n
                    SdB(var) = seuil;
                end
            end
        end
    else
        n=n+1;
    end
    if n==length(yPdB)
        break

    end
end

%duré signal, autocorélation, Pmoy, PmoydB,Valeur efficace:
for n=K+1:1:loS-K
    Sw(n) = 10^(SdB(n)/10)*10^-3;
end
D = length(y)*(1/Fs);
Cxx = xcorr(SdB,SdB);
W = (1/length(Sw))*sum(Sw.*Sw,"all");
WdB = (1/length(SdB))*sum(SdB.*SdB,"all");
Veff = sqrt(W);


%Pour finir on affiche les résultat
%file
disp('Durée du Signal : '+D);
disp('Puissance moyenne du Signal en W : '+W);
disp('Puissance moyenne du Signal en dB : '+WdB);
disp('Valeur efficace du Signal en Volts : '+Veff);

subplot(5,1,1)
plot(y)
title("signal "+file);
ylabel("Volts");
xlabel("secondes");

subplot(5,1,2)
plot(yP)
ylabel("Watt");
xlabel("secondes");
title("Puissance instantanée du "+file);

subplot(5,1,3)
plot(yPdB)
hold on
yline(seuil)
ylabel("dB");
xlabel("secondes");
title("Puissance instantanée du "+file);

subplot(5,1,4)
plot(yPdB)
hold on
plot(SdB,'o')
hold on
yline(seuil)
ylabel("dB");
xlabel("secondes");
title("Signal filtré du "+file);

subplot(5,1,5)
plot(Cxx)
ylabel('Volts');
xlabel('secondes');
title('Autocorélation du' +file);