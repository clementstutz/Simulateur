%%  Définition du programme :

% Programme principal :
% choix :
% 1- Définir la géométrie du problème à traiter
% 2- Définir les conditions initiales et aux limites du problème
% 3- Résoudre le problème
% 4- Analyse des résultats
% 5- Affichage des résultats
% 6- Relancer une nouvelle simulation
% 7- Sortir

clear all;
close all;

choice = 1;
while choice ~= 0 && choice ~= 8
  
  choice = menu('Faites un choix',...
                'Expliquation du programme', 'Définir la géométrie', ...
                'Définir le maillage', 'Résolution du problème', ...
                'Analyse des résultats', 'Affichage des résultats',...
                'Relancer une nouvelle simulation', 'sortir du programme');
  
  switch choice
    case 1 % Expliquation du programme
      ExplainProgram;
      
    case 2 % Définir la géométrie
      [dim, Points, Lx, xMin, Ly, yMin, Lz, zMin] = Geometrie_du_probleme;
    
    case 3 % Définir le maillage
      [x, dx, nx, y, dy, ny, Mesh, XX, YY, z, dz, nz] = Maillage_de_la_geometrie(dim, Points, Lx, xMin, Ly, yMin, Lz, zMin);
      
    case 4 % Résolution du problème
      switch dim
        case 1 %% Modèle 1D %%
          choiceResol = 1;
          while choiceResol ~= 6
      
            choiceResol = menu('Faites un choix',...
            'Diffusion instationaire 1D',...
            'Diffusion stationaire 1D',...
            'Conductoconvection d''une ailette 1D',...
            'Diffusion stationaire MVF 1D',...
            'Diffusion instationaire MVF 1D',...
            'sortir du programme');
            
            switch choiceResol
              case 1
                Resultat = Resol_ConductionInstationnaire1D();
                
              case 2
                Resultat = Resol_Conduction1D();
                
              case 3
                Resultat = Resol_ConductoConvection1D();
                
              case 4
                Resol_Diffusion_MVF_1D(Points, Lx, xMin, x, dx, nx);
                
              case 5
                Resol_Diffusion_MVF_1D_instationnaire(Points, Lx, xMin, x, dx, nx);
            end
          end
          
        case 2 %% Modèle 2D %%
          choiceResol = 1;
          while choiceResol ~= 3
      
            choiceResol = menu('Faites un choix',...
            'Diffusion stationaire MVF 2D',...
            'Diffusion instationaire MVF 2D',...
            'sortir du programme');
            
            switch choiceResol
              case 1
                Resol_Diffusion_MVF_2D(Points, Lx, xMin, Ly, yMin, x, dx, nx, y, dy, ny, Mesh, XX, YY);
                
              case 2
                Resol_Diffusion_MVF_2D_instationnaire(Points, Lx, xMin, Ly, yMin, x, dx, nx, y, dy, ny, Mesh, XX, YY);
                
            end
          end
          
        case 3 %% Modèle 3D %%
          
##          [Points, Lx, xMin, Ly, yMin, Lz, zMin] = DefGeometrie3D;
          
      end

    case 5 % Analyse des résultats
      Analyse = Anatyse_resultats(resultat);
      
    case 6 % Affichage des résultats
      plotResultat(Analyse);
      
    case 7 % Relancer une nouvelle simulation
      reset;
      
  end
    
end
##clear all;
##close all;