# Sources et provenance

Le skill synthétise les six dépôts du parcours R MTES-MCT figés aux commits suivants (étude du 20 septembre 2026) :

| Domaine | Dépôt | Révision |
|---|---|---|
| Introduction | [parcours_r_socle_introduction](https://github.com/MTES-MCT/parcours_r_socle_introduction/tree/42b7cc87636af83b0a48eb1867b98fbf24977bab) | `42b7cc87636af83b0a48eb1867b98fbf24977bab` |
| Préparation | [parcours_r_socle_preparation_des_donnees](https://github.com/MTES-MCT/parcours_r_socle_preparation_des_donnees/tree/5c9c8513d4451409d3ccd8783cf97aeb940cb7c0) | `5c9c8513d4451409d3ccd8783cf97aeb940cb7c0` |
| Statistiques | [parcours_r_module_statistiques_descriptives](https://github.com/MTES-MCT/parcours_r_module_statistiques_descriptives/tree/735544c0d6856efcfc1aef0c4ea5e149b2ac36b7) | `735544c0d6856efcfc1aef0c4ea5e149b2ac36b7` |
| Multivarié | [parcours_r_module_analyse_multi_dimensionnelles](https://github.com/MTES-MCT/parcours_r_module_analyse_multi_dimensionnelles/tree/faa194c7f063d16f6cb069d13357905a4ede875b) | `faa194c7f063d16f6cb069d13357905a4ede875b` |
| Datavisualisation | [parcours_r_module_datavisualisation](https://github.com/MTES-MCT/parcours_r_module_datavisualisation/tree/809263de69693c891aa5c22fb3f58a96f7163afe) | `809263de69693c891aa5c22fb3f58a96f7163afe` |
| Spatial | [parcours_r_module_analyse_spatiale](https://github.com/MTES-MCT/parcours_r_module_analyse_spatiale/tree/e3fddaabbbde98c065e67652fd51303826786018) | `e3fddaabbbde98c065e67652fd51303826786018` |

Les exercices externalisés viennent de [savoirfR](https://github.com/MTES-MCT/savoirfR/tree/13377ca45486186266ab7f5fa9a3fb1a5223d826), et les chapitres communs de [parcours-r](https://github.com/MTES-MCT/parcours-r/tree/b53b22f75b8a35a5229be66ecdbc5154e3c0d9b9). Le skill est une synthèse originale et ne requiert aucun de ces dépôts.

Références officielles utilisées pour les corrections : [dplyr `across`](https://dplyr.tidyverse.org/reference/across.html), [dplyr `case_when`](https://dplyr.tidyverse.org/reference/case-and-replace-when.html), [dplyr jointures](https://dplyr.tidyverse.org/reference/mutate-joins.html), [sf `st_join`](https://r-spatial.github.io/sf/reference/st_join.html), [R `wilcox.test`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html), [R `t.test`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html) et [R `chisq.test`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html).

Les dépôts déclarent des licences différentes (MIT, Licence Ouverte 2.0, GPL-3 pour `savoirfR`) et une divergence dans le module spatial. Ce dossier ne redistribue pas leurs données, images ou longs corrigés ; vérifier les licences avant toute reprise substantielle.
