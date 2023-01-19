function [x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MDF_2D(Points, Lx, xMin, Ly, yMin)
%% Permet de définir le maillage rectengulaire d'une géometrie 2D pour appliquer une Méthode des Différences Finis.

if length(Points) != 5
  disp('La géométrie utilisé n''est peut-être pas compatible avec cette fonction de maillage.')
  %endfunction
end

nx = input('Nb de points de calculs selon X : ');
ny = input('Nb de points de calculs selon Y : ');

dx = Lx/nx; % Taille de la maille selon X
x = 0:dx:Lx; % Coordonées sur X des noeuds

dy = Ly/ny; % Taille de la maille selon Y
y = 0:dy:Ly; % Coordonées sur Y des noeuds

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