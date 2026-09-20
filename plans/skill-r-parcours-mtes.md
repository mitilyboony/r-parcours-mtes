# Plan de création du skill `r-parcours-mtes`

Date : 20 septembre 2026. Statut : étude réalisée ; plan proposé ; skill non créé.

## Proposition

Créer **un skill de codage et d'analyse de données en R**, en français, fondé sur les six modules du parcours MTES-MCT. Un point d'entrée court sélectionnera les fiches utiles à la demande : préparation des données, statistiques, analyses multivariées, graphiques ou analyse spatiale.

Le résultat attendu est du code adapté aux données de l'utilisateur, accompagné des contrôles qui permettent d'en vérifier le sens. Les supports serviront à transmettre des méthodes et des critères de choix ; le skill ne sera pas une copie des cours ni un mécanisme de reconstruction de leurs sites.

Le périmètre couvre les scripts d'analyse et leurs blocs R dans des documents existants. La construction de packages, d'applications Shiny et de systèmes de déploiement reste en dehors du périmètre. Les méthodes statistiques non traitées dans les formations ne seront pas présentées comme issues de celles-ci.

## Corpus étudié et traçabilité

Les six dépôts demandés sont clonés avec leur historique dans `sources/`, sans modification de leurs fichiers. Ils contiennent au total 345 fichiers suivis, dont 75 fichiers R Markdown et 15 fichiers R. L'essentiel du code pédagogique se trouve donc dans les chunks R des `.Rmd`.

| Module | Dépôt | Commit étudié |
|---|---|---|
| Introduction | `parcours_r_socle_introduction` | `42b7cc87636af83b0a48eb1867b98fbf24977bab` |
| Préparation des données | `parcours_r_socle_preparation_des_donnees` | `5c9c8513d4451409d3ccd8783cf97aeb940cb7c0` |
| Statistiques descriptives | `parcours_r_module_statistiques_descriptives` | `735544c0d6856efcfc1aef0c4ea5e149b2ac36b7` |
| Analyse multidimensionnelle | `parcours_r_module_analyse_multi_dimensionnelles` | `faa194c7f063d16f6cb069d13357905a4ede875b` |
| Datavisualisation | `parcours_r_module_datavisualisation` | `809263de69693c891aa5c22fb3f58a96f7163afe` |
| Analyse spatiale | `parcours_r_module_analyse_spatiale` | `e3fddaabbbde98c065e67652fd51303826786018` |

Les métadonnées complètes figurent dans `analyses/depot-inventaire.json`.

Deux dépôts complémentaires ont été clonés dans `sources-complementaires/` parce que les modules y puisent leur contenu :

- `savoirfR`, commit `13377ca45486186266ab7f5fa9a3fb1a5223d826` : exercices et corrigés appelés par `savoirfR::charge_exo()`, en particulier `inst/vignettes/m1`, `m2`, `m5` et `m7`.
- `parcours-r`, commit `b53b22f75b8a35a5229be66ecdbc5154e3c0d9b9` : chapitres communs sur les projets et l'environnement de travail.

Ces compléments sont plus récents que les commits des six modules, tous datés du 3 juin 2026. Leur analyse complète le corpus sans prétendre reconstituer exactement la version historique de chaque site. Voir `analyses/dependances-inventaire.json`.

Trois analyses spécialisées documentent les sources, les décisions proposées et les réserves : `analyses/socle.md`, `analyses/statistiques.md` et `analyses/visuel-spatial.md`.

## Ce que le skill doit transmettre

