# Compatibilité et pièges repérés

Les supports sont une source de méthode, pas une garantie que chaque ligne est une recette générale. Avant de reprendre un exemple :

- remplace `T`/`F` par `TRUE`/`FALSE` et les verbes superseded (`one_of`, `gather`, `spread`) selon la version du projet ; ne modernise pas un projet entier sans raison ;
- `case_when()` retient la première condition vraie dans l'ordre écrit ; teste les chevauchements et les `NA` ;
- distingue texte, classe `Date` et format d'affichage ;
- n'interprète pas une corrélation nulle comme une indépendance ;
- ne présente pas Wilcoxon comme un test générique de moyenne ; formule le paramètre de position et le plan ;
- ne force pas `var.equal = TRUE` sans justification ; calcule les effectifs et incertitudes par groupe ;
- ne convertis pas un `NA` en zéro sans signification métier ; distingue donnée inconnue, absence et zéro observé ;
- dans `sf`, `st_set_crs()` étiquette des coordonnées et `st_transform()` les transforme ; une jointure gauche conserve les zones sans correspondance ;
- documente les données distantes, les APIs, les systèmes de coordonnées, les millésimes du COG et les unités avant de lancer une recette.

Les exemples de ce skill privilégient des données synthétiques et hors ligne. Les extensions réseau sont des fiches conditionnelles.
