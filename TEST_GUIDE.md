# Guide de Test - Intégration Supabase

## Prérequis

1. **Configuration Supabase** :
   - Créer la table `claims` avec le schéma fourni dans `supabase_schema.sql`
   - Vérifier que les credentials dans `AppConstants` sont corrects
   - Configurer RLS (Row Level Security) si nécessaire

## Tests du Formulaire

### Test 1: Soumission Basique
1. Lancer l'app : `flutter run`
2. Remplir tous les champs obligatoires :
   - **Numéro de vol** : AF1234
   - **Date de départ** : 15/01/2024
   - **Aéroport de départ** : CDG
   - **Aéroport d'arrivée** : JFK
   - **Durée du retard** : 5
   - **Raison du retard** : Retard technique
   - **Nom complet** : Test User
   - **Email** : test@example.com

3. Cliquer "Soumettre la réclamation"
4. **Résultat attendu** : 
   - Loading spinner pendant la soumission
   - Message de succès avec ID de réclamation
   - Formulaire réinitialisé après succès

### Test 2: Calcul de Compensation
1. Entrer une durée de retard : **4 heures**
2. **Résultat attendu** : Indemnité estimée de **600€** (long haul)
3. Changer pour **3 heures**
4. **Résultat attendu** : Indemnité estimée de **400€** (medium haul)
5. Changer pour **2 heures**
6. **Résultat attendu** : "Pas d'indemnité - Retard < 3h"

### Test 3: Validation des Erreurs
1. Essayer de soumettre avec des champs vides
2. **Résultat attendu** : Messages d'erreur sous chaque champ requis
3. Entrer un email invalide (sans @)
4. **Résultat attendu** : Message "Veuillez entrer un email valide"

### Test 4: Option "Autre" pour Raison
1. Sélectionner "Autre" dans raison du retard
2. **Résultat attendu** : Champ de texte "Précisez la raison" apparaît
3. Laisser ce champ vide et essayer de soumettre
4. **Résultat attendu** : Message "Veuillez préciser la raison"

## Vérification Base de Données

### Via Supabase Dashboard
1. Aller sur votre dashboard Supabase
2. Section "Table Editor" > table `claims`
3. Vérifier que les données soumises apparaissent avec :
   - Tous les champs correctement remplis
   - `status` = 'pending'
   - `created_at` et `updated_at` automatiquement générés
   - `id` auto-incrémenté

### Requête SQL Test
```sql
SELECT 
  id,
  flight_number,
  departure_date,
  departure_airport || ' → ' || arrival_airport as route,
  delay_duration,
  delay_reason,
  passenger_name,
  passenger_email,
  estimated_compensation,
  status,
  created_at
FROM claims 
ORDER BY created_at DESC 
LIMIT 5;
```

## Tests d'Erreurs

### Test de Connexion Réseau
1. Désactiver la connexion internet
2. Essayer de soumettre le formulaire
3. **Résultat attendu** : Message d'erreur réseau

### Test de Données Invalides
1. Entrer une durée de retard négative : **-1**
2. **Résultat attendu** : Message "Veuillez entrer un nombre valide"

## Logs de Debug

Pour activer les logs Supabase, modifier dans `supabase_client.dart` :
```dart
await Supabase.initialize(
  url: AppConstants.supabaseUrl,
  anonKey: AppConstants.supabaseAnonKey,
  debug: true, // ← Activer pour voir les requêtes
);
```

## Prochaines Étapes

Une fois les tests de base validés :
1. Implémenter l'authentification utilisateur
2. Ajouter la liste des réclamations utilisateur
3. Intégrer le calcul de compensation via Edge Function
4. Ajouter l'upload de documents (boarding pass, reçus)
5. Configurer les notifications temps réel pour les mises à jour de statut