# Compatibilité CLI

Le skill suit le format portable le plus courant : un dossier nommé par le skill, contenant un `SKILL.md` avec un frontmatter YAML `name` et `description`, puis des références et des exemples relatifs. Le contenu ne dépend d'aucun serveur MCP, plugin ou chemin de cette étude.

## Codex

Copier `skills/r-parcours-mtes` vers `$CODEX_HOME/skills/r-parcours-mtes` (ou `~/.codex/skills/r-parcours-mtes` si `CODEX_HOME` n'est pas défini), puis invoquer `$r-parcours-mtes` ou laisser la découverte automatique l'activer.

## Claude Code

Copier le même dossier vers `~/.claude/skills/r-parcours-mtes` (ou `$CLAUDE_HOME/skills/r-parcours-mtes`). Claude Code découvre alors le `SKILL.md` comme une compétence projet ou utilisateur selon l'emplacement. Les chemins relatifs vers `references/` restent valides.

## Autres CLI

Si l'outil documente un répertoire de skills, copiez le dossier complet `skills/r-parcours-mtes` dans ce répertoire. Si l'outil accepte un skill via fichier, fournissez `SKILL.md` et conservez le dossier `references/` voisin ; les liens sont relatifs au fichier d'entrée.

Les scripts d'installation ne font qu'une copie locale. Ils n'installent pas de package R, ne téléchargent pas de données et ne modifient pas un projet existant.
