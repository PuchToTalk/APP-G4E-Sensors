%clear all;

% RECUPERER LA 1e HARMONIQUE
%[signal,Fe] = audioread('Pi_C_96K.wav');
[signal,Fe] = audioread('Fl_A4_96K.wav');
signalFFT = abs(fft(signal));
tailleSignalFFT = size(signalFFT);
tailleSignalFFT = tailleSignalFFT(1);
seuil  = round(0.25 * max(signalFFT(2:tailleSignalFFT)));
i=2;

while (signalFFT(i)<seuil)
    i = i+1;
end

grosPic = signalFFT(i);
disp(i);

% EN FONCTION DE LA NOTE 

%Generer vecteurs tout tableau notes
i = 0;
listNotes = zeros(1,132);
for i = 0:1:132
    note = 16.35 * 2.^(i/12);
    listNotes(i+1) = note;
end

%Trouver la note

listNotesAbs = abs(listNotes - grosPic);
[valeurNote, indiceNoteGlobal] = min(listNotesAbs);

indiceNote = mod(indiceNoteGlobal,12);
indiceGamme = ((indiceNoteGlobal - indiceNote) / 12) - 1;

disp(indiceNote);
disp(indiceGamme);

% SOUS ECHANTILLONNER OU SUR ECHANTILLONNER


% 
if(indiceNote < 6)
    %sous echantillonne
    for i = 0:1:12
        newFe = Fe / (2.^(i/12));
        sound(signal, newFe);
        pause(1.5);
    end
else
    %sur echantillonne
    for i = 0:1:12
        newFe = Fe * (2.^(i/12));
        sound(signal, newFe);
        pause(1.5);
    end
end 