| Domaine | Techniques tirées du corpus | Décisions à faire prendre au skill |
|---|---|---|
| Organisation et import | Projet RStudio, chemins relatifs, `renv`, CSV/Excel, types, encodage, séparateurs, export | Examiner les données et le projet avant de choisir un import ; conserver les identifiants comme chaînes ; respecter l'environnement existant. |
| Fondations R | Vecteurs, listes, indexation, fonctions, conditions, boucles et famille `apply` | Choisir des objets et opérations adaptés ; écrire des fonctions réutilisables lorsque le traitement le justifie. |
| Préparation | `dplyr`, `tidyr`, `across()`, `where()`, `if_any()`, regroupements, pivots, jointures, chaînes, facteurs, dates | Définir l'unité d'observation, les clés, les unités et le traitement des valeurs manquantes ; contrôler les effets des jointures et du regroupement. |
| Calculs ordonnés | `arrange()`, `lag()`, `lead()`, cumuls et fenêtres glissantes | Trier et regrouper avant de calculer une évolution ; distinguer l'observation précédente de la période calendaire précédente. |
| Référentiels territoriaux | Millésimes du COG, outils `COGiter`, chaînes de traitement Sitadel/MAJIC | Vérifier la comparabilité des périmètres, les scissions et les unités ; distinguer un ratio de sommes d'une moyenne de ratios. |
| Statistiques descriptives | Fréquences, quantiles, dispersion, tableaux croisés, corrélations, pondérations | Distinguer une moyenne de territoires d'une moyenne pondérée par leur population ; rendre explicites les dénominateurs et effectifs utilisables. |
| Tests et interprétation | Tests de moyenne, rangs, association, ANOVA et comparaisons | Choisir selon la question, le plan d'observation et les hypothèses ; ne pas sélectionner mécaniquement un test à partir de la seule normalité. |
| Analyses multivariées | `FactoMineR`, `factoextra`, ACP, AFC, ACM, CAH/HCPC et k-means | Choisir selon le type de tableau ; séparer variables actives et supplémentaires ; justifier mise à l'échelle, axes et nombre de classes. |
| Graphiques et tableaux | Grammaire `ggplot2`, mappings, géométries, échelles, facettes, thèmes, export, `cowplot`, `kableExtra` | Adapter représentation et agrégation à la question ; donner les unités, la source et la signification des couleurs ; vérifier le rendu final. |
| Spatial | `sf`, import/export, attributs et géométries, CRS, prédicats, jointures, intersections, distances, surfaces et cartes | Vérifier CRS et unités, choisir le prédicat spatial, expliciter le traitement des frontières et conserver les zones sans observation. |
| Extensions conditionnelles | `ggiraph`, `leaflet`, `gganimate`, `tmap`, `mapview`, SQL/API, Parquet et services géographiques présents dans les supports | Ne charger ces recettes et leurs dépendances que si la demande les nécessite ; distinguer données locales et accès à un service externe. |

La préférence pédagogique du corpus est le tidyverse. Le skill devra néanmoins conserver les choix explicites de l'utilisateur et les conventions cohérentes d'un projet existant. La présence de `%>%` dans les supports ne justifie pas de convertir tout un projet utilisant `|>`, ni l'inverse.

## Structure proposée

```text
skills/r-parcours-mtes/
  SKILL.md
  agents/openai.yaml
  references/
    workflow-import-export.md
    preparation-donnees.md
    statistiques-descriptives.md
    tests-statistiques.md
    analyses-multivariees.md
    datavisualisation.md
    analyse-spatiale.md
    compatibilite-et-pieges.md
    sources.md

evaluations/r-parcours-mtes/
  scenarios.md
  fixtures/
  resultats.md
```

`SKILL.md` contiendra le champ d'application, le choix des fiches, les quelques contrôles transversaux et les attentes sur le résultat. Les détails et exemples resteront dans les références. Une simple demande de nettoyage de CSV ne doit pas charger les chapitres d'ACP ou de géométrie spatiale.

Chaque fiche contiendra : quand l'utiliser, comment choisir la méthode, un petit nombre d'exemples autonomes, les contrôles essentiels et les sources exactes. Les exemples utiliseront des données synthétiques ou embarquées de petite taille. Aucun script utilitaire, modèle de projet ou dossier d'assets ne sera ajouté sans besoin réutilisable identifié.

Les sections import avancé, séries et territoires, interactivité et services spatiaux pourront devenir des fiches séparées si leur volume le justifie. `factoextra` est annoncé et chargé dans le corpus, mais les exemples multivariés utilisent surtout les méthodes graphiques de `FactoMineR` : ne pas attribuer au cours des recettes qui n'y sont pas développées.

Le skill sera autonome une fois rédigé : il n'aura pas besoin des clones locaux, de `savoirfR`, d'un accès à GitHub ou d'autres skills pour appliquer ses méthodes. Les dépôts resteront des sources d'étude et de traçabilité.

## Corrections et adaptations nécessaires

Il faut distinguer trois cas : une méthode effectivement enseignée, une correction d'erreur et une adaptation à l'API disponible. Ces distinctions seront conservées dans les références.

