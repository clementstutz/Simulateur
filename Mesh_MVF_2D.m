function [x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin)
%% Permet de définir le maillage rectengulaire d'une géometrie 2D pour appliquer une Méthode des Volumes Finis.

if length(Points) != 5
  disp('La géométrie utilisé n''est peut-être pas compatible avec cette fonction de maillage.')
  %endfunction
end

nx = input('Nb de volumes de contrôle selon X : ');
ny = input('Nb de volumes de contrôle selon Y : ');

dx = Lx/nx; % Taille de la maille selon X
x = dx/2:dx:Lx-dx/2; % Coordonées sur X des noeuds

##x_p = x;
##x = zeros(length(x_p)+2,1);
##x(1) = xMin;
##for i = 1:length(x_p)
##  x(i+1) = x_p(i);
##endfor
##x(length(x)) = xMin+Lx;
##clear x_p;

dy = Ly/ny; % Taille de la maille selon Y
y = dy/2:dy:Ly-dy/2; % Coordonées sur Y des noeuds

##y_p = y;
##y = zeros(length(y_p)+2,1);
##y(1) = yMin;
##for i = 1:length(y_p)
##  y(i+1) = y_p(i);
##endfor
##y(length(y)) = yMin+Ly;
##clear y_p;

% Peut être plus facile de travailler avec [XX, YY] qu'avec Mesh directement...!!
% Je pourai aussi uniquement retourner xMin, yMin, nx, ny, dx et dy, ça utilise...
% moins de mémoire et c'est facile de reconstruire les noeuds avec.
[XX, YY] = meshgrid (x, y);
Mesh = [XX, YY];

figure(1)
title('Maillage géométrie 2D');
tic_plot = tic;
plot(XX,YY, '*k')
toc(tic_plot)

endfunction