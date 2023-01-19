function [x, dx, nx, y, dy, ny, Mesh, XX, YY, z, dz, nz] = Maillage_de_la_geometrie(dim, Points, Lx, xMin, Ly, yMin, Lz, zMin)
%% D�finition du domaine de r�solution OMEGA %%
##    On d�fini une g�om�trie en sp�cifiant les coordon�es des angles de la pi�ce � dessiner.
##    (Peut-�tre pr�voire la possibilit� d'importer une g�om�trie et ou un maillage externe (ex: gmsh)).
##    La g�om�trie peut �tre 1D, 2D ou 3D. (Peut-�tre privil�gier les g�om�tries 2D aux 1D,...
##  pour une plus belle repr�sentation des r�sultats obtenus).
##    Une fois la g�om�trie d�finie, il faut appeler la fonction de maillage adapt�e (structur�,...
##  non structur�, MVF, MDF, MEF, ...) et choisire si le maillage de la g�ometrie sera de...
##  type D , D-1 ou D-2 (maillage 2D sur g�om�trie 2D ou maillage 1D sur g�om�trie 2D,...
##  idem pour g�om�trie 3D).

x = dx = nx = y = dy = ny = Mesh = XX = YY = z = dz = nz = 0;

switch dim
    case 1 %% Mod�le 1D %%
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
      
    case 2 %% Mod�le 2D %%
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

    case 3 %% Mod�le 3D %%
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