function [x, dx, nx] = Mesh_MDF_1D(Points, Lx, xMin)
%% Permet de définir le maillage rectengulaire d'une géometrie 2D pour appliquer une Méthode des Différences Finis.

if length(Points) != 2
  disp('La géométrie utilisé n''est peut-être pas compatible avec cette fonction de maillage.')
  %endfunction
end

nx = input('Nb de points de calculs selon X : ');

dx = Lx/(nx-1);           % Taille de la maille selon X
x = 0:dx:Lx;  % Coordonées sur X des noeuds

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