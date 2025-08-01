import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'core/network/supabase_client.dart';

class TestSupabasePage extends StatefulWidget {
  const TestSupabasePage({super.key});

  @override
  State<TestSupabasePage> createState() => _TestSupabasePageState();
}

class _TestSupabasePageState extends State<TestSupabasePage> {
  String _status = 'Non testé';
  bool _testing = false;

  Future<void> _testConnection() async {
    setState(() {
      _testing = true;
      _status = 'Test en cours...';
    });

    try {
      print('🔍 Testing Supabase connection...');
      
      // Test 1: Vérifier si l'endpoint existe
      final client = SupabaseConfig.client;
      print('Client créé avec succès');
      
      // Test 2: Ping simple
      final response = await SupabaseConfig.from('claims')
          .select('count')
          .count();
      
      print('✅ Count response: ${response.count}');
      
      setState(() {
        _status = 'Connexion réussie! Nombre de claims: ${response.count}';
      });
    } catch (error, stackTrace) {
      print('❌ Connection error: $error');
      print('Stack trace: $stackTrace');
      
      setState(() {
        _status = 'Erreur détaillée: $error';
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }

  Future<void> _testInsert() async {
    setState(() {
      _testing = true;
      _status = 'Test insertion...';
    });

    try {
      print('🔍 Testing table structure first...');
      
      // D'abord, essayer de récupérer un enregistrement pour voir la structure
      try {
        final existing = await SupabaseConfig.from('claims').select().limit(1);
        print('✅ Table claims exists. Sample: $existing');
      } catch (e) {
        print('⚠️ No existing records or table issue: $e');
      }
      
      print('📝 Attempting insert...');
      
      // D'abord, vérifier si nous avons un utilisateur connecté
      final currentUser = SupabaseConfig.auth.currentUser;
      if (currentUser == null) {
        print('⚠️ No authenticated user, creating test user...');
        
        // Créer un utilisateur de test temporaire
        final testEmail = 'test-${DateTime.now().millisecondsSinceEpoch}@test.com';
        final testPassword = 'TestPassword123!';
        
        try {
          final authResponse = await SupabaseConfig.auth.signUp(
            email: testEmail,
            password: testPassword,
          );
          
          if (authResponse.user != null) {
            print('✅ Test user created: ${authResponse.user!.id}');
          } else {
            throw Exception('Failed to create test user');
          }
        } catch (authError) {
          setState(() {
            _status = 'Erreur création utilisateur test: $authError';
          });
          return;
        }
      }
      
      final userId = SupabaseConfig.auth.currentUser?.id;
      if (userId == null) {
        setState(() {
          _status = 'Impossible d\'obtenir l\'ID utilisateur';
        });
        return;
      }
      
      print('📝 Attempting insert with user ID: $userId');
      
      // Essayer l'insertion avec un user_id valide
      final response = await SupabaseConfig.from('claims').insert({
        'user_id': userId,
        'flight_number': 'TEST123',
        'departure_date': '2024-01-01', // Format ISO
        'departure_airport': 'CDG',
        'arrival_airport': 'JFK',
        'delay_duration': 4,
        'delay_reason': 'Test de connexion',
        'passenger_name': 'Test User',
        'passenger_email': 'test@test.com',
        'estimated_compensation': 600.0,
        'status': 'DRAFT',
      }).select();
      
      print('✅ Insert successful: $response');
      
      setState(() {
        _status = 'Insertion réussie! Données: $response';
      });
    } catch (error) {
      print('❌ Insert failed: $error');
      
      // Analyser le type d'erreur
      String errorMessage = 'Erreur insertion: $error';
      
      if (error.toString().contains('relation "claims" does not exist')) {
        errorMessage = 'Table "claims" n\'existe pas dans la base de données';
      } else if (error.toString().contains('column') && error.toString().contains('does not exist')) {
        errorMessage = 'Colonne manquante dans la table claims: $error';
      } else if (error.toString().contains('violates not-null constraint')) {
        errorMessage = 'Champ obligatoire manquant: $error';
      } else if (error.toString().contains('permission denied')) {
        errorMessage = 'Permissions insuffisantes pour insérer dans la table claims';
      }
      
      setState(() {
        _status = errorMessage;
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }

  Future<void> _testHealthCheck() async {
    setState(() {
      _testing = true;
      _status = 'Health check en cours...';
    });

    try {
      // Utiliser le client Supabase au lieu de Dio direct
      print('🏥 Testing health check...');
      
      // Test simple: essayer d'accéder à une table système ou faire un ping simple
      final response = await SupabaseConfig.from('claims').select('count').count();
      
      print('Health check response - can access DB: ${response.count}');
      
      setState(() {
        _status = 'Health check réussi! Base de données accessible.';
      });
    } catch (error) {
      print('❌ Health check failed: $error');
      
      setState(() {
        _status = 'Erreur health check: $error';
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }

  Future<void> _testTableStructure() async {
    setState(() {
      _testing = true;
      _status = 'Vérification structure DB...';
    });

    try {
      print('🔍 Checking database structure...');
      
      // Essayer de lister les tables via une requête d'information
      // Note: Cela peut nécessiter des permissions spéciales
      try {
        final tablesInfo = await SupabaseConfig.client.rpc('get_table_info');
        print('📋 Tables info: $tablesInfo');
        
        setState(() {
          _status = 'Tables trouvées: $tablesInfo';
        });
      } catch (e) {
        print('⚠️ Cannot get table info via RPC: $e');
        
        // Alternative: essayer de faire un SELECT sur différentes tables
        final List<String> tablesToCheck = ['claims', 'users', 'flights', 'documents'];
        final Map<String, String> tableStatus = {};
        
        for (String table in tablesToCheck) {
          try {
            await SupabaseConfig.from(table).select('*').limit(0);
            tableStatus[table] = '✅ Existe';
          } catch (e) {
            if (e.toString().contains('does not exist')) {
              tableStatus[table] = '❌ N\'existe pas';
            } else if (e.toString().contains('permission denied')) {
              tableStatus[table] = '🔒 Permission refusée';
            } else {
              tableStatus[table] = '⚠️ Erreur: ${e.toString().substring(0, 50)}...';
            }
          }
        }
        
        setState(() {
          _status = 'Status des tables:\n${tableStatus.entries.map((e) => '${e.key}: ${e.value}').join('\n')}';
        });
      }
      
    } catch (error) {
      print('❌ Structure check failed: $error');
      
      setState(() {
        _status = 'Erreur vérification structure: $error';
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }

  Future<void> _cleanupTestData() async {
    setState(() {
      _testing = true;
      _status = 'Nettoyage des données test...';
    });

    try {
      print('🧹 Cleaning up test data...');
      
      // Supprimer les réclamations de test
      final deleteResult = await SupabaseConfig.from('claims')
          .delete()
          .match({'flight_number': 'TEST123'});
      
      print('✅ Deleted test claims');
      
      // Optionnel: supprimer les utilisateurs de test (nécessite des permissions admin)
      // Pour l'instant, on se contente de se déconnecter
      await SupabaseConfig.auth.signOut();
      
      setState(() {
        _status = 'Nettoyage terminé. Données test supprimées et utilisateur déconnecté.';
      });
      
    } catch (error) {
      print('❌ Cleanup failed: $error');
      
      setState(() {
        _status = 'Erreur lors du nettoyage: $error';
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Supabase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status de connexion:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(_status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _testing ? null : _testConnection,
              child: _testing
                  ? const CircularProgressIndicator()
                  : const Text('Tester connexion'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testing ? null : _testInsert,
              child: const Text('Tester insertion'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testing ? null : _testHealthCheck,
              child: const Text('Health Check API'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testing ? null : _testTableStructure,
              child: const Text('Vérifier structure DB'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testing ? null : _cleanupTestData,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Nettoyer données test'),
            ),
          ],
        ),
      ),
    );
  }
}