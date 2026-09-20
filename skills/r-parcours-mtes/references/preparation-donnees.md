# Préparer les données

Définis une ligne, une variable, une clé et l'unité d'observation. Utilise `select()`, `mutate()`, `filter()`, `arrange()`, `group_by()` et `summarise()` avec des noms explicites. Avant une jointure, mesure la cardinalité et les doublons ; après, contrôle les lignes et les orphelins avec `anti_join()`. Pour un pivot large, vérifie l'unicité des clés.

Traite les dates avec une classe `Date`, les codes avec le type caractère et les catégories avec des facteurs. Une valeur manquante n'est zéro que si le dictionnaire le garantit. Après chaque résumé, rapporte `n_total`, `n_valide` et `n_manquant`.

```r
controle <- donnees |>
  dplyr::group_by(groupe) |>
  dplyr::summarise(n_total = dplyr::n(), n_valide = sum(!is.na(valeur)),
    n_manquant = sum(is.na(valeur)), .groups = "drop")
```
