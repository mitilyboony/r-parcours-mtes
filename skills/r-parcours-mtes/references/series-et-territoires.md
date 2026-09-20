# Séries temporelles et référentiels territoriaux

Une évolution est calculée après tri par identifiant et période :

```r
evolutions <- donnees |>
  arrange(code, annee) |>
  group_by(code) |>
  mutate(valeur_precedente = lag(valeur), variation = valeur - valeur_precedente) |>
  ungroup()
```

Contrôle les doublons par période, les périodes absentes et les dénominateurs nuls. `lag()` signifie observation précédente, pas nécessairement année précédente. Une fenêtre de 12 observations n'est une fenêtre de 12 mois que si le calendrier est complet.

Pour les territoires, conserve le millésime du référentiel (COG), documente les changements de périmètre et ne somme jamais des taux. Pour un taux agrégé, recalcule le ratio à partir des grandeurs pertinentes ; pour un prix au m², distingue ratio des sommes et moyenne des ratios individuels.
