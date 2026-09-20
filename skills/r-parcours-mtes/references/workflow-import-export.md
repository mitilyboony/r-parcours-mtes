# Projet, import et export

Travaille dans un projet avec des chemins relatifs. Garde les données brutes séparées des données transformées et note la source, la date, le séparateur, l'encodage et les types. Si le projet utilise `renv`, respecte son environnement et ne mets pas à jour les packages sans demande.

Pour un CSV français, inspecte les premières lignes puis importe explicitement :

```r
donnees <- read.csv2("data/entree.csv",
  stringsAsFactors = FALSE,
  na.strings = c("", "NA", "nd"),
  colClasses = c(code = "character")
)
stopifnot(is.character(donnees$code))
```

Avec `readr`, précise `locale = locale(decimal_mark = ",", encoding = "UTF-8")` et les `col_types`. Un identifiant comme `01001` ne doit jamais être importé comme nombre. Vérifie `str()`, les plages, les doublons et les manquants après import.

Avant export, vérifie la clé, le nombre de lignes et les classes. Pour un CSV destiné à un échange, exporte les colonnes utiles explicitement et documente le séparateur. Évite `setwd()`, `rm(list = ls())`, `load()` dans l'environnement global et les chemins personnels.
