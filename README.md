# Skill R fondé sur le parcours MTES-MCT

Ce dépôt contient le skill `r-parcours-mtes`, destiné à aider Codex à écrire du code R pour préparer, analyser, visualiser et cartographier des données. Il synthétise les six modules de formation R du pôle ministériel MTES-MCTRCT, avec des contrôles supplémentaires là où les exemples pédagogiques pouvaient produire une interprétation trompeuse.

## Contenu

- `skills/r-parcours-mtes/SKILL.md` : point d'entrée du skill et routage vers les références ;
- `skills/r-parcours-mtes/references/` : méthodes par domaine, pièges, compatibilité et provenance ;
- `skills/r-parcours-mtes/examples/` : petits exemples R reproductibles, sans données distantes ;
- `skills/r-parcours-mtes/tests/` : validations sans `testthat`, exécutables avec `Rscript` ;
- `evaluations/r-parcours-mtes/` : demandes réalistes pour évaluer le comportement du skill ;
- `analyses/` et `plans/` : étude du corpus qui a précédé l'implémentation ;
- `sources/` et `sources-complementaires/` : clones de travail ignorés par Git, utilisés pour l'étude.

## Vérifier localement

Depuis la racine :

```powershell
Rscript skills/r-parcours-mtes/tests/test-preparation.R
Rscript skills/r-parcours-mtes/tests/test-statistiques.R
Rscript skills/r-parcours-mtes/tests/test-multivarie.R
```

Les tests qui nécessitent `dplyr`, `tidyr`, `sf` ou `FactoMineR` indiquent clairement la dépendance manquante. Ils ne téléchargent pas de données et n'installent pas de packages.

## Installer le skill

Copier le dossier `skills/r-parcours-mtes` dans le répertoire de skills de Codex, ou l'utiliser depuis ce dépôt pendant le développement. Le skill ne dépend pas des clones de formation après installation.

## Limites et attribution

Le skill ne remplace pas une expertise statistique, géomatique ou métier. Il ne construit pas automatiquement une application Shiny et ne lance pas de requête réseau cachée. Les sources et commits étudiés sont listés dans [sources.md](skills/r-parcours-mtes/references/sources.md). Les licences des dépôts d'origine sont hétérogènes ; cette synthèse originale ne redistribue pas leurs jeux de données, images ou corrigés complets.
