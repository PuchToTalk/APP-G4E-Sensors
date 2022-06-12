%{
// ---------------- DEBUT EN TETE --------------------------------------//
//                                                                      //
// AUTEURS : G8 : Albacete, Cohen, Kabbaj, Laurans, Margerard, Pinat    //                                     
//                                                                      //
// VERSION : 1.0 : G8 Janvier 2022                                        //
// Detection de la frequence cardiaque a partir d'un ECG, approche temporelle //
//                                                                      //
// HISTORIQUE : Aucun                                                   //
//                                                                      //
// ENTREES :                                                            //
// Fichier ECG .wav valeur du signal en milliwatts                    //
//                                                                      //
//                                                                      //
// SORTIES :                                                            //
// Un tableau des differentes frequence cardiaques mesure entre chaque  //
//pics avec une frequence minimale de 30bpm                             //
//                                                                      //
// MODIFIEES :                                                          //
//                                                                      //
// LOCALES :                                                            //
// n entier Indice de boucle sur le temps                               //
//                                                                      //
// FONCTIONS APPELEES : Audioread, length, disp, input, plot            //
//                                                                      //
// ALGO - REFERENCES :                                                  //
//                                                                      //
// ---------------- FIN EN TETE ----------------------------------------//
%}

%------------------------------Entrees------------------------------%
fichier = input('Choississez le fichier pour connaître sa fréquence (entre 0 et 10)'); 
if fichier == 0
        [y, Fe] = audioread('100.wav');
elseif fichier == 1
        [y, Fe] = audioread('101.wav');
elseif fichier == 2
        [y, Fe] = audioread('102.wav');
elseif fichier == 3
        [y, Fe] = audioread('103.wav');
elseif fichier == 4
        [y, Fe] = audioread('104.wav');
elseif fichier == 5
        [y, Fe] = audioread('105.wav');
elseif fichier == 6
        [y, Fe] = audioread('106.wav');
elseif fichier == 7
        [y, Fe] = audioread('107.wav');
elseif fichier == 8
        [y, Fe] = audioread('108.wav');
elseif fichier == 9
        [y, Fe] = audioread('109.wav');
elseif fichier == 10
        y = zeros(5000);
        Fe = 360;
end

%------------------------------Calcul------------------------------%
Te = 1/Fe;
N = length(y);
t = (0:Te:length(y)*Te);
temps2 = 0;
tableauFreq = [];

seuil = 0.9;
for n = 1:N
  if y(n) > seuil
    if ((y(n-1)<y(n)) && (y(n)>y(n+1)))
      temps1 = t(n);
      seuil = 0.98*y(n);
      if (temps1 > temps2 + Te/2)
        freq = (temps1-temps2)*60;
        if (freq > 30)
            tableauFreq(length(tableauFreq)+1)=freq;
            temps2 = temps1;
        end
      end
    end
  end
end
tableauFreq(1) = [];


%------------------------------Sorties------------------------------%
disp(tableauFreq)
plot(y);