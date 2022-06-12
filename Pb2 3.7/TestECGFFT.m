clc;
close all;
clear variables;
[y, Fs] = audioread('109.wav');
Ts = 1/ Fs;
nbr_elts = length(y);
duree = (nbr_elts-1)*Ts;
t = 0:Ts:duree;
nbFenetre = 240;
tailleFenetre = nbr_elts / nbFenetre;
fft_y = [];
%puissSeuil = 0.5;                                   % on choisit la valeur arbitrairement pour chaque signal différent ( on estime la valeur la meilleure valeur à taton)

%----Calcul de la puissance moyenne du signal total------%
for i = 1:length(y)
  puissSeuil = puissSeuil + y(i);
end
puissSeuil = puissSeuil/length(y);


for n = 0:nbFenetre-1   
   extraitFenetre = y((n*tailleFenetre+1):((n+1)*tailleFenetre)); % fenêtres glissantes sans recouvrement
   puissFenetre = extraitFenetre.^2;                                     % vecteur des puissances instantanées pour la fenetre
   puissFenetreMoy = mean (puissFenetre);                          % puissance moyenne sur la fenetre
   
   if (puissFenetreMoy > puissSeuil)                                      % on ajoute seulement les fft qui ne sont pas considérées comme du bruit
     
       fft_extraitFenetre = abs(fft(extraitFenetre));
       fft_extraitFenetre(1)=0;                                                  % on enlève la première valeur car elle est toujours maximum sinon (on ne comprend pas pourquoi)
       [fft_max, idc_max] = max(fft_extraitFenetre);                % On détermine le maximum
       fft_freq = idc_max;                                                          % ainsi que son emplacements
       fft_y = [fft_y ; fft_freq];
   end
end
                               
bpm = 60*fft_y;
figure(1);
subplot(2,1,1);
plot(t, y);
xlabel('seconds');
ylabel('amplitude');
title('109.wav');
subplot(2,1,2);
plot (bpm);
xlabel('temps');
ylabel('bpm');

