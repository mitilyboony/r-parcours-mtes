# Graphiques et tableaux

Commence par la structure de la donnée et le message à faire passer. Une variable quantitative appelle souvent histogramme, densité, boxplot ou nuage ; une catégorie appelle barres ; plusieurs groupes ou périodes peuvent utiliser facettes.

```r
library(ggplot2)
library(dplyr)

resume <- donnees |>
  group_by(groupe) |>
  summarise(n = sum(!is.na(valeur)), moyenne = mean(valeur, na.rm = TRUE), .groups = "drop")

ggplot(resume, aes(groupe, moyenne, fill = groupe)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "Moyenne (unité)", title = "Moyenne par groupe")
```

`geom_bar()` compte des observations ; `geom_col()` représente une valeur déjà calculée. Mets les variables dans `aes()` et les constantes hors de `aes()`. Pour une échelle logarithmique, vérifie les zéros et valeurs négatives avant de tracer. Une limite d'échelle peut supprimer des observations ; `coord_cartesian()` zoome sans les supprimer.

Avant `facet_wrap()`, vérifie que les axes restent comparables. Pour des intervalles, calcule l'effectif valide et l'écart-type par groupe, et nomme clairement l'intervalle choisi. N'utilise pas un `n` global par commodité.

Exporte un objet nommé avec `ggsave()` et des dimensions explicites. Les thèmes ministériels, `ggiraph`, `leaflet`, `gganimate`, `tmap` et les tableaux HTML sont des extensions à charger uniquement si la sortie le demande.
