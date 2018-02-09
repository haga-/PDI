% Érick Moreira, Heitor Almeida, Matheus Neiverth
% Exercício 2

close all;
clear all;
clc;

pkg load image;

% Original image with noise
menino = imread('menino.gif');

%Determine good padding for Fourier transform
PQ = paddedsize(size(menino));

%Create Notch filters corresponding to extra peaks in the Fourier transform
H1 = notch('ideal', PQ(1), PQ(2), 15, 60, 30);
H2 = notch('ideal', PQ(1), PQ(2), 15, -60, -30);
H3 = notch('ideal', PQ(1), PQ(2), 15, -60, 30);
H4 = notch('ideal', PQ(1), PQ(2), 15, 60, -30);

% Calculate the discrete Fourier transform of the image
F = fft2(double(menino),PQ(1),PQ(2));

% Apply the notch filters to the Fourier spectrum of the image
FS_menino = F.*H1.*H2.*H3.*H4;

% convert the result to the spacial domain.
F_menino = real(ifft2(FS_menino));

% Crop the image to undo padding
F_menino = F_menino(1:size(menino,1), 1:size(menino,2));

% Display the Fourier Spectrum
% Move the origin of the transform to the center of the frequency rectangle.
Fc  = fftshift(F);
Fcf = fftshift(FS_menino);

% use abs to compute the magnitude and use log to brighten display
S1 = log(1+abs(Fc));
S2 = log(1+abs(Fcf));

%figure, imshow(S1, []);
%figure, imshow(S2, []);

% a)
subplot(2,3,1), imshow(menino), title('Imagem Original');
% b)
subplot(2,3,2), imshow(real(F)), title('Espectro Fourier');
% d)
subplot(2,3,3), imshow(real(F_menino), []), title('Resultado do Processamento');
% e)
subplot(2,3,4), imshow(S1, []), title('Domínio da frequência antes do filtro');
subplot(2,3,5), imshow(S2, []), title('Domínio da frequência depois do filtro');

