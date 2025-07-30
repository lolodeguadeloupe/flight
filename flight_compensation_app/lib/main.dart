import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/network/supabase_client.dart';
import 'core/providers/claim_providers.dart';
import 'test_supabase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  runApp(const ProviderScope(child: FlightCompensationApp()));
}

class FlightCompensationApp extends StatelessWidget {
  const FlightCompensationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2), // Aviation blue
        ),
      ),
      home: const TestSupabasePage(), // Temporaire pour debug
      // home: const ClaimFormPage(),
    );
  }
}

class ClaimFormPage extends ConsumerStatefulWidget {
  const ClaimFormPage({super.key});

  @override
  ConsumerState<ClaimFormPage> createState() => _ClaimFormPageState();
}

class _ClaimFormPageState extends ConsumerState<ClaimFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _flightNumberController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _departureAirportController = TextEditingController();
  final _arrivalAirportController = TextEditingController();
  final _delayDurationController = TextEditingController();
  final _passengerNameController = TextEditingController();
  final _passengerEmailController = TextEditingController();
  final _otherDelayReasonController = TextEditingController();

  String? _selectedDelayReason;
  final List<String> _delayReasons = [
    'Retard technique',
    'Conditions météorologiques',
    'Grève du personnel',
    'Problème de trafic aérien',
    'Autre',
  ];

  double? _estimatedCompensation;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _flightNumberController.dispose();
    _departureDateController.dispose();
    _departureAirportController.dispose();
    _arrivalAirportController.dispose();
    _delayDurationController.dispose();
    _passengerNameController.dispose();
    _passengerEmailController.dispose();
    _otherDelayReasonController.dispose();
    super.dispose();
  }

  void _calculateCompensation() {
    if (_formKey.currentState!.validate()) {
      final delayHours = int.tryParse(_delayDurationController.text) ?? 0;
      
      if (delayHours >= 3) {
        // Simple calculation based on EC261 rules
        setState(() {
          if (delayHours >= 4) {
            _estimatedCompensation = AppConstants.ec261Compensation['long_haul'];
          } else {
            _estimatedCompensation = AppConstants.ec261Compensation['medium_haul'];
          }
        });
      } else {
        setState(() {
          _estimatedCompensation = 0;
        });
      }
    }
  }

  Future<void> _submitClaim() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final claimData = ClaimData(
        flightNumber: _flightNumberController.text,
        departureDate: _departureDateController.text,
        departureAirport: _departureAirportController.text,
        arrivalAirport: _arrivalAirportController.text,
        delayDuration: int.parse(_delayDurationController.text),
        delayReason: _selectedDelayReason == 'Autre' 
            ? _otherDelayReasonController.text 
            : _selectedDelayReason!,
        passengerName: _passengerNameController.text,
        passengerEmail: _passengerEmailController.text,
        estimatedCompensation: _estimatedCompensation,
      );

      // Submit claim using provider
      final result = await ref.read(createClaimProvider(claimData).future);

      if (result != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Réclamation enregistrée avec succès! ID: ${result['id']}'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
            ),
          );
          
          // Reset form
          _formKey.currentState!.reset();
          _flightNumberController.clear();
          _departureDateController.clear();
          _departureAirportController.clear();
          _arrivalAirportController.clear();
          _delayDurationController.clear();
          _passengerNameController.clear();
          _passengerEmailController.clear();
          _otherDelayReasonController.clear();
          
          setState(() {
            _selectedDelayReason = null;
            _estimatedCompensation = null;
          });
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la soumission: $error'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réclamation Indemnité Vol'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations du vol',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _flightNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Numéro de vol',
                          hintText: 'ex: AF1234',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le numéro de vol';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _departureDateController,
                        decoration: const InputDecoration(
                          labelText: 'Date de départ',
                          hintText: 'DD/MM/YYYY',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer la date de départ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _departureAirportController,
                              decoration: const InputDecoration(
                                labelText: 'Aéroport de départ',
                                hintText: 'ex: CDG',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Requis';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _arrivalAirportController,
                              decoration: const InputDecoration(
                                labelText: 'Aéroport d\'arrivée',
                                hintText: 'ex: JFK',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Requis';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Détails du retard',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _delayDurationController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Durée du retard (heures)',
                          hintText: 'ex: 4',
                          border: OutlineInputBorder(),
                          suffixText: 'h',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer la durée du retard';
                          }
                          final hours = int.tryParse(value);
                          if (hours == null || hours < 0) {
                            return 'Veuillez entrer un nombre valide';
                          }
                          return null;
                        },
                        onChanged: (value) => _calculateCompensation(),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedDelayReason,
                        decoration: const InputDecoration(
                          labelText: 'Raison du retard',
                          border: OutlineInputBorder(),
                        ),
                        items: _delayReasons.map((reason) {
                          return DropdownMenuItem(
                            value: reason,
                            child: Text(reason),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDelayReason = value;
                            // Clear other reason text when changing selection
                            if (value != 'Autre') {
                              _otherDelayReasonController.clear();
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner une raison';
                          }
                          return null;
                        },
                      ),
                      // Show text field when "Autre" is selected
                      if (_selectedDelayReason == 'Autre') ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _otherDelayReasonController,
                          decoration: const InputDecoration(
                            labelText: 'Précisez la raison',
                            hintText: 'ex: Problème mécanique spécifique...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                          validator: (value) {
                            if (_selectedDelayReason == 'Autre' && 
                                (value == null || value.trim().isEmpty)) {
                              return 'Veuillez préciser la raison';
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations passager',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passengerNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nom complet',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passengerEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          if (!value.contains('@')) {
                            return 'Veuillez entrer un email valide';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (_estimatedCompensation != null) ...[
                const SizedBox(height: 16),
                Card(
                  color: _estimatedCompensation! > 0 
                      ? Colors.green.shade50 
                      : Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Column(
                      children: [
                        Icon(
                          _estimatedCompensation! > 0 
                              ? Icons.check_circle 
                              : Icons.info,
                          color: _estimatedCompensation! > 0 
                              ? Colors.green 
                              : Colors.orange,
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _estimatedCompensation! > 0
                              ? 'Indemnité estimée'
                              : 'Pas d\'indemnité',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _estimatedCompensation! > 0
                              ? '${_estimatedCompensation!.toInt()}€'
                              : 'Retard < 3h',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: _estimatedCompensation! > 0 
                                ? Colors.green.shade700 
                                : Colors.orange.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitClaim,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Soumettre la réclamation',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
