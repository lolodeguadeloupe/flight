# Commande Git Worktree

Cette commande permet de créer et gérer des espaces de travail Git pour réaliser des tâches parallèles sur différentes branches.

## Utilisation

```
/worktree <action> [options]
```

## Actions disponibles

### Créer un nouvel espace de travail
```
/worktree create <nom-branche> [chemin-destination]
```
- Crée une nouvelle branche et un espace de travail associé
- Si le chemin n'est pas spécifié, utilise le format: `../<nom-branche>`

### Lister les espaces de travail
```
/worktree list
```
- Affiche tous les espaces de travail actifs

### Supprimer un espace de travail
```
/worktree remove <nom-branche>
```
- Supprime l'espace de travail et la branche associée

### Nettoyer les espaces de travail
```
/worktree cleanup
```
- Supprime tous les espaces de travail inactifs

### Basculer vers un espace de travail
```
/worktree switch <nom-branche>
```
- Change le répertoire de travail vers l'espace de travail spécifié

## Exemples

```bash
# Créer un espace de travail pour une nouvelle fonctionnalité
/worktree create feature/user-authentication

# Créer un espace de travail dans un chemin spécifique
/worktree create bugfix/login-issue ../fixes/login-issue

# Lister tous les espaces de travail
/worktree list

# Supprimer un espace de travail
/worktree remove feature/user-authentication

# Basculer vers un espace de travail
/worktree switch feature/user-authentication
```

## Fonctionnalités

- **Gestion automatique des branches** : Crée automatiquement une nouvelle branche pour chaque espace de travail
- **Isolation des modifications** : Chaque espace de travail a son propre répertoire de travail
- **Synchronisation facile** : Les modifications peuvent être mergées facilement entre les branches
- **Nettoyage automatique** : Suppression propre des espaces de travail inutilisés

## Avantages

1. **Parallélisation** : Travaillez sur plusieurs fonctionnalités simultanément
2. **Isolation** : Évitez les conflits entre différentes tâches
3. **Performance** : Plus rapide que les branches classiques pour les gros projets
4. **Flexibilité** : Chaque espace de travail peut avoir ses propres dépendances

## Notes importantes

- Assurez-vous d'avoir Git 2.5+ pour utiliser les worktrees
- Les espaces de travail partagent le même `.git` directory
- Utilisez `git worktree list` pour voir tous les espaces de travail actifs
- N'oubliez pas de faire `git worktree remove` avant de supprimer manuellement un répertoire
- Les modifications non commitées dans un espace de travail peuvent être perdues lors de la suppression
