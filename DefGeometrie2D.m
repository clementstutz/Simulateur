function [Points, Lx, xMin, Ly, yMin] = DefGeometrie2D
%% Permet de définir une géométrie 2D simple à partir d'une série de points.

Npoints = 4; %input('Combien de points a la géométrie : ');

Points = zeros(Npoints+1, 2);

##for i = 1:Npoints
##  PointX = input(['Entrer la coordonée [X] du point n°' num2str(i) ' : ']);
##  PointY = input(['Entrer la coordonée [Y] du point n°' num2str(i) ' : ']);
##  Points(i, 1) = PointX;
##  Points(i, 2) = PointY;
##endfor

Points(1, :) = [0,0];
Points(2, :) = [1,0];
Points(3, :) = [1,1];
Points(4, :) = [0,1];
Points(Npoints+1, :) = Points(1, :);

xMin = min(Points(:,1));
xMax = max(Points(:,1));

yMin = min(Points(:,2));
yMax = max(Points(:,2));

Lx = xMax - xMin;
Ly = yMax - yMin;

figure(1)
hold on;
grid('on');
plot(Points(:,1), Points(:,2), '+-b')
title('Géométrie 2D');
xlabel('X');
xlim([xMin-Lx*0.05 xMax+Lx*0.05]);
ylabel('Y');
ylim([yMin-Ly*0.05 yMax+Ly*0.05]);

endfunction