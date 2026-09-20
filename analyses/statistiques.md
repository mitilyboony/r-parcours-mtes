# Analyse des formations statistiques pour le futur skill R

Analyse statique réalisée le 20 septembre 2026. Aucun script de formation n'a été exécuté, aucune dépendance R installée. Les chapitres Rmd contiennent les exemples et les corrections ; les scripts `m3_admin.R` et `m4_admin.R` sont des scripts de construction des livres, pas des bibliothèques métier. Aucun `AGENTS.md` repéré dans ces deux dépôts.

## Sources figées et attribution

| Repère | Dépôt | Commit analysé | Licence déclarée |
|---|---|---|---|
| M3 | `sources/parcours_r_module_statistiques_descriptives` | `735544c0d6856efcfc1aef0c4ea5e149b2ac36b7` | `DESCRIPTION:29`, MIT |
| M4 | `sources/parcours_r_module_analyse_multi_dimensionnelles` | `faa194c7f063d16f6cb069d13357905a4ede875b` | `DESCRIPTION:6`, MIT |

Preuves permanentes : [DESCRIPTION M3](https://github.com/MTES-MCT/parcours_r_module_statistiques_descriptives/blob/735544c0d6856efcfc1aef0c4ea5e149b2ac36b7/DESCRIPTION#L29), [DESCRIPTION M4](https://github.com/MTES-MCT/parcours_r_module_analyse_multi_dimensionnelles/blob/faa194c7f063d16f6cb069d13357905a4ede875b/DESCRIPTION#L6). Aucun fichier autonome `LICENSE` ou `LICENCE` repéré. Conserver provenance, auteurs et déclaration de licence lors de la rédaction ; inventorier séparément images et données externes plutôt que supposer qu'elles ont toutes le même statut. Auteurs M3 indiqués dans `index.Rmd:3` : Solène Colin, Vivien Roussez et Pascal Irz.

Dans les tableaux ci-dessous, les chemins et lignes renvoient à ces commits. Le futur skill devra conserver un manifeste de sources avec ces SHA, afin que ses références restent vérifiables.

## Techniques effectivement enseignées

| Domaine | Méthodes et fonctions constatées | Preuves locales |
|---|---|---|
| Décrire les variables | Types quantitatif/qualitatif ; `factor`, `levels`, `forcats::fct_drop`, `fct_recode`, `fct_relevel`, `fct_infreq` | M3 `02-rappels.Rmd:89-229` |
| Décrire une quantité | Médiane, quantiles, IQR, moyenne arithmétique/géométrique, variance, écart-type, étendue, coefficient de variation ; `summary`, agrégations `dplyr` | M3 `03-une-variable-quantitative.Rmd:49-194` |
| Pondérer | `weighted.mean(x, w)` sur nombre de pièces et nombre d'appartements ; `xtabs(P14_POP ~ ZAU)` et fréquences pondérées | M3 `03-une-variable-quantitative.Rmd:87-99`, `04-une-variable-qualitative.Rmd:44-78` |
| Explorer les distributions | Histogramme, densité, quantiles sur graphique, logarithme ; discrétisation avec `cut`, quantiles et `cartography::getBreaks(..., method="fisher-jenks")` | M3 `03-une-variable-quantitative.Rmd:237-344` |
| Décrire une catégorie | `table`, `prop.table`, affichage `DT::datatable` et `formatPercentage`, barres ordonnées avec `forcats`, préférence pour barres plutôt que secteurs | M3 `04-une-variable-qualitative.Rmd:23-134` |
| Croiser deux catégories | Tableau de contingence, marges, profils-lignes et profils-colonnes ; `prop.table(margin=1/2)`, `addmargins`, `xtabs`, barres empilées/juxtaposées et mosaïque | M3 `06-croisement-2-variables-quali.Rmd:15-138` |
| Croiser deux quantités | Nuage de points, lissage, `GGally::ggpairs`, Pearson/Spearman, `lm` et résumé du modèle | M3 `05-croisement-2-variables-quanti.Rmd:17-128` |
| Quantité par catégorie | `group_by`/`summarise`, boxplots/violons, ANOVA et `lsr::etaSquared` | M3 `07-croisement-var-quant-var-qual.Rmd:7-59` |
| Inférence usuelle | QQ-plot, Shapiro-Wilk, Student/Wilcoxon, tests appariés, χ², V de Cramer, ANOVA/Tukey, Kruskal-Wallis et Wilcoxon par paires corrigé BH | M3 `08-tests.Rmd:19-351` |
| Analyses factorielles | `FactoMineR::PCA`, `CA`, `MCA`, `dimdesc`, graphiques de ces objets ; variables supplémentaires, contributions, cos², coordonnées et valeurs propres | M4 `02-ACP.Rmd:152-325`, `03-AFC.Rmd:65-117`, `04-ACM.Rmd:69-169` |
| Classification | `stats::kmeans`, initialisation explicite ou `set.seed`, classification sur coordonnées factorielles ; `FactoMineR::HCPC`, Ward, choix du nombre de classes, descriptions/parangons | M4 `05-Clustering.Rmd:7-205` |

Packages centraux : `stats`/base R, `dplyr`, `tidyr`, `forcats`, `ggplot2`, `FactoMineR`. Packages auxiliaires réellement utilisés : `GGally`, `DT`, `lsr`, `plotly`, `ggExtra`, `grid`, `cartography`. `factoextra` figure dans le README, DESCRIPTION et les chargements M4, mais les chapitres étudiés utilisent principalement `plot.PCA`, `plot.CA`, `plot.MCA` et `plot.HCPC` ; ne pas inventer une collection de recettes `fviz_*` prétendument enseignée ici. `missMDA` est cité comme possibilité d'imputation dans `01-intro.Rmd:157`, sans recette implémentée. `ade4` et l'analyse discriminante sont des pistes, pas un contenu travaillé.

## Décisions que le skill doit savoir prendre

1. **Établir l'unité statistique et le sens des poids avant de coder.** Les communes sont les lignes ; leur population peut servir de poids. Le pourcentage de communes urbaines n'est pas le pourcentage d'habitants vivant en commune urbaine. Afficher le dénominateur et conserver les effectifs non manquants. Ces exemples ne forment pas une méthode d'inférence pour enquêtes à plan complexe.
2. **Choisir selon les types et la question.** Une quantité : distribution et résumé ; deux quantités : nuage puis association/modèle ; deux catégories : tableau et profils ; quantité par catégorie : distribution par groupe et mesure d'association. Ne pas déclencher un test simplement parce qu'il est disponible.
3. **Choisir l'analyse factorielle selon la structure de l'entrée.** ACP : colonnes quantitatives actives ; AFC : tableau de contingence de deux caractères, sans totaux ; ACM : individus × variables qualitatives. Les modalités ordinales perdent leur ordre dans l'AFC/ACM. Pour des données mixtes, le cours illustre une ACP avec variables qualitatives supplémentaires ; aucune recette FAMD n'est enseignée.
4. **Distinguer variables actives et supplémentaires.** Une variable identifiante ou descriptive du public ne doit pas déterminer les axes par accident. M4 `04-ACM.Rmd:145-171` montre que faire passer le sexe en variable active change fortement l'analyse des loisirs. Déduire les indices de colonnes supplémentaires à partir des noms au moment de l'appel, plutôt que recopier `19:22` sur un autre tableau.
5. **Préparer et tracer les exclusions.** Repérer NA, valeurs infinies, constantes, identifiants dupliqués, catégories rares, lignes/colonnes de masse nulle. Conserver un identifiant explicite pendant les transformations. Le cours rappelle la perte possible des noms de lignes, M4 `02-ACP.Rmd:112-125` et `195-208`.
6. **Justifier la standardisation et le nombre d'axes.** Le cours centre-réduit les variables d'unités/variances différentes et examine inertie, coude et interprétabilité. Il faut exposer le choix et l'inertie conservée, sans coder un seuil fixe issu d'un exemple. M4 `02-ACP.Rmd:84-88`, `220-256` ; `04-ACM.Rmd:81-121`.
7. **Interpréter contribution, qualité de représentation, puis coordonnées.** Ne pas commenter une proximité visible sans consulter les cos² ni assimiler automatiquement corrélation, indépendance et causalité. Produire des tableaux lisibles avant de verbaliser les axes. M4 `02-ACP.Rmd:258-305`.
8. **Traiter une typologie comme une exploration.** Décrire chaque classe dans les variables d'origine, tester plusieurs configurations, fixer l'aléa, documenter axes et nombre de groupes. Les groupes obtenus ne prouvent pas l'existence de groupes naturels. M4 `05-Clustering.Rmd:3-5`, `35-48`, `65-75`, `153-177`.

## NA et pondérations : règles à expliciter

- Les résumés utilisent très souvent `na.rm = T`, mais le nombre de NA supprimés n'est généralement pas rapporté. Chaque recette réutilisable devra fournir `n_total`, `n_valide` et `n_manquant`, traiter le groupe entièrement manquant et éviter un `NaN` silencieux.
- `weighted.mean` est illustré sans NA (`03-une-variable-quantitative.Rmd:99`). Ajouter des cas de validation pour poids manquants, somme des poids nulle et correspondance ligne à ligne. L'élimination des valeurs manquantes dans les mesures et dans les poids exige une décision explicite.
- `table` et `xtabs` n'ont pas une politique des NA explicitée dans les exemples. Le skill doit préciser si une catégorie manquante est exclue ou affichée, et garantir que le dénominateur des proportions suit cette décision.
- L'ACP applique `na.omit` à l'ensemble du tableau, puis décrit le remplacement par moyenne proposé par défaut par `PCA` (`02-ACP.Rmd:123-125`, `154`). Transformer ces deux comportements en options explicites avec bilan des pertes, pas en suppression ou imputation automatique.
- L'AFC remplace toutes les valeurs numériques manquantes par zéro (`03-AFC.Rmd:49-56`). Ne reprendre cette opération que si NA signifie réellement absence d'immatriculation ; une donnée inconnue n'est pas un compte nul.
- `MCA(row.w=...)` est mentionné (`04-ACM.Rmd:9`), mais aucun exemple complet de pondération ACM n'est exécuté dans le chapitre. Le classer en extension à valider dans la documentation de la version retenue.

## Modernisation et corrections nécessaires

Les formations sont une source de démarche et d'exemples ; elles ne doivent pas devenir des instructions copiées sans contrôle. Cette liste sépare constats du dépôt et travail proposé.

| Constat dans la source | Décision pour la future rédaction |
|---|---|
| `summarise_if`, `summarise_at`, `funs` (M3 `03-une-variable-quantitative.Rmd:176-194`) ; `mutate_if`/`funs` (M4 `03-AFC.Rmd:55`) | Transcrire en `across`/`where` et fonction anonyme ; `across` remplace les variantes à suffixe dans la documentation officielle. |
| `gather`, `spread` côtoient déjà `pivot_wider` (M3 `08-tests.Rmd:242-255`, `06-croisement-2-variables-quali.Rmd:24`) | Harmoniser vers `pivot_longer`/`pivot_wider`, en vérifiant clés uniques et types ; valider les signatures au moment de l'implémentation. |
| `T`/`F`, dépendances chargées massivement, `plyr` et `dplyr` (M3 `01-get_started.Rmd:41-51`) | `TRUE`/`FALSE`, dépendances minimales par recette, appels qualifiés pour les fonctions ambiguës. |
| Le commentaire dit que `geom_mosaic` « ne fonctionne plus » (M3 `06-croisement-2-variables-quali.Rmd:121`) | Ne pas en faire une recette standard avant test ; le cours utilise aussi la mosaïque de base R. |
| Corrélation proche de zéro présentée comme indépendance (M3 `05-croisement-2-variables-quanti.Rmd:71`) | Corriger : une absence d'association linéaire n'exclut pas une relation non linéaire. Vérification simple avec `x=-2:2` et `y=x^2`. |
| `num` est déjà logarithmé puis `cor(na.omit(log(num)))` applique un second logarithme (M3 `05-croisement-2-variables-quanti.Rmd:62-83`) ; ajout arbitraire d'epsilon ailleurs | Définir une seule transformation motivée ; contrôler domaine, unités, zéros et valeurs négatives ; pas d'epsilon universel. |
| Student présenté comme utilisable « si et seulement si » la distribution est normale, suivi d'un basculement automatique vers Wilcoxon (M3 `08-tests.Rmd:64`) | Réécrire la décision autour de la quantité estimée, du plan, de l'indépendance, de la taille d'échantillon et des hypothèses. Ne pas confier la décision au seul Shapiro. |
| `var.equal=TRUE` sans justification (M3 `08-tests.Rmd:210`) | Ne pas imposer l'égalité des variances ; le comportement par défaut de `t.test` est Welch. |
| Wilcoxon décrit comme démontrant une différence de moyennes (M3 `08-tests.Rmd:225`, `276`) | Corriger l'interprétation : test de rangs/position ; le test signé repose sur la symétrie de la distribution des différences. Ce n'est pas un test générique de moyenne. |
| χ² : règle formulée sur « chaque case », puis regroupements/exclusions (M3 `08-tests.Rmd:139-168`) | Inspecter les effectifs attendus, les masses nulles et le plan d'échantillonnage ; ne pas supprimer des territoires uniquement pour obtenir un test applicable. Documenter toute fusion. |
| Barre d'incertitude : `n <- nrow(data_test_m)` global utilisé dans chaque groupe (M3 `08-tests.Rmd:317-323`) | Calculer l'effectif valide par groupe ; choisir et nommer correctement l'intervalle. C'est une erreur concrète de recette à ne pas répliquer. |
| Le corrigé propose de faire comme si les distributions non normales n'avaient pas été vues (M3 `09-exercice.Rmd:400`) | Ne pas transformer cette facilité pédagogique en règle du skill ; exiger diagnostics et justification du modèle. |
| AFC/ACM : arguments graphiques de proximité simplifiés ; seuil d'inertie moyenne parfois repris de l'ACP | Vérifier interprétation des espaces et choix des axes dans les ressources FactoMineR avant formalisation ; ne pas coder les heuristiques comme des garanties. |
| `kmeans(..., centers=4)` et `HCPC(..., nb.clust=5)` correspondent à un exercice (M4 `05-Clustering.Rmd:28`, `109`) | Paramétrer le nombre de groupes et le nombre d'axes ; justifier les valeurs, garder graine et contexte d'exécution. Ajouter une analyse de stabilité à valider, distincte du contenu strict de la formation. |

Documentation officielle consultée le 20 septembre 2026 pour confirmer les corrections : [dplyr — across](https://dplyr.tidyverse.org/reference/across.html), [R — t.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html), [R — wilcox.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html), [R — chisq.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html). Les pages R consultées sont celles de R-devel : vérifier les comportements exacts contre la version R installée lors de la création des exemples.

## Architecture proposée pour cette partie du skill

- Une entrée courte dans `SKILL.md` : établir question/unité/types/NA, router vers la référence pertinente, fournir code puis contrôles et interprétation mesurée.
- `references/statistiques-descriptives.md` : recettes de résumé, fréquences/profils et pondérations, choix des figures, domaines des transformations.
- `references/tests-et-modeles-simples.md` : décision selon question et plan ; hypothèses, `htest`, tailles d'effet, intervalles et comparaisons multiples. Séparer clairement description et inférence.
- `references/analyses-factorielles.md` : contrats d'entrée PCA/CA/MCA, préparation des données, actifs/supplémentaires, NA, axes, contributions et cos².
- `references/classification.md` : chaîne analyse factorielle → coordonnées sélectionnées → kmeans/HCPC → description des classes ; reproductibilité et limites d'interprétation.
- `references/provenance.md` : correspondances recettes → fichiers/lignes/SHA ; noter pour chacune « conservée », « modernisée », « corrigée » ou « extension validée ».
- Des exemples autonomes très petits, uniquement si utiles à l'exécution. Ne pas embarquer la compilation Bookdown complète, les images, ni les téléchargements de jeux de données distants pour faire fonctionner le skill.

## Scénarios de validation proposés

| Scénario utilisateur | Résultat attendu et critère observable |
|---|---|
| « Résume la population par type de commune », avec NA et un groupe entièrement vide | Effectifs totaux/valides/manquants, résumé cohérent, politique explicite pour groupe sans valeur ; aucune moyenne trompeuse. |
| « Donne la part urbaine » avec deux communes de populations 10 et 990, une urbaine | Identifier l'ambiguïté ; distinguer 50 % des communes et 1 % ou 99 % des habitants selon la commune urbaine. |
| « Donne les profils par région » | Le bon axe de `prop.table` est choisi et nommé ; chaque marge valide somme à 1 avant arrondi. |
| « Fais une corrélation » sur relation en U et données contenant 0/NA | Nuage préalable, pas de conclusion d'indépendance sur Pearson nul, pas de `log(0)` silencieux. |
| « Compare avant/après » avec lignes mélangées et quelques mesures manquantes | Appariement par identifiant, exclusions par paire annoncées, contrôle des différences ; pas de test indépendant par défaut. |
| « Compare les moyennes de groupes » avec tailles et variances différentes | Choix expliqué, pas de `var.equal=TRUE` automatique, intervalles calculés avec effectifs par groupe. |
| « Fais une ACP sur iris » | Quatre mesures actives ; `Species` supplémentaire ; dimensions, inertie, contributions/cos² disponibles ; ajout de `Species` ne change pas les axes actifs à signe près. |
| « Fais une AFC » sur petit tableau avec ligne Total, NA et colonne nulle | Total exclu, NA discuté plutôt que converti en zéro, marges nulles traitées et rapportées, contrat de tableau respecté. |
| « Fais une ACM sur hobbies » | Variables de loisirs actives ; sociodémographie supplémentaire ; choix des axes argumenté, pas d'intégration implicite de toutes les colonnes. |
| « Construis une typologie » | Graine fixe, axes et nombre de groupes consignés, table des tailles et description par variables d'origine ; même partition à permutation des numéros de classes près. |
| « Calcule les statistiques descriptives de ce tableau » | Le skill identifie les seules dépendances nécessaires ; il ne déduit pas de cette demande une installation de toute la pile pédagogique. Une demande explicite d'installation complète reste un autre périmètre à respecter. |

Ces validations sont proposées pour la phase d'implémentation du skill. Elles n'ont pas été exécutées pendant cet audit statique.

## Limites matérielles des supports

Les livres incorporent des chapitres distants de `MTES-MCT/parcours-r` au moment du rendu (`M3/index.Rmd:27,40`, `M4/index.Rmd:44,52`) ; leur contenu n'est donc pas entièrement figé par le clone de ces deux dépôts. Les jeux de données présents et les petites données embarquées (`iris`, `hobbies`) suffisent pour concevoir plusieurs exemples indépendants. Une reproduction complète des livres exigerait un travail distinct de fixation des versions et des dépendances réseau.
