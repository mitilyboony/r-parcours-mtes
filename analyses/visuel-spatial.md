# Analyse des modules datavisualisation et analyse spatiale

Analyse statique du code et des supports, le 20 septembre 2026. Aucun package installé, aucune formation exécutée, aucun service métier appelé. Aucun `AGENTS.md` trouvé dans les dépôts étudiés. Les recommandations ci-dessous constituent un plan de contenu : elles ne sont pas encore un skill implémenté ou testé.

## Corpus et traçabilité

Les chemins cités sont relatifs à `sources/` ; les lignes se rapportent exactement aux révisions suivantes.

| Abréviation | Dépôt | SHA HEAD | Date du commit |
|---|---|---|---|
| V | `parcours_r_module_datavisualisation` | `809263de69693c891aa5c22fb3f58a96f7163afe` | 2026-06-03 |
| S | `parcours_r_module_analyse_spatiale` | `e3fddaabbbde98c065e67652fd51303826786018` | 2026-06-03 |

Ce sont des livres R Markdown/bookdown et leurs scripts, pas des packages applicatifs dont tous les exemples seraient autonomes. Les corrigés annoncés ne sont pas intégralement dans ces dépôts : V `16-exercices.Rmd:5` et S `99-exercices-corriges.Rmd:4` chargent des enfants avec `charge_exo()`. V `01b-get_started.Rmd:25` explique que les énoncés, corrigés et données sont dans **savoirfR** ; V `index.Rmd:84` récupère même une liste de données depuis ce package.

Complément inspecté : `sources-complementaires/savoirfR`, SHA `13377ca45486186266ab7f5fa9a3fb1a5223d826` (9 septembre 2026), répertoires `inst/vignettes/m5` et `m7`. Cette version est postérieure aux deux modules : ne pas supposer qu’elle correspond exactement à leurs corrigés lors de leur dernier build.

### Apport des corrigés savoirfR

- `inst/vignettes/m5/exo4.rmd:40` combine `fct_recode()`, indicatrice de région, `geom_col()`, facettes et échelle alpha : excellente recette condensée pour mettre une entité en évidence tout en comparant plusieurs indicateurs.
- `inst/vignettes/m5/exo5.rmd:33`, `m5/exo7.rmd:27` et `m5/exo8.rmd:31` confirment le passage vers cartes sf, infobulles et tableaux kable. Le tableau formate la septième ligne en dur : la recette réutilisable devra repérer la ligne de total selon les données.
- `inst/vignettes/m7/exo2.rmd:72` enchaîne jointure spatiale, retrait de géométrie, agrégations par quartier/type/année, pivot puis réintroduction de la géométrie : bon scénario intégrateur de validation. `prix_m2` est un ratio des sommes prix/surfaces, à distinguer explicitement d’une moyenne des prix au m² individuels ; contrôler les surfaces nulles et la granularité des ventes.
- `inst/vignettes/m7/exo4.rmd:75` et `:96` proposent agrégation, variation temporelle avec `lag()`, jointure aux fonds, puis fonction de zoom cartographique (`:140`). La version réutilisable doit trier explicitement les années et vérifier la période effectivement comparée ; le filtrage central de 98 % des observations est un choix analytique à justifier, pas une règle générale.
- `inst/vignettes/m7/exo5.rmd:33` superpose aplats d’évolution, symboles de volume et deux infobulles. Cette recette doit rester une extension facultative du cas statique.
- Le corrigé DVF repose sur une API externe et des fichiers locaux de secours. Ne pas reprendre ses URLs comme services garantis disponibles ; vérifier les sources au moment d’utiliser la recette. L’affectation `st_set_crs(..., 4326)` de `m7/exo2.rmd:49` ne doit être conservée qu’après vérification des coordonnées d’origine.

## Contenu réellement enseigné

### Visualisation : une grammaire à transformer en règles de choix

Le noyau est **ggplot2**, combiné à la préparation **dplyr**, avec `scales`, `viridis`, `cowplot`, `sf`, `ggspatial`. V `01b-get_started.Rmd:51` charge aussi de nombreux packages qui ne doivent pas devenir obligatoires pour chaque tâche.

