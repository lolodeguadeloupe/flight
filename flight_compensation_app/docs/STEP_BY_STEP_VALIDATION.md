# Système de Validation Étape par Étape

## Vue d'ensemble

Le système de validation étape par étape permet aux utilisateurs de remplir progressivement leur réclamation de vol, avec validation en temps réel et sauvegarde automatique des données.

## Architecture

### Composants principaux

#### 1. Entités du domaine (`claim_form_step.dart`)
- **FormStepType** : Énumération des types d'étapes
- **StepValidationStatus** : État de validation de chaque étape
- **FormFieldError** : Représentation des erreurs de champ
- **FormStepData** : Données d'une étape avec validation
- **ClaimFormState** : État global du formulaire

#### 2. Cas d'usage (`usecases/`)
- **ValidateFormStepUseCase** : Validation métier de chaque étape
- **CalculateCompensationUseCase** : Calcul de l'indemnisation selon EC261

#### 3. Repository (`repositories/`)
- **ClaimFormRepository** : Interface pour la persistance
- **ClaimFormRepositoryImpl** : Implémentation avec Supabase

#### 4. Providers Riverpod (`providers/`)
- **ClaimFormNotifier** : Gestion d'état avec Riverpod
- **Providers utilitaires** : Providers dérivés pour l'UI

## Flux de validation

### 1. Initialisation
```dart
// Création d'un nouveau formulaire ou chargement d'un brouillon
await ref.read(claimFormProvider.notifier).initializeForm(userId, draftId: optionalDraftId);
```

### 2. Saisie utilisateur
- Les contrôleurs de texte écoutent les changements
- Debouncing automatique (500ms) pour éviter trop d'appels
- Sauvegarde automatique à chaque modification

### 3. Validation en temps réel
```dart
// Validation déclenchée automatiquement
void _updateStepData(int stepIndex) {
  // Collecte des données
  Map<String, dynamic> data = {...};
  
  // Sauvegarde avec validation
  ref.read(claimFormProvider.notifier).updateStepData(stepIndex, data);
}
```

### 4. Navigation entre étapes
- **Suivant** : Disponible seulement si l'étape actuelle est valide
- **Précédent** : Toujours disponible (sauf première étape)
- **Soumission** : Disponible seulement si toutes les étapes sont complétées

## Validation par étape

### Étape 1 : Informations du vol
**Champs requis :**
- `flight_number` : Format IATA (ex: AF1234)
- `departure_date` : Date valide
- `departure_airport` : Code IATA 3 lettres
- `arrival_airport` : Code IATA 3 lettres (différent du départ)

**Règles de validation :**
```dart
bool _validateFlightInfo(Map<String, dynamic> data) {
  // Numéro de vol au format IATA
  if (!RegExp(r'^[A-Z]{2,3}[0-9]{1,4}$').hasMatch(flightNumber)) {
    errors.add(FormFieldError(field: 'flight_number', message: 'Format invalide'));
  }
  
  // Aéroports différents
  if (departureAirport == arrivalAirport) {
    errors.add(FormFieldError(field: 'arrival_airport', message: 'Doit être différent'));
  }
}
```

### Étape 2 : Détails du retard
**Champs requis :**
- `delay_duration` : Durée ≥ 3 heures
- `delay_reason` : Description ≥ 10 caractères

**Calcul automatique :**
- Indemnisation calculée selon EC261
- Affichage en temps réel du montant estimé

### Étape 3 : Informations personnelles
**Champs requis :**
- `passenger_name` : Prénom + nom
- `passenger_email` : Format email valide
- `passenger_address` : Adresse complète ≥ 10 caractères
- `passenger_phone` : Optionnel, format international

### Étape 4 : Récapitulatif
- Affichage de toutes les données saisies
- Validation finale avant soumission
- Bouton de soumission activé seulement si tout est valide

## Persistance des données

### Structure en base de données

