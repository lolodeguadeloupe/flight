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
      final response = await SupabaseConfig.from('claims').insert({
        'flight_number': 'TEST123',
        'departure_date': '01/01/2024',
        'departure_airport': 'CDG',
        'arrival_airport': 'JFK',
        'delay_duration': 4,
        'delay_reason': 'Test de connexion',
        'passenger_name': 'Test User',
        'passenger_email': 'test@test.com',
        'estimated_compensation': 600.0,
      }).select().single();
      
      setState(() {
        _status = 'Insertion réussie! ID: ${response['id']}';
      });
    } catch (error) {
      setState(() {
        _status = 'Erreur insertion: $error';
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
      final dio = Dio();
      
      // Test 1: Ping de base
      print('🏥 Testing health check...');
      final response = await dio.get('https://flight-supabase.laurent-luce.com/rest/v1/');
      
      print('Health check response: ${response.statusCode}');
      print('Headers: ${response.headers}');
      
      setState(() {
        _status = 'Health check réussi! Status: ${response.statusCode}';
      });
    } catch (error) {
      print('❌ Health check failed: $error');
      
      // Test si c'est un problème de CORS ou d'URL
      if (error.toString().contains('XMLHttpRequest')) {
        setState(() {
          _status = 'Erreur CORS - Vérifiez les domaines autorisés dans Supabase';
        });
      } else if (error.toString().contains('Failed to fetch')) {
        setState(() {
          _status = 'URL inaccessible - Vérifiez que le serveur Supabase est en ligne';
        });
      } else {
        setState(() {
          _status = 'Erreur health check: $error';
        });
      }
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
          ],
        ),
      ),
    );
  }
}