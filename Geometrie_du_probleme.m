function [dim, Points, Lx, xMin, Ly, yMin, Lz, zMin] = Geometrie_du_probleme()
%% Définition du domaine de résolution OMEGA %%
##    On défini une géométrie en spécifiant les coordonées des angles de la pièce à dessiner.
##    (Peut-être prévoire la possibilité d'importer une géométrie et ou un maillage externe (ex: gmsh)).
##    La géométrie peut être 1D, 2D ou 3D. (Peut-être privilégier les géométries 2D aux 1D,...
##  pour une plus belle représentation des résultats obtenus).
##    Une fois la géométrie définie, il faut appeler la fonction de maillage adaptée (structuré,...
##  non structuré, MVF, MDF, MEF, ...) et choisire si le maillage de la géometrie sera de...
##  type D , D-1 ou D-2 (maillage 2D sur géométrie 2D ou maillage 1D sur géométrie 2D,...
##  idem pour géométrie 3D).

dim = Points = Lx = xMin = Ly = yMin = Lz = zMin = 0;

dim = menu('Faites un choix', '1D', '2D', '3D', 'Sortir');
             
  switch dim
    case 1 %% Modèle 1D %%
      
      [Points, Lx, xMin] = DefGeometrie1D;
      
    case 2 %% Modèle 2D %%
      
      [Points, Lx, xMin, Ly, yMin] = DefGeometrie2D;

    case 3 %% Modèle 3D %%
      
      [Points, Lx, xMin, Ly, yMin, Lz, zMin] = DefGeometrie3D;
      
  end

endfunction