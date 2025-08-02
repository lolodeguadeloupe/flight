# Security Pre-tools - Protection contre les actions dangereuses

## 🛡️ Vue d'ensemble

Ce système de sécurité préventive analyse et bloque automatiquement les opérations potentiellement dangereuses avant leur exécution dans le projet FlightClaim.

## 📋 Fonctionnalités

### 🚫 Actions Interdites

1. **Commandes système dangereuses**
   - `rm -rf /` - Suppression système
   - `sudo rm` - Suppressions avec privilèges
   - `chmod 777` - Permissions dangereuses
   - `curl | sh` / `wget | sh` - Exécution de scripts distants

2. **Opérations réseau suspectes**
   - `netcat` / `nc` - Connexions réseau non autorisées
   - `telnet` - Protocoles non sécurisés
   - Connexions FTP anonymes

3. **Modifications système critiques**
   - Fichiers `/etc/`
   - Binaires système `/usr/bin/`, `/usr/sbin/`
   - Services système `systemctl`, `service`

4. **Élévation de privilèges**
   - `sudo su`, `su root`
   - `sudo -i`, `sudo bash`
   - `pkexec`, `gksudo`

### 🔍 Détection de vulnérabilités

1. **Clés API exposées**
   - Clés OpenAI (sk-...)
   - Clés Google API (AIza...)
   - Clés AWS (AKIA...)
   - Tokens JWT

2. **Mots de passe en dur**
   - Variables password, pwd, secret
   - Chaînes de connexion exposées

3. **Injections SQL potentielles**
   - Concaténation de chaînes suspecte
   - Templates non sécurisés

### 📁 Fichiers protégés

Le système surveille particulièrement :
- `lib/core/network/supabase_client.dart`
- `lib/core/constants/app_constants.dart`
- `.env*` - Variables d'environnement
- `pubspec.yaml` - Configuration Flutter
- Fichiers de build Android/iOS

## 🚀 Utilisation

### Installation

```bash
# Copier le script dans le répertoire du projet
cp pretools-security.js /chemin/vers/projet/

# Rendre exécutable
chmod +x pretools-security.js
```

### Exécution

```bash
# Analyser une commande avant exécution
node pretools-security.js "flutter pub get"

# Analyser une commande complexe
node pretools-security.js "rm -rf node_modules && npm install"
```

### Intégration CI/CD

```yaml
# .github/workflows/security.yml
name: Security Pre-check

on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Security Analysis
        run: |
          node pretools-security.js "flutter build apk"
```

## 📊 Rapport de sécurité

Le script génère automatiquement :

1. **Rapport console** - Affichage immédiat
2. **Fichier JSON** - `security-report.json`
3. **Score de sécurité** - 0-100 points

### Structure du rapport

```json
{
  "timestamp": "2024-01-01T00:00:00.000Z",
  "violations": [
    {
      "type": "FORBIDDEN_COMMAND",
      "severity": "CRITICAL",
      "message": "Commande interdite détectée: rm -rf"
    }
  ],
  "warnings": [
    {
      "type": "PROTECTED_PATH",
      "severity": "MEDIUM",
      "message": "Accès à un fichier protégé"
    }
  ],
  "summary": {
    "totalViolations": 1,
    "totalWarnings": 1,
    "securityScore": 88
  }
}
```

## ⚙️ Configuration

### Personnalisation des règles

Modifiez `SECURITY_RULES` dans le script :

```javascript
const SECURITY_RULES = {
  FORBIDDEN_COMMANDS: [
    // Ajouter vos commandes interdites
    'your-forbidden-command'
  ],
  
  DANGEROUS_FILE_PATTERNS: [
    // Ajouter vos patterns de fichiers
    /\.dangerous$/i
  ]
};
```

### Chemins protégés

Ajoutez vos fichiers sensibles :

```javascript
const PROTECTED_PATHS = [
  'votre/fichier/sensible.dart',
  '.env.production'
];
```

## 🔧 Modes d'exécution

### Mode strict (par défaut)
- Bloque l'exécution en cas de violation
- Code de sortie 1 si problème détecté

### Mode warning
- Affiche les avertissements sans bloquer
- Modification : `process.exit(0)` au lieu de `process.exit(1)`

### Mode audit
- Génère uniquement le rapport
- Pas de blocage d'exécution

## 📈 Niveaux de sévérité

1. **CRITICAL** - Blocage immédiat
   - Commandes destructives
   - Clés API exposées
   - Élévation de privilèges

2. **HIGH** - Avertissement fort
   - Modifications système
   - Fichiers dangereux
   - Mots de passe en dur

3. **MEDIUM** - Surveillance
   - Accès fichiers protégés
   - Patterns suspects
   - Opérations réseau

## 🛠️ Dépannage

### Faux positifs

Pour ignorer un avertissement spécifique :

```bash
# Ajouter un commentaire d'exception
node pretools-security.js "command --security-exception"
```

### Logs de débogage

Activez les logs détaillés :

```bash
DEBUG=true node pretools-security.js "votre-commande"
```

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature
3. Ajouter des tests de sécurité
4. Proposer une pull request

## 📝 License

MIT License - Voir LICENSE pour plus de détails.

---

**Important** : Ce système est conçu comme une protection défensive. Il ne remplace pas les bonnes pratiques de sécurité et les audits réguliers.