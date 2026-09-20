# Scénarios d'évaluation

Ces demandes servent à tester le routage et les décisions du skill :

1. Importer un CSV `;` avec décimales `,`, codes `01001` et `2A004`, puis signaler les manquants.
2. Enrichir une table avec une clé dupliquée et une clé absente ; détecter cardinalité et orphelins.
3. Calculer une évolution avec lignes désordonnées et une année absente.
4. Comparer moyenne par commune et moyenne pondérée par population.
5. Comparer deux groupes de tailles et variances différentes, sans imposer `var.equal = TRUE`.
6. Réaliser une ACP en excluant identifiant, variable constante et variable descriptive supplémentaire.
7. Compter des points dans des polygones, avec une zone vide et un point sur une frontière.
8. Produire un graphique de valeurs préagrégées et l'exporter.

Un bon résultat donne du code autonome, les contrôles et une interprétation mesurée. Il n'installe pas toute la pile pédagogique et ne lance pas de requête réseau cachée.
