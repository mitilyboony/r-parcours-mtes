env <- new.env(); source(file.path("skills", "r-parcours-mtes", "examples", "02-statistiques.R"), env)
stopifnot(env$resume["A", "n_valide"] == 2, env$resume["B", "n_valide"] == 1, isTRUE(all.equal(unname(env$correlation_nulle_nest_pas_independance), 0)))
message("test-statistiques: OK")