| Observation vérifiée | Traitement prévu |
|---|---|
| Le module spatial compte avec `length(SIREN)` après une jointure gauche ; une zone sans point conserve une ligne contenant `NA`. | Compter les correspondances géométriques, par exemple avec la longueur des listes de prédicats, ou un marqueur non manquant ajouté aux points avant jointure. Tester les zones vides et les frontières. |
| Le graphique d'intervalles du module descriptif emploie `nrow(data_test_m)` avant le regroupement par département. | Calculer l'effectif non manquant par groupe ; choisir ensuite un intervalle cohérent avec les hypothèses. Ne pas confondre écart-type, erreur-type et intervalle. |
| Certaines explications assimilent corrélation nulle et indépendance, ou proposent Wilcoxon comme remplacement d'un test de moyenne. | Corriger les interprétations ; expliciter le paramètre réellement testé et les limites de la conclusion. |
| Des exemples utilisent `na.omit()` ou remplacent des manquants par zéro sans généralisation possible. | Définir une politique par variable et analyse ; tracer les observations écartées ; réserver zéro aux absences effectivement connues. |
| Des jointures ont des clés implicites et les exemples ne contrôlent pas toujours leur multiplicité. | Définir les clés, diagnostiquer les doublons et orphelins ; utiliser les contrôles de cardinalité disponibles dans la version de `dplyr` du projet. |
| Le texte inverse l'ordre d'évaluation de `case_when()` ; un exercice MAJIC compare un pourcentage à un seuil présenté en m². | Corriger la priorité des conditions et vérifier les unités avant toute transposition ; ne pas généraliser le seuil métier de cet exercice. |
| Des corrigés dépendent d'objets préparés dans une séance précédente ou de chemins propres à un poste. | Réécrire les recettes pour qu'elles soient exécutables dans une session propre avec leurs seules entrées déclarées. |
| Le corpus mêle fonctions récentes et syntaxes dont le statut doit être vérifié. | Ne pas appliquer une modernisation globale. Vérifier la documentation officielle pour les fonctions reprises et conserver la compatibilité du projet. |

