env <- new.env(); source(file.path("skills", "r-parcours-mtes", "examples", "03-multivarie.R"), env)
stopifnot(nrow(env$coord_acp) == nrow(iris), all(c("axe1", "axe2", "espece") %in% names(env$coord_acp)))
message("test-multivarie: OK")
