resume_groupes <- function(data, groupe, valeur) {
  split(data[[valeur]], data[[groupe]]) |> lapply(function(x) c(n_total = length(x), n_valide = sum(!is.na(x)), moyenne = if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE))) |> do.call(what = rbind)
}
donnees_stats <- data.frame(groupe = c("A", "A", "B", "B"), valeur = c(10, 12, 20, NA))
resume <- resume_groupes(donnees_stats, "groupe", "valeur")
correlation_nulle_nest_pas_independance <- cor(-2:2, (-2:2)^2)
