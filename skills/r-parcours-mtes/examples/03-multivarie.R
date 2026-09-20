set.seed(42)
donnees_acp <- scale(iris[, 1:4]); acp <- prcomp(donnees_acp, center = FALSE, scale. = FALSE)
coord_acp <- as.data.frame(acp$x[, 1:2]); names(coord_acp) <- c("axe1", "axe2"); coord_acp$espece <- iris$Species
