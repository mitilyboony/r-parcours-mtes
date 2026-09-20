---
name: r-parcours-mtes
description: Aide à écrire et vérifier du code R pour importer, préparer, décrire, analyser, visualiser et cartographier des données, selon les méthodes du parcours R MTES-MCT. Utiliser pour les scripts d'analyse de données en R ; ne couvre pas la construction complète d'applications Shiny ou de packages.
---

# Codage R selon le parcours MTES-MCT

Utilise ce skill pour produire du code R lisible, reproductible et interprétable. Commence par identifier la question, l'unité d'observation, les types de variables, la provenance des données et la sortie attendue. Préserve les conventions du projet existant (pipe, structure, gestionnaire d'environnement et versions) au lieu de réécrire tout le projet.

## Méthode commune

1. Inspecte la structure, les classes, les clés, les doublons, les valeurs manquantes et les unités avant de transformer.
2. Écris une recette autonome : entrées explicites, packages réellement nécessaires, résultats nommés et aucune dépendance à un objet caché dans la session.
3. Rends visibles les choix qui changent le résultat : clés de jointure, pondérations, dénominateurs, suppression ou imputation, échelle, CRS, prédicat spatial et nombre de groupes.
4. Vérifie les invariants après chaque étape : nombre de lignes, unicité attendue, total, couverture des clés, proportions, unités et valeurs aberrantes.
5. Explique le résultat avec ses limites. Une association n'est pas une causalité ; une absence de corrélation linéaire n'est pas une indépendance ; un test de rangs n'est pas un test générique de moyenne.

## Choisir la référence

Lis seulement les références nécessaires à la demande :

- préparation, import, jointures et séries : [preparation-donnees.md](references/preparation-donnees.md), [workflow-import-export.md](references/workflow-import-export.md), [series-et-territoires.md](references/series-et-territoires.md) ;
- statistiques et tests : [statistiques-descriptives.md](references/statistiques-descriptives.md), [tests-statistiques.md](references/tests-statistiques.md) ;
- ACP, AFC, ACM et classifications : [analyses-multivariees.md](references/analyses-multivariees.md) ;
- graphiques et cartes : [datavisualisation.md](references/datavisualisation.md), [analyse-spatiale.md](references/analyse-spatiale.md) ;
- import avancé et compatibilité : [imports-avances.md](references/imports-avances.md), [compatibilite-et-pieges.md](references/compatibilite-et-pieges.md).

Le jeu de références n'est pas une copie des supports : il en retient les méthodes et corrige les exemples qui pourraient produire une conclusion fausse. La provenance détaillée est dans [sources.md](references/sources.md).

## Contrôles indispensables

- Pour une jointure, déclare les clés et vérifie la cardinalité avant et après. Cherche les orphelins avec `anti_join()` et ne masque pas les doublons.
- Pour un résumé groupé, calcule `n_total`, `n_valide` et `n_manquant` par groupe. Un groupe sans observation valide n'est pas un zéro.
- Pour une série, trie par identifiant et période avant `lag()`, `lead()` ou une fenêtre glissante. Signale les périodes manquantes.
- Pour un graphique, distingue une valeur déjà agrégée (`geom_col()`) d'un comptage (`geom_bar()`), mets les variables dans `aes()` et les constantes hors de `aes()`, puis exporte avec dimensions explicites.
- Pour un test ou une analyse factorielle, formule la question et le paramètre avant de choisir la fonction. Sépare variables actives et supplémentaires, et rapporte les exclusions.
- Pour `sf`, vérifie le CRS d'origine avant `st_set_crs()`, transforme avec `st_transform()`, contrôle les unités et garde les zones sans correspondance. Une jointure spatiale gauche laisse une ligne avec `NA` pour une zone vide : ne compte pas `length(NA)` comme une observation.

## Périmètre

Les extensions `leaflet`, `ggiraph`, `gganimate`, `tmap`, APIs, SQL et référentiels géographiques sont optionnelles. Ne les charge et ne les installe que si la sortie demandée les nécessite. Les recettes par défaut doivent fonctionner avec des données locales et documenter leurs dépendances.