#### Table `claim_drafts`
```sql
CREATE TABLE claim_drafts (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  form_id TEXT UNIQUE, -- ID généré côté client
  current_step INTEGER DEFAULT 0,
  steps_data JSONB, -- Données de toutes les étapes
  estimated_compensation DECIMAL(10,2),
  is_active BOOLEAN DEFAULT true,
  submitted_claim_id UUID REFERENCES claims(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

#### Format JSON des étapes
```json
{
  "type": "flightInfo",
  "data": {
    "flight_number": "AF1234",
    "departure_date": "01/01/2024",
    "departure_airport": "CDG",
    "arrival_airport": "JFK"
  },
  "validation_status": "valid",
  "errors": [],
  "last_modified": "2024-01-01T12:00:00Z",
  "completed_at": "2024-01-01T12:05:00Z"
}
```

### Audit et traçabilité

#### Table `form_audit_log`
- Trace toutes les modifications
- Stockage des anciennes/nouvelles valeurs
- Identification des actions utilisateur

## Interface utilisateur

### Indicateurs visuels

#### Barre de progression
- **Globale** : Pourcentage de completion
- **Par étape** : État visuel (en cours, valide, erreur, complétée)

#### Couleurs
- 🔵 **Bleu** : Étape actuelle
- 🟢 **Vert** : Étape complétée
- 🔴 **Rouge** : Étape avec erreurs
- ⚪ **Gris** : Étape non commencée

#### Affichage des erreurs
```dart
if (stepErrors.isNotEmpty)
  Container(
    decoration: BoxDecoration(color: Colors.red[50]),
    child: Column(
      children: stepErrors.map((error) => 
        Text('• ${error.message}')
      ).toList(),
    ),
  )
```

### Sauvegarde automatique
- Indicateur visuel "Sauvé" dans l'AppBar
- Debouncing pour éviter trop de requêtes
- Gestion des erreurs de réseau

## Calcul d'indemnisation

### Règles EC261 (Union Européenne)

#### Distance et compensation
- **≤ 1500 km** : 250€ pour 3h+ de retard
- **1500-3500 km** : 400€ pour 3h+ de retard  
- **> 3500 km** : 600€ pour 4h+ de retard, 300€ pour 3-4h

#### Aéroports européens
```dart
const europeanAirports = {
  'CDG', 'LHR', 'FRA', 'AMS', 'MAD', 'FCO', 'MUC', 'ZUR', 'VIE', 'CPH',
  // ... liste complète
};
```

### Autres réglementations
- **Brésil (ANAC400)** : Compensation variable
- **États-Unis** : Compensation limitée
- **Autres** : Calcul par défaut basé sur la distance

## Gestion d'erreurs

### Types d'erreurs
- **ValidationFailure** : Erreurs de validation métier
- **NetworkFailure** : Problèmes de connectivité
- **ServerFailure** : Erreurs serveur
- **UnauthorizedFailure** : Problèmes d'authentification

### Stratégies de récupération
```dart
result.fold(
  (failure) => {
    if (failure.isRetryable) {
      // Proposer un retry
    } else if (failure.requiresUserAction) {
      // Demander une action utilisateur
    }
  },
  (success) => // Continuer le flux
);
```

## Tests

### Tests unitaires
- **ValidateFormStepUseCase** : Validation de chaque étape
- **CalculateCompensationUseCase** : Calculs d'indemnisation
- **ClaimFormNotifier** : Gestion d'état

### Tests d'intégration
- Persistance en base de données
- Flux complet de soumission
- Gestion des erreurs réseau

### Couverture
- Objectif : 90%+ sur la logique métier
- Tests de tous les cas d'erreur
- Validation des contraintes de données

## Déploiement

### Migrations SQL
1. `003_create_claim_drafts_table.sql`
2. `004_update_claims_table.sql`
3. `005_create_form_audit_log.sql`

### Variables d'environnement
- `SUPABASE_URL` : URL du projet Supabase
- `SUPABASE_ANON_KEY` : Clé publique Supabase

### Politiques RLS
- Isolation des données par utilisateur
- Permissions lecture/écriture appropriées
- Audit des accès

## Performances

### Optimisations
- **Debouncing** : Évite trop d'appels API
- **Index database** : Requêtes optimisées
- **Cache local** : Réduction des appels réseau
- **Pagination** : Pour la liste des brouillons

### Monitoring
- Temps de réponse des validations
- Taux d'erreur de sauvegarde
- Utilisation de la bande passante

## Sécurité

### Validation côté serveur
- Re-validation de toutes les données
- Protection contre l'injection SQL
- Sanitization des entrées

### Authentification
- JWT tokens avec Supabase
- Refresh automatique des tokens
- Gestion des sessions expirées

### Chiffrement
- HTTPS obligatoire
- Chiffrement des données sensibles
- Hachage des mots de passe

## Évolutions futures

### Fonctionnalités planifiées
- **Sauvegarde hors ligne** : Persistance locale
- **Notifications push** : Rappels de completion
- **Upload de documents** : Intégration scan OCR
- **Multi-langues** : Internationalisation

### Améliorations techniques
- **GraphQL** : Remplacement de REST
- **WebSockets** : Mise à jour en temps réel
- **PWA** : Application web progressive
- **Tests E2E** : Automatisation complète