| Technique observée | Source | Contenu utile au futur skill |
|---|---|---|
| Choix du graphique selon variables continues/discrètes | V `01-une-typologie-des-representations-graphiques.Rmd:9` | Petit arbre de décision avant le code |
| Données + mapping + couches | V `02-présentation-du-package-ggplot2.Rmd:26` | Construction explicite d’un objet graphique |
| Variable dans `aes()`, constante hors `aes()` | V `03-l-aesthetic.Rmd:25`, `:37`, `:45` | Éviter les légendes accidentelles et expliquer couleur versus remplissage |
| `geom_bar()` compte ; `geom_col()` représente une valeur déjà calculée | V `04-les-formes-geometriques.Rmd:26` | Règle essentielle ; ne pas recompter une table agrégée |
| Points, lignes, histogrammes, densité, boxplot | V `04-les-formes-geometriques.Rmd:14` | Recettes courtes adaptées au type des données |
| Titres, guides, thèmes, échelles logarithmiques et formatage | V `06-l-habillage-simple.Rmd:25`, `08-les-scales.Rmd:66`, `:124` | Distinguer données, encodage, unités, légendes et décoration |
| `facet_wrap()` et `cowplot::plot_grid()` | V `10-les-facettes.Rmd:26`, `09-la-mise-en-page-de-plusieurs-graphiques.Rmd:28` | Comparer plusieurs périodes ou assembler des graphiques |
| Export de l’objet explicitement nommé | V `11-sauvegarder-un-graphique.Rmd:28` | Recette `ggsave()` avec chemin et dimensions explicites |
| Cartes choroplèthes et symboles proportionnels | V `12-créer-des-cartes-avec-ggplot2.Rmd:29`, `:56` | `geom_sf()`, `stat_sf_coordinates()`, `scale_size_area()` |
| Animation et HTML | V `12b-graphiques-animés.Rmd:39`, `13-créer-des-graphiques-et-cartes-pour-le-web.Rmd:35`, `:51`, `:251` | Extensions optionnelles `gganimate`, `ggiraph`, `leaflet`, `htmlwidgets` |
| Tableaux de restitution | V `14-créer-des-tableaux-avec-kable.Rmd:21`, `:62` | Référence courte `knitr::kable()` + `kableExtra`, sans confondre avec analyse des données |

Les thèmes institutionnels `gouvdown`, ses polices et `hrbrthemes` sont des exemples présents dans V `07-les-themes.Rmd:158` et `:198`. Les conserver comme options de rendu, pas comme prérequis universels. `highcharter` et `apexcharter` figurent dans les dépendances ; leur simple présence ne justifie pas d’imposer ces bibliothèques au noyau.

### Spatial : sf avant les extensions métier

S `02-modelisation.Rmd:68` distingue **sfg** (géométrie), **sfc** (colonne de géométries), **sf** (table avec géométrie). Cette distinction éclaire les opérations sans nécessiter de recopier tout le cours.

| Technique observée | Source S | Règle à conserver |
|---|---|---|
| Entrées/sorties vecteur GeoPackage, GeoJSON, WFS, PostGIS | `04-lire-des-donnees-spatiales.Rmd:28`, `:61`, `:159`, `:206` | `st_read()`/`st_write()` avec source et couche identifiées ; options réseau séparées |
| Coordonnées tabulaires vers `sf` | `04-lire-des-donnees-spatiales.Rmd:256` | Déclarer noms, ordre des coordonnées et CRS d’origine |
| Géométrie conservée par les verbes dplyr | `05-operation-sur-donnees-attributaires.Rmd:49` | Utiliser `st_drop_geometry()` quand on veut seulement les attributs |
| Agrégation et jointure attributaire | `05-operation-sur-donnees-attributaires.Rmd:59`, `:77` | `summarise()` dissout aussi les géométries ; joindre une table attributaire à la couche de gauche |
| Filtrage et prédicats | `06-les-operations-sur-donnees-spatiales.Rmd:58`, `:184` | Choisir explicitement inclusion, intersection, contact ou distance selon la question |
| Jointure spatiale, appariements multiples | `06-les-operations-sur-donnees-spatiales.Rmd:283`, `:303`, `:324` | CRS compatibles ; décider si les correspondances multiples sont voulues ou si `largest=TRUE` a un sens métier |
| Aires et distances avec unités | `06-les-operations-sur-donnees-spatiales.Rmd:350`, `:362`, `:375` | Vérifier unités et taille attendue du résultat ; distinguer matrice complète et `by_element=TRUE` |
| Grilles et comptage de points | `06-les-operations-sur-donnees-spatiales.Rmd:439`, `:465`, `:483` | Conserver les cellules vides et expliciter les points sur frontières |
| Simplification | `07-operations-geometriques.Rmd:25`, `:76`, `:106` | Choisir tolérance et méthode selon l’échelle ; vérifier les frontières communes |
| Centroïde / point sur surface | `07-operations-geometriques.Rmd:132`, `:151` | Choisir le point adapté à l’usage cartographique |
| Buffer, intersection, différence, union | `07-operations-geometriques.Rmd:171`, `:250`, `:265`, `:299` | Expliciter distances, unités, pertes et agrégation des attributs |
| Assignation du CRS et transformation | `08-les-reprojections.Rmd:25`, `:53` | `st_set_crs()` décrit des coordonnées ; `st_transform()` les transforme |