Deux preuves précises : [comptage spatial, lignes 489–494](https://github.com/MTES-MCT/parcours_r_module_analyse_spatiale/blob/e3fddaabbbde98c065e67652fd51303826786018/06-les-operations-sur-donnees-spatiales.Rmd#L489-L494) et [intervalle par groupe, lignes 317–323](https://github.com/MTES-MCT/parcours_r_module_statistiques_descriptives/blob/735544c0d6856efcfc1aef0c4ea5e149b2ac36b7/08-tests.Rmd#L317-L323).

La documentation officielle confirme que les non-correspondances d'une jointure spatiale gauche reçoivent des valeurs manquantes, et décrit les contrôles de cardinalité des jointures tabulaires : [sf — st_join](https://r-spatial.github.io/sf/reference/st_join.html), [dplyr — mutating joins](https://dplyr.tidyverse.org/reference/mutate-joins.html). Les hypothèses de Wilcoxon doivent être formulées selon sa documentation, sans l'assimiler à une différence de moyennes : [R — wilcox.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html).

## Étapes de réalisation

### 1. Transformer l'étude en spécification traçable

Reprendre les trois analyses et établir pour chaque recette la chaîne « besoin utilisateur → technique → source → contrôles → cas de validation ». Classer les dépendances entre analyse, publication des supports et services externes.

Livrable : matrice de couverture et `references/sources.md`. Chaque méthode retenue a une origine vérifiable ; chaque correction est explicitement distinguée du cours.

### 2. Construire le socle utilisable

Rédiger `SKILL.md`, ses métadonnées et les fiches workflow/import/export et préparation. Priorité aux identifiants, valeurs manquantes, regroupements, pivots, jointures et séries ordonnées. Définir une sélection précise du skill qui complète les autres compétences R déjà disponibles.

Livrable : première version applicable de bout en bout à un CSV imparfait et à une table d'enrichissement, avec export vérifiable.

### 3. Ajouter statistiques et analyses multivariées

Rédiger les fiches descriptives, tests et analyses multivariées, avec arbre de décision fondé sur la question et les données. Intégrer les corrections relevées. Produire des exemples indépendants de `COGiter` et des jeux téléchargés par les formations.

Livrable : recettes allant de la préparation à l'interprétation, sans choix arbitraire d'une méthode ou d'un nombre de classes.

### 4. Ajouter visualisation et spatial

Rédiger les recettes `ggplot2` et `sf`, puis les extensions interactives réellement utiles. Faire de la cartographie une application des choix statistiques et géométriques : taux versus effectifs, unités, CRS, données manquantes, légendes et export.

Livrable : graphique et carte reproductibles sur données locales, plus indications conditionnelles pour interactivité et services distants.

### 5. Vérifier le comportement réel du skill

Valider le format avec l'outil du skill-creator, puis exécuter les exemples retenus avec les dépendances nécessaires dans une bibliothèque adaptée au projet. Ne pas installer l'ensemble des dépendances de publication des six livres.

Confier à des sous-agents des demandes réalistes avec le skill et les seules données nécessaires, sans leur fournir la solution attendue. Évaluer leurs résultats avec les critères ci-dessous. Corriger uniquement les défauts effectivement observés.

Livrable : résultats des scénarios, versions de R/packages, limites connues, liens des références vérifiés et exemples exécutés.

### 6. Préparer la livraison

Vérifier que le dossier du skill ne dépend d'aucun chemin local à cette étude. Conserver les attributions et les sources des adaptations. Préparer le dossier installable ; l'installation dans le répertoire personnel des skills sera une étape distincte de la rédaction dans cet espace de travail.

Livrable : skill autonome, métadonnées cohérentes et bilan de validation. Cette phase ne nécessite pas de modifier les dépôts d'origine.

## Scénarios de validation proposés

| Demande réaliste | Critères observables |
|---|---|
| Importer un CSV français avec identifiants `01001` et `2A004`, virgules décimales et cases vides. | Identifiants conservés, types vérifiés, manquants identifiés ; export relisible sans altération. |
| Résumer des mesures par territoire, avec un groupe entièrement manquant. | Effectifs valides et manquants explicites ; absence d'interprétation automatique des manquants comme zéro. |
| Enrichir une table avec un référentiel contenant une clé dupliquée et une clé absente. | Multiplication des lignes détectée ; stratégie explicite ; orphelins identifiés. |
| Passer du format long au format large avec des clés répétées. | Duplications expliquées ; agrégation justifiée ou correction des clés ; pas de liste-colonne accidentelle ignorée. |
| Calculer des évolutions sur des années désordonnées dont une manque. | Tri et groupes corrects ; distinction entre année précédente et observation précédente. |
| Comparer des indicateurs communaux sur deux millésimes du COG. | Périmètres harmonisés ou différences signalées ; taux recalculés à partir des grandeurs nécessaires, sans somme de taux. |
| Comparer moyenne par commune et moyenne pondérée par population. | Deux quantités clairement distinguées ; poids et dénominateurs corrects. |
| Produire un graphique de moyennes avec intervalles pour des groupes d'effectifs différents. | Effectifs non manquants propres à chaque groupe ; intervalle et hypothèses explicités. |
| Comparer deux groupes dont les distributions ne sont pas normales. | Question et plan d'observation considérés ; pas de traduction automatique « non-normal → test de moyenne Wilcoxon ». |
| Réaliser une ACP avec identifiant, variable constante et variables d'échelles différentes. | Identifiant écarté des variables actives ; constante traitée ; mise à l'échelle motivée ; contribution et cos² distingués. |
| Choisir entre AFC et ACM, puis proposer une classification. | Nature du tableau contrôlée ; manquants et marges nulles traités ; axes/classes et éventuel aléa justifiés. |
| Produire un graphique à partir de valeurs déjà agrégées. | Géométrie appropriée, mapping correct, ordre des catégories, unités et export lisible. |
| Compter des points dans des polygones avec une zone vide et un point sur une frontière. | Zone vide à zéro ; convention de frontière explicite ; total et doublons expliqués. |
| Calculer une distance et dessiner une carte à partir de couches de CRS différents. | CRS réconciliés, unités et méthode de mesure cohérentes ; légende et rendu vérifiés. |
| Demander une application Shiny ou une migration complète de document. | Le skill ne substitue pas son périmètre d'analyse au travail demandé. |

Chaque scénario vérifiera la justesse des résultats et des décisions, sans exiger un texte ou une chaîne de fonctions identiques à une solution de référence. Les exemples courants doivent fonctionner sans réseau ; les scénarios de services externes resteront séparés.

## Provenance et état de validation

Les champs `DESCRIPTION` déclarent MIT pour M1, M3, M4 et M7, et Licence Ouverte 2.0 pour M2 et M5. Dans M7, `LICENCE` et le chapitre « À propos » indiquent Licence Ouverte, ce qui diverge du `DESCRIPTION`. Le complément `savoirfR` déclare GPL-3. Ces mentions doivent rester distinctes ; aucune licence unique ne sera présumée pour l'ensemble du corpus. Préférer des synthèses et exemples nouveaux, sourcés, et clarifier les mentions divergentes avant une diffusion comportant des reprises substantielles.

Vérifications déjà effectuées : clonage des huit dépôts et état propre ; enregistrement des commits ; lecture des sources et corrigés concernés ; consultation ciblée de documentations officielles ; trois contre-exemples exécutés en R de base. Ces derniers confirment qu'une corrélation peut être nulle malgré une dépendance déterministe, que `length(NA)` vaut 1 et qu'un effectif global réduit artificiellement la largeur d'un intervalle calculé pour un sous-groupe.

R 4.6.0 est accessible. Dans la session `Rscript --vanilla` examinée, `dplyr`, `tidyr`, `ggplot2`, `sf`, `FactoMineR`, `factoextra`, `bookdown` et `testthat` ne sont pas disponibles. Les livres n'ont donc pas été reconstruits et les recettes nécessitant ces packages n'ont pas encore été exécutées. La session émet également des avertissements de locale `C.UTF-8` ; les essais futurs d'import/export devront vérifier explicitement les accents et encodages.

Le travail livré à ce stade est l'étude et le plan. Les étapes 1 à 6 ci-dessus décrivent la réalisation à venir.
