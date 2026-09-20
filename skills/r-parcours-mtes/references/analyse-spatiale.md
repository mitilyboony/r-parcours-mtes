# Analyse spatiale avec `sf`

Une couche `sf` est une table avec une colonne de géométries. Avant toute opération, vérifie le type, le CRS, les géométries vides ou invalides, la clé d'identification et les unités attendues.

```r
library(sf)
library(dplyr)

polygones <- st_read("donnees/zones.gpkg", quiet = TRUE)
points <- st_read("donnees/points.gpkg", quiet = TRUE)
stopifnot(!is.na(st_crs(polygones)), !is.na(st_crs(points)))
points <- st_transform(points, st_crs(polygones))

compte <- lengths(st_intersects(polygones, points))
polygones <- mutate(polygones, n_points = compte)
```

`st_set_crs()` déclare le CRS des coordonnées existantes ; `st_transform()` transforme les coordonnées. Ne remplace pas l'un par l'autre. Pour une distance, une aire ou un tampon, choisis un système et des unités adaptés au territoire. Ne force pas EPSG:2154 pour les DROM.

Une jointure spatiale gauche conserve les zones sans correspondance avec des attributs `NA`. Ainsi `length(SIREN)` peut valoir 1 pour une zone vide ; compte plutôt une liste de prédicats avec `lengths()`, ou un identifiant non manquant. Décide aussi comment traiter les points sur une frontière et les correspondances multiples.

Pour une carte, distingue effectif, taux et ratio de sommes. Conserve les zones sans observation, documente le dénominateur, les classes et la source. Les services BAN, OSM, WFS, OSRM et les cartes interactives sont des extensions réseau : leur disponibilité doit être vérifiée au moment de la demande.
