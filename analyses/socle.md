# Analyse des modules socle : introduction et préparation des données

Analyse statique du 20 septembre 2026, destinée au plan du futur skill ; aucun script de formation, téléchargement de données, installation de package ou rendu du livre n'a été exécuté. Aucun `AGENTS.md` trouvé dans les dépôts examinés. Les propositions de renforcement sont distinguées des techniques effectivement enseignées.

## Corpus et traçabilité

| Repère | Dépôt et révision examinée | Contenu effectivement lu |
|---|---|---|
| M1 | `sources/parcours_r_socle_introduction`, SHA `42b7cc87636af83b0a48eb1867b98fbf24977bab` | Sources Rmd des chapitres, DESCRIPTION, administration R, exercices référencés |
| M2 | `sources/parcours_r_socle_preparation_des_donnees`, SHA `5c9c8513d4451409d3ccd8783cf97aeb940cb7c0` | Sources Rmd, DESCRIPTION, administration R, exercices référencés |
| EX | `sources-complementaires/savoirfR`, SHA `13377ca45486186266ab7f5fa9a3fb1a5223d826` | Corrigés R m1/exo1–5 et m2/exo1–6, vignettes m2/exo1,5,6 et passages ciblés exo3–4, fonction `charge_exo()` |
| PC | `sources-complementaires/parcours-r`, SHA `b53b22f75b8a35a5229be66ecdbc5154e3c0d9b9` | `parties_communes/bien_commencer.Rmd` et `savoir_faire.Rmd` inclus par les modules |

