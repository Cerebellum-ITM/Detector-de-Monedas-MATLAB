% Detección de una forma especifica en una imagen
% Clase Visión robótica
% Práctica #5 - Código de MATLAB
% Mc. Pascual Neftalí Chávez Campos

%% Configuración Inicial
clc; % Borra las entradas a la ventana de comandos
close all; % Cierra todas las ventanas o figuras
Fig = figure('Name', 'Deteccion de una forma especifica en una imagen');
set(Fig, 'Position', [0 0 800 800])
imagen_original = imread('img1.jpg');
subplot(2, 2, 1)
imshow(imagen_original);
%% Transformación a una imagen binaria
imagen = rgb2gray(imagen_original); % Conversión a escala de grises
subplot(2, 2, 2)
imshow(imagen);
umb = graythresh(imagen); % Umbral binario
bw = imbinarize(imagen, umb); % Imágen binaria
subplot(2, 2, 3)
imshow(bw);

%%  Identificación de objetos en la imagen
subplot(2, 2, 4)
imshow(imagen);
Objetos = bwlabel(bw); % Deteccion de objetos
imshow(label2rgb(Objetos)); % Se asigna un color a los objetos
Propiedades = regionprops(Objetos); % Se obtiene las propiedades de los objetos
% Ciclo para encerrar cada objeto en un cuadrado y dibujar una marca en el centro
hold on

for i = 1:length(Propiedades)
    Coordenadas = Propiedades(i).BoundingBox;
    Centro = Propiedades(i).Centroid;
    Area = Propiedades(i).Area;
    rectangle('Position', Coordenadas, ...
        'EdgeColor', 'r', 'LineWidth', 3)
    x = Centro(1);
    y = Centro(2);
    plot(x, y, '+k');
end

%% Recorte de objetos
% Ciclo para cortar cada objeto de la imagen original
figure('Name', 'Objetos recortados');

for i = 1:length(Propiedades)
    Coordenadas = Propiedades(i).BoundingBox;
    img_cortada = imcrop(imagen_original, Coordenadas);
    subplot(1, length(Propiedades), i);
    imshow(img_cortada)
end
