function [Points, Lx, xMin] = DefGeometrie1D
%% Permet de définir une géométrie 2D simple à partir d'une série de points.

Npoints = 2; %input('Combien de points a la géométrie : ');

Points = zeros(Npoints, 1);

##for i = 1:Npoints
##  PointX = input(['Entrer la coordonée [X] du point n°' num2str(i) ' : ']);
##  PointY = input(['Entrer la coordonée [Y] du point n°' num2str(i) ' : ']);
##  Points(i, 1) = PointX;
##  Points(i, 2) = PointY;
##endfor

Points(1, 1)=0;
Points(2, 1)=3;

xMin = min(Points(:,1));
xMax = max(Points(:,1));

Lx = xMax - xMin;

figure(1)
hold on;
plot(x=Points(:),0*x, '+-b')
title('Géométrie 1D');
xlabel('X');
grid('on');
##xlim([xMin-Lx*0.05 xMax+Lx*0.05]);

endfunction