La cartographie utilise ggplot2, mais aussi **tmap** : S `15-creer-des-cartes-avec-tmap.Rmd:90` et `:124` contiennent `tm_options()`, `tm_polygons(fill=...)`, `tm_scale_intervals()`. Ne pas qualifier globalement le dépôt d’ancien : certaines recettes tmap ont été actualisées. **mapview** sert souvent à l’exploration. Géocodage (`banR`, score du résultat), OSM (`osmdata`, `osmextract`), routage (`osrm`) et cartogrammes constituent des références avancées distinctes : S `09-geocodage.Rmd:33`, `:45` ; `13-osm.Rmd:103`, `:158`, `:191` ; `11-cartogramm.Rmd:14`.

## Corrections et vérifications à prévoir avant l’écriture du skill

1. **Comptage des cellules vides.** S `06-les-operations-sur-donnees-spatiales.Rmd:492` fait `st_join()` puis `length(SIREN)`. Une jointure gauche conservant une ligne sans point produit un `NA`, dont la longueur vaut 1. Privilégier la recette déjà présente `map_dbl(st_intersects(...), length)` ou compter explicitement les identifiants non manquants, avec une convention sur leur validité. Ajouter un exemple contenant une cellule vide.
2. **Frontières et buffers.** Le retrait arbitraire de 1 à 3 km est un dispositif pédagogique pour certains découpages (S `06-les-operations-sur-donnees-spatiales.Rmd:303`). Ne pas le transformer en réglage par défaut : décider du prédicat et de la règle d’attribution selon le besoin.
3. **CRS et précision.** Le cours présente certains résultats projetés comme « plus précis ». Ne pas en déduire que toute mesure en coordonnées géographiques est fausse : la future rédaction doit vérifier la documentation de `sf` sur GEOS/S2 et choisir une méthode adaptée au territoire, aux unités et à la précision recherchée. Ne pas appliquer EPSG:2154 aux DROM par automatisme ; le cours les distingue dans `08-les-reprojections.Rmd`.
4. **Filtres matriciels.** `filter(st_within(..., sparse=FALSE))` apparaît à S `06-les-operations-sur-donnees-spatiales.Rmd:62`. Pour une recette générale à plusieurs polygones, préférer le `st_filter()` déjà enseigné ; vérifier la compatibilité de la syntaxe matricielle avec la version ciblée de dplyr.
5. **Fonctions nommées dans le texte.** Le texte emploie parfois `st_intersect` ou `st_nearest_point`, alors que le code utilise `st_intersects` et `st_nearest_points`. Extraire les noms depuis le code vérifié.
6. **Graphiques.** Les échelles logarithmiques nécessitent une règle sur zéros, valeurs négatives et manquantes ; les limites d’échelle de V `08-les-scales.Rmd:78` doivent être distinguées d’un zoom visuel. Vérifier les arguments de style contre la version cible de ggplot2 au moment de l’implémentation.
7. **Services et dépendances.** Les installations GitHub/GitLab, APIs BAN/OSM/OSRM, polices et sources distantes ne doivent pas être exécutées par simple chargement du skill. Vérifier les API et dépendances disponibles lors d’une tâche qui en a besoin ; exemples d’apprentissage et validation par défaut hors ligne.

