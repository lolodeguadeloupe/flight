# Commande Workspace - Espaces de travail parallèles

Cette commande permet de créer et gérer des espaces de travail isolés pour paralléliser les tâches de développement sur le même projet.

## Utilisation

```
/workspace <action> [options]
```

## Actions disponibles

### Créer un nouvel espace de travail
```
/workspace create <nom-tache> [branche-base]
```
- Crée un nouvel espace de travail isolé pour une tâche spécifique
- Si branche-base n'est pas spécifiée, utilise la branche courante
- Format du répertoire: `../workspace-<nom-tache>`

### Lister les espaces de travail
```
/workspace list
```
- Affiche tous les espaces de travail actifs avec leur statut
- Montre les tâches en cours et leur progression

### Basculer vers un espace de travail
```
/workspace switch <nom-tache>
```
- Change vers l'espace de travail spécifié
- Sauvegarde automatiquement l'état courant

### Synchroniser les espaces
```
/workspace sync <nom-tache>
```
- Synchronise l'espace de travail avec la branche principale
- Résout les conflits automatiquement si possible

### Fusionner un espace de travail
```
/workspace merge <nom-tache>
```
- Fusionne les modifications de l'espace vers la branche principale
- Crée une PR/MR si configuré

### Supprimer un espace de travail
```
/workspace remove <nom-tache>
```
- Supprime l'espace de travail après confirmation
- Propose de sauvegarder les modifications non commitées

### Nettoyer tous les espaces
```
/workspace cleanup
```
- Supprime tous les espaces de travail inactifs
- Archive les espaces avec des modifications importantes

## Exemples

```bash
# Créer un espace pour développer une nouvelle fonctionnalité
/workspace create feature-auth main

# Créer un espace pour corriger un bug
/workspace create bugfix-login-error

# Lister tous les espaces actifs
/workspace list

# Basculer vers un espace de travail
/workspace switch feature-auth

# Synchroniser avec la branche principale
/workspace sync feature-auth

# Fusionner le travail terminé
/workspace merge feature-auth

# Supprimer un espace terminé
/workspace remove feature-auth

# Nettoyer tous les espaces inactifs
/workspace cleanup
```

## Fonctionnalités avancées

### Parallélisation intelligente
- **Isolation complète** : Chaque espace a ses propres dépendances et configuration
- **Synchronisation automatique** : Mise à jour régulière depuis la branche principale
- **Gestion des conflits** : Résolution assistée des conflits de merge
- **Sauvegarde d'état** : Préservation automatique du travail en cours

### Gestion des tâches
- **Suivi de progression** : Statut et avancement de chaque tâche
- **Priorités** : Gestion des priorités entre espaces de travail
- **Dépendances** : Gestion des dépendances entre tâches
- **Notifications** : Alertes pour les conflits ou mises à jour importantes

### Performance
- **Liens symboliques** : Partage des ressources communes (node_modules, .git)
- **Cache partagé** : Optimisation des téléchargements et builds
- **Build parallèle** : Compilation simultanée dans plusieurs espaces
- **Tests isolés** : Exécution de tests sans interférence

## Configuration

### Variables d'environnement
```bash
WORKSPACE_BASE_DIR="../workspaces"     # Répertoire de base des espaces
WORKSPACE_AUTO_SYNC=true               # Synchronisation automatique
WORKSPACE_MAX_SPACES=5                 # Nombre maximum d'espaces actifs
```

### Fichier de configuration (.workspace.json)
```json
{
  "autoSync": true,
  "maxSpaces": 5,
  "baseDir": "../workspaces",
  "sharedDirs": ["node_modules", ".git", "build"],
  "hooks": {
    "postCreate": "flutter pub get",
    "preSwitch": "git stash",
    "postMerge": "flutter test"
  }
}
```

## Workflow recommandé

### 1. Planification
```bash
# Créer des espaces pour différentes tâches
/workspace create feature-payments
/workspace create bugfix-ui-crash  
/workspace create refactor-auth
```

### 2. Développement parallèle
```bash
# Travailler sur les paiements
/workspace switch feature-payments
# Développer la fonctionnalité...

# Basculer vers le bugfix
/workspace switch bugfix-ui-crash
# Corriger le bug...
```

### 3. Synchronisation régulière
```bash
# Synchroniser tous les espaces
/workspace sync --all
```

### 4. Intégration
```bash
# Fusionner le travail terminé
/workspace merge bugfix-ui-crash
/workspace merge feature-payments
```

## Avantages

1. **Productivité** : Travaillez sur plusieurs tâches sans perdre le contexte
2. **Sécurité** : Isolation complète évite les interférences
3. **Flexibilité** : Basculement rapide entre différentes tâches
4. **Collaboration** : Partage facile d'espaces de travail spécifiques
5. **Performance** : Optimisation des ressources partagées

## Cas d'usage

### Développement de fonctionnalités
- Feature branches isolées avec leurs propres environnements
- Tests indépendants sans impact mutuel
- Démonstration de fonctionnalités en cours de développement

### Correction de bugs
- Espaces dédiés pour reproduire et corriger des bugs
- Tests de régression isolés
- Validation indépendante des corrections

### Expérimentation
- Tests de nouvelles technologies ou approches
- Prototypage rapide sans impacter le code principal
- A/B testing de différentes implémentations

## Notes importantes

- **Ressources système** : Chaque espace consomme de l'espace disque et mémoire
- **Synchronisation** : Synchronisez régulièrement pour éviter les conflits majeurs
- **Nettoyage** : Supprimez les espaces inactifs pour libérer les ressources
- **Sauvegarde** : Les modifications non commitées peuvent être perdues
- **Limites** : Configurez un nombre maximum d'espaces actifs selon vos ressources

## Intégration IDE

- Support VSCode avec extension workspace switcher
- Configuration automatique des environnements de développement
- Synchronisation des paramètres et extensions
- Debug parallèle dans différents espaces

---

*Cette commande est optimisée pour les projets Flutter avec support Riverpod et architecture Clean.*