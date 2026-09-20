# Imports avancés (à la demande)

Les formations présentent Excel (`readxl`), Parquet (`arrow`), JSON (`jsonlite`), SDMX, SQL (`DBI`/`dbplyr`) et des fichiers spatiaux (`sf`). Ces packages ne sont pas des dépendances du noyau.

Pour une base distante, filtre et sélectionne les colonnes côté serveur avec `dbplyr`, puis `collect()` seulement lorsque le volume le permet. Pour Parquet, lis les colonnes nécessaires. Pour une API, enregistre l'URL, la date, les paramètres et la réponse brute lorsque la licence le permet.

N'exécute pas automatiquement de téléchargement, de connexion ou d'installation. Vérifie l'authentification, la licence, la stabilité de l'endpoint et la politique de cache avant de proposer une recette distante.