Ces points sont une revue statique et des hypothèses de compatibilité à vérifier, pas une certification d’exécution avec les versions actuelles.

## Proposition d’organisation à intégrer au plan global

- **Noyau SKILL.md** : routage selon question analytique, types des données, sortie attendue ; préparation avant visualisation ; contrôle des unités/CRS pour les tâches spatiales ; lecture ciblée des références.
- **`references/datavisualisation.md`** : choix des geoms, `aes()`/constantes, échelles et légendes, facettes, assemblage, export. Environ six recettes autonomes avec données petites et explicites.
- **`references/spatial-sf.md`** : import local, structure sf, CRS, attributs, prédicats, jointures, mesures, géométries ; exemples à partir de polygones et points synthétiques.
- **`references/cartographie.md`** : choroplèthe, symboles proportionnels, choix des unités et des classes, habillage, export ; ggplot2 comme chemin commun, tmap comme option documentée.
- **`references/visualisation-interactive.md`** : ggiraph/leaflet/htmlwidgets ; animation séparée dans cette référence ou un appendice. Charger seulement si la sortie le nécessite.
- **`references/spatial-services.md`** : BAN, WFS/PostGIS, OSM et OSRM, uniquement à la demande ; traçabilité des sources, contrôles du géocodage et cache adapté.
- **`references/sources.md`** : SHA, licences, chapitre/ligne, origine pédagogique et modification éventuelle de chaque recette.

Ne pas tout charger dans le skill principal. Ne pas inclure systématiquement les thèmes ministériels, données volumineuses, rendus de livres ou infrastructures Docker.

## Scénarios de validation proposés

| Demande de test | Critères observables |
|---|---|
| « Compare ces effectifs déjà calculés » | `geom_col()` ; aucune seconde agrégation accidentelle ; axe/unité et titre explicites |
| « Montre une relation entre deux quantités par groupe » | Mapping de groupe dans `aes()` ; constantes hors mapping ; gestion documentée des valeurs non positives si log |
| « Compare plusieurs années et exporte » | Facettes comparables ; objet nommé ; export avec dimensions explicites ; fichier produit |
| « Joins des indicateurs à une carte » | Clés contrôlées, géométrie conservée, lignes sans correspondance détectées |
| « Compte des points dans des mailles » | Maille vide = 0, point hors emprise traité, frontière documentée ; total expliqué |
| « Affecte des points à des polygones » | CRS incompatibles corrigés par transformation ; correspondances multiples et absences visibles |
| « Calcule un tampon métrique » | CRS/moteur et unités explicités ; ordre longitude/latitude juste ; aucune simple réassignation de CRS pour reprojeter |
| « Fais une carte des DROM » | Projection choisie pour le territoire ; aucun Lambert 93 métropolitain imposé |
| « Simplifie une couche » | Vérification de géométries et frontières ; tolérance justifiée par l’échelle |
| « Ajoute une carte interactive » | Dépendances facultatives ; contrôle de l’export HTML ; aucune installation ou requête réseau cachée |

Les contrôles de géométrie (`st_is_valid()`, géométries vides), d’unicité des clés et de dimensions sont des renforcements proposés pour fiabiliser les recettes, à distinguer explicitement du contenu déjà présent dans les formations.

## Licences et réutilisation

- **Datavisualisation** : V `DESCRIPTION:11` déclare `LICENCE OUVERTE/ OPEN LICENCE Version 2.0`. Aucun fichier de licence séparé trouvé par l’inventaire.
- **Spatial** : S `LICENCE:1` annonce la Licence Ouverte ; S `14-a-propos.Rmd:23` mentionne explicitement la version 2.0 ; mais S `DESCRIPTION:6` déclare **MIT**. Consigner cette incohérence ; ne pas présenter les deux dépôts comme uniformément MIT.
- Préférer une synthèse originale avec attribution aux formations et liens permanents aux commits. Avant redistribution substantielle de code, données ou médias, vérifier la portée des licences concernées et résoudre les ambiguïtés utiles ; ne pas redistribuer automatiquement les fichiers `extdata`, fonds OSM, images ou polices sous la seule licence supposée du futur skill.

L’audit constate les déclarations du dépôt ; il ne tranche pas leur interprétation juridique.