Les exercices ne sont pas intégralement présents dans les six dépôts initiaux : M1 `11-exercices.Rmd:22–58` et M2 `05-manipuler_des_donnees.Rmd:279–782`, `06-manipuler_plusieurs_tables.Rmd:74`, `09-exercice.Rmd:3` utilisent `charge_exo()`. La fonction résout les fichiers de `savoirfR/inst/vignettes` ([source EX](https://github.com/MTES-MCT/savoirfR/blob/13377ca45486186266ab7f5fa9a3fb1a5223d826/R/charge_exo.R#L17)). Les révisions des compléments sont celles examinées aujourd'hui, pas une garantie qu'elles correspondent aux versions installées lors de chaque publication historique.

## Techniques réellement enseignées

### Fondations et déroulé de travail

- Projet RStudio portable, chemins relatifs, organisation des données brutes et transformées, scripts dans `src`, figures séparées. La partie commune enseigne explicitement `renv::init()`, `snapshot()`, `restore()` et le versionnement Git ; renv n'est donc pas un ajout extérieur au corpus ([PC, lignes 1–21](https://github.com/MTES-MCT/parcours-r/blob/b53b22f75b8a35a5229be66ecdbc5154e3c0d9b9/parties_communes/bien_commencer.Rmd#L1)). M2 `03-get_started.Rmd:13–25,66–78` insiste sur une arborescence constante et des données brutes en lecture seule.
- Charger explicitement les packages nécessaires au début du script ; distinguer installation et chargement. Les listes globales du livre ne doivent pas devenir des dépendances systématiques de chaque script produit.
- Affectation `<-`, vecteurs, listes, matrices, data.frames, facteurs, `NA`, introspection `str`, `head`, `names`, `class`, `typeof`. Import CSV avec séparateur, décimale, encodage et types ; conserver les codes territoriaux comme texte ou catégories ([M1 import, lignes 78–145](https://github.com/MTES-MCT/parcours_r_socle_introduction/blob/42b7cc87636af83b0a48eb1867b98fbf24977bab/05-premier_jeu_donnees.Rmd#L78)).
- Pipelines lisibles `%>%`, une opération par étape, noms de résultats explicites. Base R reste expliqué : fonctions avec arguments, conditions, boucles, `apply`, inspection d'un objet `lm` (M1 `10-rbase.Rmd:30–153`). Ce chapitre est une initiation, pas une base suffisante pour concevoir un skill complet d'inférence statistique.
- Export CSV sans noms de lignes, graphiques via périphériques puis `dev.off()`, sauvegarde d'objets `.RData` (M1 `09-export.Rmd`). Ce sont des exemples du cours, pas un mandat de vider ou restaurer automatiquement l'environnement de l'utilisateur.

### Import et structuration

M2 `04-lire_des_donnees.Rmd:3–6` demande de documenter l'origine des données pour permettre leur reconstruction. Les exemples couvrent :

| Usage | Packages/fonctions présents | Place proposée |
|---|---|---|
| CSV et Excel | `read.csv`, `readr::read_delim/read_csv2`, `readxl::read_excel`, types explicites | Socle |
| Fichiers distants | `download.file`, `unzip` | Recette optionnelle avec provenance |
| API publiques | `jsonlite::fromJSON`, `httr::GET`, `rsdmx::readSDMX`, `didor` | Référence dédiée, endpoints à revérifier au besoin |
| PostgreSQL | DBI/RPostgreSQL, `dbGetQuery`, `dbplyr::tbl`, `in_schema`, `collect` ; `datalibaba` | Référence spécialisée, pas dépendance minimale |
| Spatial | `sf::st_read` : SHP, GeoJSON, WFS, PostGIS | Route vers le module spatial |
| Parquet | `arrow::write_parquet/read_parquet`, lecture sélective `col_select` | Référence gros volumes |

Preuve pour import distant, API, bases et Parquet : [M2 chapitre 4](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/blob/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0/04-lire_des_donnees.Rmd#L10). D'autres packages sont seulement cités (`data.table`, `parquetize`, `sfarrow`) : ne pas les présenter comme profondément enseignés.

### Transformation et calcul

- Verbes `select`, `arrange`, `rename`, `mutate`, `transmute`, `filter`, `pull`, conditions `%in%`, comparaisons, `ifelse`, `if_else` dans les corrigés, `case_when`, `coalesce`.
- `lubridate` pour parser dates/heures et extraire l'année ; `stringr`/`stringi` pour sous-chaînes, espaces, casse et expressions régulières ; `forcats` pour ordre des modalités (`fct_infreq`, `fct_relevel`, `fct_reorder`, `fct_inorder`). Exemple territorial concret : compléter un code INSEE avec `str_pad` (M2 `05-manipuler_des_donnees.Rmd:388–392`). Préserver dès l'import reste préférable à reconstruire un code détruit.
- Agrégations `group_by` + `summarise`, traitement explicite des `NA`, `.groups` et `ungroup`. Le cours dit que le traitement des manquants dépend de la source et du travail, et non qu'il faut toujours les supprimer ([M2, lignes 549–607](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/blob/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0/05-manipuler_des_donnees.Rmd#L549)).
- Sélecteurs `starts_with`, `ends_with`, `contains`, `matches`, `where`; `rename_with`, `across`, fonctions anonymes `~ .x`, `if_all`/`if_any`. Le cours avertit de la fragilité de la sélection par position ([M2, lignes 671–786](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/blob/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0/05-manipuler_des_donnees.Rmd#L671)).
- Données tidy : définir observation, variable et unité d'observation ; `pivot_longer`, `pivot_wider`, `names_sep`, `names_pattern`, `separate` ([M2 chapitre 7, lignes 9–103](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/blob/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0/07-structurer_ses_tables.Rmd#L9)).
- Jointures avec `by` explicite, clés composites ou noms différents et suffixes (M2 `06-manipuler_plusieurs_tables.Rmd:23–48`). Les corrigés ajoutent `anti_join` pour les analyses orphelines et molécules absentes d'un référentiel, `distinct`, `n_distinct` ([EX m2/exo5, lignes 35–86](https://github.com/MTES-MCT/savoirfR/blob/13377ca45486186266ab7f5fa9a3fb1a5223d826/inst/vignettes/m2/exo5.rmd#L35)).
- Séries temporelles : `lag`, `lead`, cumuls, `RcppRoll::roll_sumr`. Les corrigés Sitadel trient avant calcul, groupent par région, gardent ce groupe après agrégation annuelle pour les évolutions puis dégrouppent ([EX corrigé m2/exo3, lignes 20–50](https://github.com/MTES-MCT/savoirfR/blob/13377ca45486186266ab7f5fa9a3fb1a5223d826/inst/rstudio/templates/project/ressources/m2/corrections/exo3.R#L20)).
- Cohérence territoriale : millésimes du COG, `COGiter::passer_au_cog_a_jour`, `cogifier`, `filtrer_cog`. Le support souligne ses limites sur scissions et données secrétisées ([M2 chapitre 8, lignes 3–13](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/blob/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0/08-cogiter.Rmd#L3)).

### Description et première visualisation

`summary`, moyenne, médiane, variance, écart-type, quantiles, `table`, `prop.table`, agrégations par région ; densité, taux par mille, centrage-réduction. Le corrigé M1 exo5 distingue bien histogramme quantitatif et barplot catégoriel. `ggplot2` avec `aes`, `geom_histogram`, `geom_bar`, `geom_point`, puis `GGally::ggpairs` et `plotly::ggplotly` en bonus. Les références statistiques et datavisualisation du futur skill doivent approfondir ces sujets sans répéter le socle.

## Points à corriger ou adapter avant de produire le skill

1. **Erreur sur `case_when`** : M2 `05-manipuler_des_donnees.Rmd:261` décrit un ordre « de bas en haut ». Retenir la première condition correspondante, dans l'ordre écrit. Vérification primaire : [documentation dplyr](https://dplyr.tidyverse.org/reference/case-and-replace-when.html), consultée le 20/09/2026.
2. **Classe Date** : M1 `05-premier_jeu_donnees.Rmd:13` assimile les formats de dates à `character`. Distinguer texte importé, classe `Date` et format d'affichage ; le corrigé EX m2/exo2 lui-même commente que `format()` produit du texte. Vérification : [manuel R Date](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Dates.html), consulté le 20/09/2026.
3. **Évolutions d'API vérifiées** : `one_of` est marqué superseded au profit de `all_of/any_of` ([tidyselect](https://tidyselect.r-lib.org/reference/one_of.html)); `separate` au profit de `separate_wider_delim/position` ([tidyr](https://tidyr.tidyverse.org/reference/separate.html)), consultation 20/09/2026. Superseded ne signifie pas supprimé. Choisir selon versions du projet ; garder les correspondances historiques dans une référence de migration. Ne pas affirmer que `%>%` est obsolète.
4. **Effets de session et réseau** : ne pas recopier `rm(list=ls())` de `index.Rmd`, `load()` dans l'environnement global, ou le contournement TLS `extra = "-k"` de M2 `04-lire_des_donnees.Rmd:54`. Proposer des exemples autonomes et documenter leurs entrées/sorties. Les fonctions présentées restent étudiables sans exécuter les builds.
5. **Fenêtres temporelles** : `roll_sumr(n=12)` travaille sur 12 observations. Compléter le cours par vérification d'unicité et continuité du calendrier mensuel ; sinon « 12 mois » peut être faux. Définir la politique sur les 11 premiers mois, les mois absents et les dénominateurs nuls.
6. **Jointures et regroupements** : contrôler types de clés, cardinalités, doublons et pertes ; le corrigé EX m2/exo6 utilise `full_join()` sans `by` (lignes 63–65 du corrigé R), alors que le cours enseigne les clés explicites. Le corrigé exo4 groupe sur `libelle_station` (ligne 38), tandis que l'énoncé demande `code_station` : employer un identifiant stable et conserver le libellé comme attribut. Expliciter aussi la conservation des ex aequo du maximum.
7. **MAJIC : incohérence d'unités à résoudre** : EX `inst/vignettes/m2/exo6.rmd:16–18` décrit 4,9 m², mais le code compare `evoarti`, calculé en pourcentage ligne 90, à 4.9 lignes 99–101. Ne pas intégrer cet indicateur métier tel quel. Garder l'exercice comme exemple de chaîne multi-millésimes et demander une définition métier cohérente lors de son adaptation.
8. **Prudence de portée** : codes de connexion, encodage Windows fixe, endpoints INSEE/URSSAF/DiDo, couches WFS et référentiels COG sont contextuels. Leur disponibilité actuelle et l'API des packages spécialisés n'ont pas été validées ici. Le plan doit prévoir une vérification ciblée avant d'en faire des recettes exécutables ; ne pas déduire leur obsolescence de leur âge.

Ces contrôles supplémentaires (cardinalité, calendriers, divisions par zéro) sont des propositions d'ingénierie issues de l'analyse, pas tous des prescriptions explicites du cours.

## Proposition pour le futur skill

Un noyau court orienterait le modèle vers : comprendre l'unité d'observation et les résultats attendus → inspecter schéma/types/provenance → importer de façon reproductible → transformer avec pipelines lisibles → vérifier effectifs, clés, manquants et unités → exporter et expliquer. Il ne chargerait pas les six cours en entier.

Références candidates à charger selon la tâche :

- `references/projet-et-import.md` : projet, chemins, renv, CSV français, Excel, provenance et exports.
- `references/preparation-tidyverse.md` : typage, dates, texte, facteurs, `across`, regroupements et `NA`.
- `references/jointures-et-pivots.md` : granularité, clés, orphelins, long/large, validations proposées.
- `references/series-et-territoires.md` : cumuls glissants Sitadel, taux, COG et millésimes, avec route vers spatial.
- `references/imports-avances.md` : SQL différé puis `collect`, Parquet, APIs ; éviter de rendre ces dépendances obligatoires.
- `references/compatibilite-et-provenance.md` : correspondances cours/recettes, erreurs constatées, versions réellement testées, licences et liens par SHA.

Les recettes devront être écrites spécialement pour le skill, avec données synthétiques minuscules et sorties attendues, sans copier de longs corrigés ou imposer l'installation de `savoirfR`, `COGiter`, bookdown et de leurs dépendances pour toute tâche R.

## Scénarios de validation proposés

| Scénario | Comportement attendu |
|---|---|
| CSV `;`, décimales `,`, noms accentués, codes `01001` et `2A004` | Import exact, codes conservés, types contrôlés, manquants distincts de zéro |
| Jointure analyses → prélèvements → stations avec orphelin et doublon de référentiel | Choix de jointure expliqué, `anti_join` de contrôle, pas de multiplication silencieuse |
| Population large `F_0_19`, `H_0_19`, etc. | Dimensions explicites, pivot long, contrôle d'unicité avant retour large |
| Sitadel de deux régions, lignes désordonnées et mois absent | Tri, calcul par région, anomalie de calendrier signalée ; aucun décalage d'une région à l'autre |
| Agrégation avec groupe totalement manquant et ratio au dénominateur zéro | Politique explicite, pas de faux zéro ou de pourcentage infini passé sous silence |
| Recodage par seuils superposés, `NA`, bornes exactes | Première correspondance correcte, cas limites documentés |
| Stations distinctes partageant un libellé et maxima ex aequo | Regroupement sur code stable ; choix explicite sur ex aequo |
| Comparaison communale entre deux COG | Millésimes demandés ou identifiés, changements territoriaux explicités, pas de somme de taux |
| Exécution d'une recette depuis une session R vierge | Aucune dépendance à des objets préexistants ou chemins personnels, pas d'installation implicite |

Ces scénarios sont un plan de tests pour l'implémentation future ; ils n'ont pas été exécutés dans cette étude.

## Attribution et licences déclarées

- M1 : `DESCRIPTION:6` déclare **MIT**, sans fichier LICENSE autonome trouvé. `index.Rmd:3` crédite Thierry Zorn, Murielle Lethrosne, Vivien Roussez, Pascal Irz et Nicolas Torterotot. [Métadonnées M1](https://github.com/MTES-MCT/parcours_r_socle_introduction/blob/42b7cc87636af83b0a48eb1867b98fbf24977bab/DESCRIPTION#L6).
- M2 : `DESCRIPTION:5–12` crédite Juliette Engelaere-Lefebvre, Bruno Terseur et Maël Theulière et déclare **Licence ouverte / Open Licence 2.0**. [Métadonnées M2](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/blob/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0/DESCRIPTION#L5).
- savoirfR : `DESCRIPTION` déclare **GPL-3** et plusieurs auteurs. [Métadonnées EX](https://github.com/MTES-MCT/savoirfR/blob/13377ca45486186266ab7f5fa9a3fb1a5223d826/DESCRIPTION#L4). Les corrigés externes ne doivent donc pas être implicitement attribués à la licence MIT du module 1.
- Illustrations et données ont leurs propres sources : crédits photographiques Pascal Boulin et Sébastien Colas dans les index, animations Garrick Adenbuie dans M2, jeux INSEE/Sitadel/MAJIC. Le plan devrait conserver un registre de provenance des éléments réellement repris ; cette étude n'établit pas une licence unique sur l'ensemble des dépendances et données.
