function [x, dx, nx, y, dy, ny, Mesh, XX, YY, z, dz, nz] = Maillage_de_la_geometrie(dim, Points, Lx, xMin, Ly, yMin, Lz, zMin)
%% Définition du domaine de résolution OMEGA %%
##    On défini une géométrie en spécifiant les coordonées des angles de la pièce à dessiner.
##    (Peut-être prévoire la possibilité d'importer une géométrie et ou un maillage externe (ex: gmsh)).
##    La géométrie peut être 1D, 2D ou 3D. (Peut-être privilégier les géométries 2D aux 1D,...
##  pour une plus belle représentation des résultats obtenus).
##    Une fois la géométrie définie, il faut appeler la fonction de maillage adaptée (structuré,...
##  non structuré, MVF, MDF, MEF, ...) et choisire si le maillage de la géometrie sera de...
##  type D , D-1 ou D-2 (maillage 2D sur géométrie 2D ou maillage 1D sur géométrie 2D,...
##  idem pour géométrie 3D).

x = dx = nx = y = dy = ny = Mesh = XX = YY = z = dz = nz = 0;

switch dim
    case 1 %% Modèle 1D %%
      typeMaillage = 1;
      while typeMaillage ~= 3
        typeMaillage = menu('Faites un choix', 'MDF_1D', 'MVF_1D', 'Sortir');
        switch typeMaillage
          case 1
            [x, dx, nx] = Mesh_MDF_1D(Points, Lx, xMin);
            
          case 2
            [x, dx, nx] = Mesh_MVF_1D(Points, Lx, xMin);
        end
      end
      
    case 2 %% Modèle 2D %%
      typeMaillage = 1;
      while typeMaillage ~= 5
      
        typeMaillage = menu('Faites un choix', 'MDF_1D', 'MVF_1D', 'MDF_2D', 'MVF_2D', 'Sortir');
        
        switch typeMaillage
          case 1
            [x, dx, nx] = Mesh_MDF_1D(Points, Lx, xMin);
            
          case 2
            [x, dx, nx] = Mesh_MVF_1D(Points, Lx, xMin);
            
          case 3
            [x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MDF_2D(Points, Lx, xMin, Ly, yMin);
            
          case 4
            [x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin);
        end
      end

    case 3 %% Modèle 3D %%
      typeMaillage = 1;
      while typeMaillage ~= 7
      
        typeMaillage = menu('Faites un choix', 'MDF_1D', 'MVF_1D', 'MDF_2D', 'MVF_2D', 'MDF_3D indisponible', 'MVF_3D indisponible', 'Sortir');
        
        switch typeMaillage
          case 1
            [x, dx, nx] = Mesh_MDF_1D(Points, Lx, xMin);
            
          case 2
            [x, dx, nx] = Mesh_MVF_1D(Points, Lx, xMin);
            
          case 3
            [x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MDF_2D(Points, Lx, xMin, Ly, yMin);
            
          case 4
            [x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin);
            
          case 5
            [x, dx, nx, y, dy, ny, Mesh, XX, YY, z, dz, nz] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin, Lz, zMin);
            
          case 6
            [x, dx, nx, y, dy, ny, Mesh, XX, YY, z, dz, nz] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin, Lz, zMin);
        end
      end
      
  end
endfunction