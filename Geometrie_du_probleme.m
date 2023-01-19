function [dim, Points, Lx, xMin, Ly, yMin, Lz, zMin] = Geometrie_du_probleme()
%% D�finition du domaine de r�solution OMEGA %%
##    On d�fini une g�om�trie en sp�cifiant les coordon�es des angles de la pi�ce � dessiner.
##    (Peut-�tre pr�voire la possibilit� d'importer une g�om�trie et ou un maillage externe (ex: gmsh)).
##    La g�om�trie peut �tre 1D, 2D ou 3D. (Peut-�tre privil�gier les g�om�tries 2D aux 1D,...
##  pour une plus belle repr�sentation des r�sultats obtenus).
##    Une fois la g�om�trie d�finie, il faut appeler la fonction de maillage adapt�e (structur�,...
##  non structur�, MVF, MDF, MEF, ...) et choisire si le maillage de la g�ometrie sera de...
##  type D , D-1 ou D-2 (maillage 2D sur g�om�trie 2D ou maillage 1D sur g�om�trie 2D,...
##  idem pour g�om�trie 3D).

dim = Points = Lx = xMin = Ly = yMin = Lz = zMin = 0;

dim = menu('Faites un choix', '1D', '2D', '3D', 'Sortir');
             
  switch dim
    case 1 %% Mod�le 1D %%
      
      [Points, Lx, xMin] = DefGeometrie1D;
      
    case 2 %% Mod�le 2D %%
      
      [Points, Lx, xMin, Ly, yMin] = DefGeometrie2D;

    case 3 %% Mod�le 3D %%
      
      [Points, Lx, xMin, Ly, yMin, Lz, zMin] = DefGeometrie3D;
      
  end

endfunction