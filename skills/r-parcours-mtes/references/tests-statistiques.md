# Tests et interprétation

Formule la question, le plan d'observation et le paramètre avant de choisir un test. Pour deux groupes indépendants, `t.test()` utilise par défaut Welch ; ne force pas l'égalité des variances sans justification. Pour des données appariées, aligne les unités par identifiant. `wilcox.test()` est un test de rangs/position (ou de symétrie des différences), pas un test générique de moyenne. Le chi-deux doit examiner effectifs attendus et marges nulles. Une p-value ne mesure ni la taille ni l'importance métier de l'effet.
