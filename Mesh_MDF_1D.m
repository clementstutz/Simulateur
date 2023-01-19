function [x, dx, nx] = Mesh_MDF_1D(Points, Lx, xMin)
%% Permet de d�finir le maillage rectengulaire d'une g�ometrie 2D pour appliquer une M�thode des Diff�rences Finis.

if length(Points) != 2
  disp('La g�om�trie utilis� n''est peut-�tre pas compatible avec cette fonction de maillage.')
  %endfunction
end

nx = input('Nb de points de calculs selon X : ');

dx = Lx/(nx-1);           % Taille de la maille selon X
x = 0:dx:Lx;  % Coordon�es sur X des noeuds

% Peut �tre plus facile de travailler avec [XX, YY] qu'avec Mesh directement...!!
% Je pourai aussi uniquement retourner xMin, yMin, nx, ny, dx et dy, �a utilise...
% moins de m�moire et c'est facile de reconstruire les noeuds avec.
##[XX, YY] = meshgrid (x, y);
##Mesh = [XX, YY];

figure(1)
title('Maillage g�om�trie 1D');
tic_plot = tic;
plot(x,0*x, '*k')
toc(tic_plot)

endfunction