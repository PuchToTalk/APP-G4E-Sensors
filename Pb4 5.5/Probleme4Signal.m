
%{
// ---------------- DEBUT EN TETE -----------------------------------------//
// NOM :                    Probleme 1 - APP E G                           //
//                                                                         //
// AUTEURS : T.BOURGEOIS,P.CHU,N.DELMAS,D.PEDINIELLI,T.PETIT DE SERVINS,   //
//           K.YANG                                                        //
//                                                                         //
// VERSION :    1.1                 avril 2022                             //
//                                                                         //
// HISTORIQUE : Aucun                                                      //
//                                                                         //
// ENTREES :                                                               //
//      S (sensibilité micro en dBV), G (gain micro dB),                   //
//      PdBSPL (dB SPL)                                                    //
//      𝑆 = −55 𝑑𝐵𝑉, 𝐺 = 30 𝑑𝐵, 𝑃𝑆𝑃𝐿 = 74 𝑑𝐵 𝑆𝑃𝐿,                         //
// SORTIES :                                                               //
//      Puissance sonore du signal                                         //
//      Pourcentage de la puissance du signal dans les fréquances > 2kHz   //
// MODIFIEES :                                                             //
//                                                                         //
// ---------------- FIN EN TETE -------------------------------------------//
%}

clc
close all
clear

G=30;
S=-55;
PdBSPL=74;

%Calcul de Pmax en W

Pmax=10*log10(4)+G+S+PdBSPL-70;
Pwmax=10^(Pmax/10)*10^(-3); 


%Test sur signal MarteauPiqueur01

[z,Fz]=audioread("MarteauPiqueur01.mp3");
F2=length(z)/Fz;                            %fréquence             
Pz=mean(z.^2);                              %Puissance du signal  
PdBm=10*log10(Pz*10.^3);
j2=load("filtre1.mat").h;                   %filtre 
Z=filter(j2,1,z);                           %signal filtré
PZ=mean(Z.^2);                              %puissance moyenne en W du signal filtré
pourcent=PZ/Pz*100;                         %puissance_filtré/puissance_signal*100


disp("Test sur le fichier audio : MarteauPiqueur01")
disp(" ")
disp("  Puissance : "+Pz+" W")
disp("  Pourcentage :"+pourcent+" %")
disp(" ")

if and(Pz>=Pwmax, pourcent>20)
    disp("      MarteauPiqueur01.mp3 est un signal pénible")
else
    disp("      MarteauPiqueur01.mp3 est un signal non pénible")
end



disp("-------------------------------------------------------------")

%Test signal Jardin01
[w,Fw]=audioread("Jardin01.mp3");
F3=length(w)/Fw;                            %fréquence             
Pw=mean(w.^2);                              %Puissance du signal  
j=load("filtre1.mat").h;                    %filtre 
W=filter(j2,1,w);                           %signal filtré
PW2=mean(W.^2);                             %puissance moyenne en W du signal filtré
wpourcent=PW2/Pw*100;                       %puissance_filtré/puissance_signal*100

               

disp("Test sur le fichier audio : Jardin01")
disp(" ")
disp("  Puissance sonore totale : "+Pw+" W")

disp("  Pourcentage :"+wpourcent+" %")
disp(" ")

if and(Pw>=Pwmax, wpourcent>20)
    disp("      Jardin01.mp3 est un signal pénible")
else
    disp("      Jardin01.mp3 est un signal non pénible")
end




