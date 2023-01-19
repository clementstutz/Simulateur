function [x, dx, nx] = Mesh_MVF_1D(Points, Lx, xMin)
%% Permet de définir le maillage rectengulaire d'une géometrie 2D pour appliquer une Méthode des Volumes Finis.

if length(Points) != 2
  disp('La géométrie utilisé n''est peut-être pas compatible avec cette fonction de maillage.')
  %endfunction
end

nx = input('Nb de volumes de contrôle selon X : ');

dx = Lx/nx;           % Taille de la maille selon X
x = dx/2:dx:Lx-dx/2;  % Coordonées sur X des noeuds

##x_p = x;
##x = zeros(length(x_p)+2,1);
##x(1) = xMin;
##for i = 1:length(x_p)
##  x(i+1) = x_p(i);
##endfor
##x(length(x)) = xMin+Lx;
##clear x_p;

% Peut être plus facile de travailler avec [XX, YY] qu'avec Mesh directement...!!
% Je pourai aussi uniquement retourner xMin, yMin, nx, ny, dx et dy, ça utilise...
% moins de mémoire et c'est facile de reconstruire les noeuds avec.
##[XX, YY] = meshgrid (x, y);
##Mesh = [XX, YY];

figure(1)
title('Maillage géométrie 1D');
tic_plot = tic;
plot(x,0*x, '*k')
toc(tic_plot)

endfunction