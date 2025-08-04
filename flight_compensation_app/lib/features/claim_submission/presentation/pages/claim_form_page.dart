import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/network/supabase_client.dart';
import '../providers/claim_form_provider.dart';
import '../../domain/entities/claim_form_step.dart';

class ClaimFormPage extends ConsumerStatefulWidget {
  const ClaimFormPage({super.key});

  @override
  ConsumerState<ClaimFormPage> createState() => _ClaimFormPageState();
}

class _ClaimFormPageState extends ConsumerState<ClaimFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _flightNumberController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _departureAirportController = TextEditingController();
  final _arrivalAirportController = TextEditingController();
  final _delayDurationController = TextEditingController();
  final _delayReasonController = TextEditingController();
  final _passengerNameController = TextEditingController();
  final _passengerEmailController = TextEditingController();
  final _passengerPhoneController = TextEditingController();
  final _passengerAddressController = TextEditingController();

  String? _userId;

  @override
  void initState() {
    super.initState();
    _initializeForm();
    _setupControllerListeners();
  }

  @override
  void dispose() {
    _flightNumberController.dispose();
    _departureDateController.dispose();
    _departureAirportController.dispose();
    _arrivalAirportController.dispose();
    _delayDurationController.dispose();
    _delayReasonController.dispose();
    _passengerNameController.dispose();
    _passengerEmailController.dispose();
    _passengerPhoneController.dispose();
    _passengerAddressController.dispose();
    super.dispose();
  }

  void _initializeForm() async {
    // Récupérer l'utilisateur actuel ou créer un utilisateur temporaire
    var currentUser = SupabaseConfig.auth.currentUser;
    if (currentUser == null) {
      // Pour les tests, créer un utilisateur temporaire
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempEmail = 'temp_$timestamp@example.com';
      
      try {
        final authResponse = await SupabaseConfig.auth.signUp(
          email: tempEmail,
          password: 'TempPassword123!',
        );
        currentUser = authResponse.user;
      } catch (e) {
        // Si l'inscription échoue, utiliser un ID temporaire
        _userId = 'temp_$timestamp';
      }
    }
    
    if (currentUser != null) {
      _userId = currentUser.id;
    }

    // Initialiser le formulaire
    if (_userId != null) {
      await ref.read(claimFormProvider.notifier).initializeForm(_userId!);
    }
  }

  void _setupControllerListeners() {
    // Écouter les changements pour sauvegarder automatiquement
    _flightNumberController.addListener(() => _updateStepData(0));
    _departureDateController.addListener(() => _updateStepData(0));
    _departureAirportController.addListener(() => _updateStepData(0));
    _arrivalAirportController.addListener(() => _updateStepData(0));
    
    _delayDurationController.addListener(() => _updateStepData(1));
    _delayReasonController.addListener(() => _updateStepData(1));
    
    _passengerNameController.addListener(() => _updateStepData(2));
    _passengerEmailController.addListener(() => _updateStepData(2));
    _passengerPhoneController.addListener(() => _updateStepData(2));
    _passengerAddressController.addListener(() => _updateStepData(2));
  }

  void _updateStepData(int stepIndex) {
    Map<String, dynamic> data = {};
    
    switch (stepIndex) {
      case 0: // Flight info
        data = {
          'flight_number': _flightNumberController.text.toUpperCase(),
          'departure_date': _departureDateController.text,
          'departure_airport': _departureAirportController.text.toUpperCase(),
          'arrival_airport': _arrivalAirportController.text.toUpperCase(),
        };
        break;
      case 1: // Delay info
        data = {
          'delay_duration': _delayDurationController.text,
          'delay_reason': _delayReasonController.text,
        };
        break;
      case 2: // Passenger info
        data = {
          'passenger_name': _passengerNameController.text,
          'passenger_email': _passengerEmailController.text,
          'passenger_phone': _passengerPhoneController.text,
          'passenger_address': _passengerAddressController.text,
        };
        break;
    }
    
    // Debounce la sauvegarde pour éviter trop d'appels
    Future.delayed(const Duration(milliseconds: 500), () {
      ref.read(claimFormProvider.notifier).updateStepData(stepIndex, data);
    });
  }

  void _populateControllers(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      _flightNumberController.text = data['flight_number'] ?? '';
      _departureDateController.text = data['departure_date'] ?? '';
      _departureAirportController.text = data['departure_airport'] ?? '';
      _arrivalAirportController.text = data['arrival_airport'] ?? '';
      _delayDurationController.text = data['delay_duration'] ?? '';
      _delayReasonController.text = data['delay_reason'] ?? '';
      _passengerNameController.text = data['passenger_name'] ?? '';
      _passengerEmailController.text = data['passenger_email'] ?? '';
      _passengerPhoneController.text = data['passenger_phone'] ?? '';
      _passengerAddressController.text = data['passenger_address'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(claimFormProvider);
    final completionPercentage = ref.watch(formCompletionProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle réclamation'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Indicateur de sauvegarde
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: formState.when(
              data: (state) => state.lastSaved != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cloud_done, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Sauvé',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              error: (_, __) => const Icon(Icons.error, color: Colors.red),
            ),
          ),
        ],
      ),
      body: formState.when(
        data: (state) => Column(
          children: [
            _buildProgressIndicator(state, completionPercentage),
            Expanded(
              child: IndexedStack(
                index: state.currentStep,
                children: [
                  _buildFlightInfoStep(state),
                  _buildDelayInfoStep(state),
                  _buildPassengerInfoStep(state),
                  _buildSummaryStep(state),
                ],
              ),
            ),
            _buildNavigationButtons(state),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Erreur: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _initializeForm(),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ClaimFormState state, double completionPercentage) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Column(
        children: [
          // Barre de progression globale
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: completionPercentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${completionPercentage.toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Indicateurs d'étapes
          Row(
            children: List.generate(state.steps.length, (index) {
              final step = state.steps[index];
              final isActive = index == state.currentStep;
              final isCompleted = step.isCompleted;
          
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < state.steps.length - 1 ? 8 : 0),
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? Colors.green 
                              : isActive 
                                  ? Theme.of(context).primaryColor 
                                  : step.hasErrors
                                      ? Colors.red[300]
                                      : Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isCompleted)
                            const Icon(Icons.check_circle, size: 16, color: Colors.green)
                          else if (step.hasErrors)
                            const Icon(Icons.error, size: 16, color: Colors.red),
                          if (isCompleted || step.hasErrors) const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              step.stepTitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                color: isCompleted 
                                    ? Colors.green
                                    : isActive 
                                        ? Theme.of(context).primaryColor 
                                        : step.hasErrors
                                            ? Colors.red
                                            : Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightInfoStep(ClaimFormState state) {
    final stepData = state.steps[0];
    final stepErrors = stepData.errors;
    // Populer les contrôleurs avec les données sauvegardées
    _populateControllers(stepData.data);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informations du vol',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Renseignez les détails de votre vol perturbé',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Affichage des erreurs de l'étape
            if (stepErrors.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error, color: Colors.red[700], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Erreurs dans cette étape:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...stepErrors.map((error) => Text(
                      '• ${error.message}',
                      style: TextStyle(color: Colors.red[700]),
                    )),
                  ],
                ),
              ),
            
            _buildTextField(
              controller: _flightNumberController,
              label: 'Numéro de vol',
              hint: 'Ex: AF1234, BA567',
              icon: Icons.flight,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Le numéro de vol est obligatoire';
                }
                if (!RegExp(r'^[A-Z]{2,3}[0-9]{1,4}$').hasMatch(value!.toUpperCase())) {
                  return 'Format invalide (ex: AF1234)';
                }
                return null;
              },
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [UpperCaseTextFormatter()],
            ),
            
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _departureDateController,
              label: 'Date de départ',
              hint: 'JJ/MM/AAAA',
              icon: Icons.calendar_today,
              readOnly: true,
              onTap: () => _selectDate(context),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'La date de départ est obligatoire';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _departureAirportController,
                    label: 'Aéroport de départ',
                    hint: 'CDG, JFK...',
                    icon: Icons.flight_takeoff,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(3),
                    ],
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Obligatoire';
                      }
                      if (value!.length != 3) {
                        return 'Code à 3 lettres';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _arrivalAirportController,
                    label: 'Aéroport d\'arrivée',
                    hint: 'CDG, JFK...',
                    icon: Icons.flight_land,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(3),
                    ],
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Obligatoire';
                      }
                      if (value!.length != 3) {
                        return 'Code à 3 lettres';
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
    );
  }

  Widget _buildDelayInfoStep(ClaimFormState state) {
    final stepData = state.steps[1];
    final stepErrors = stepData.errors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Détails du retard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Précisez la durée et la raison du retard',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Affichage des erreurs
          if (stepErrors.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border.all(color: Colors.red[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, color: Colors.red[700], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Erreurs dans cette étape:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...stepErrors.map((error) => Text(
                    '• ${error.message}',
                    style: TextStyle(color: Colors.red[700]),
                  )),
                ],
              ),
            ),
          
          _buildTextField(
            controller: _delayDurationController,
            label: 'Durée du retard (en heures)',
            hint: 'Ex: 3.5',
            icon: Icons.access_time,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'La durée du retard est obligatoire';
              }
              final duration = double.tryParse(value!);
              if (duration == null || duration < 0) {
                return 'Durée invalide';
              }
              if (duration < 3) {
                return 'Le retard doit être d\'au moins 3 heures pour une indemnisation';
              }
              return null;
            },
            onChanged: (value) => _calculateCompensation(),
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _delayReasonController,
            label: 'Raison du retard',
            hint: 'Ex: Problème technique, météo défavorable...',
            icon: Icons.info_outline,
            maxLines: 3,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'La raison du retard est obligatoire';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 24),
          
          if (state.estimatedCompensation != null)
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.euro, color: Colors.green[700]),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Indemnisation estimée',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                        Text(
                          '${state.estimatedCompensation!.toStringAsFixed(0)} €',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPassengerInfoStep(ClaimFormState state) {
    final stepData = state.steps[2];
    final stepErrors = stepData.errors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informations personnelles',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ces informations sont nécessaires pour traiter votre réclamation',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Affichage des erreurs
          if (stepErrors.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border.all(color: Colors.red[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, color: Colors.red[700], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Erreurs dans cette étape:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...stepErrors.map((error) => Text(
                    '• ${error.message}',
                    style: TextStyle(color: Colors.red[700]),
                  )),
                ],
              ),
            ),
          
          _buildTextField(
            controller: _passengerNameController,
            label: 'Nom complet',
            hint: 'Prénom Nom',
            icon: Icons.person,
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Le nom est obligatoire';
              }
              if (value!.trim().split(' ').length < 2) {
                return 'Veuillez saisir prénom et nom';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _passengerEmailController,
            label: 'Adresse email',
            hint: 'example@email.com',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'L\'email est obligatoire';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                return 'Format d\'email invalide';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _passengerPhoneController,
            label: 'Téléphone (optionnel)',
            hint: '+33 6 12 34 56 78',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _passengerAddressController,
            label: 'Adresse postale',
            hint: 'Rue, ville, code postal, pays',
            icon: Icons.location_on,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'L\'adresse est obligatoire';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStep(ClaimFormState state) {
    final allData = state.allFormData;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Récapitulatif',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Vérifiez vos informations avant de soumettre',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          _buildSummaryCard('Informations du vol', [
            'Vol: ${allData['flight_number'] ?? ''}',
            'Date: ${allData['departure_date'] ?? ''}',
            'De: ${allData['departure_airport'] ?? ''}',
            'Vers: ${allData['arrival_airport'] ?? ''}',
          ]),
          
          const SizedBox(height: 16),
          
          _buildSummaryCard('Détails du retard', [
            'Durée: ${allData['delay_duration'] ?? ''} heures',
            'Raison: ${allData['delay_reason'] ?? ''}',
            if (state.estimatedCompensation != null)
              'Indemnisation estimée: ${state.estimatedCompensation!.toStringAsFixed(0)} €',
          ]),
          
          const SizedBox(height: 16),
          
          _buildSummaryCard('Informations personnelles', [
            'Nom: ${allData['passenger_name'] ?? ''}',
            'Email: ${allData['passenger_email'] ?? ''}',
            if (allData['passenger_phone']?.isNotEmpty == true)
              'Téléphone: ${allData['passenger_phone']}',
            'Adresse: ${allData['passenger_address'] ?? ''}',
          ]),
          
          const SizedBox(height: 24),
          
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prochaines étapes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Après soumission, votre réclamation sera examinée. Vous recevrez un email de confirmation.',
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildNavigationButtons(ClaimFormState state) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (state.canGoBack)
              Expanded(
                child: OutlinedButton(
                  onPressed: () => ref.read(claimFormProvider.notifier).previousStep(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Précédent'),
                ),
              )
            else
              const Expanded(child: SizedBox()),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: state.isSubmitting 
                    ? null 
                    : state.currentStep == state.steps.length - 1
                        ? _submitClaim
                        : state.canProceedToNext
                            ? () => ref.read(claimFormProvider.notifier).nextStep()
                            : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        state.currentStep == state.steps.length - 1 ? 'Soumettre' : 'Suivant',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitClaim() async {
    final result = await ref.read(claimFormProvider.notifier).submitClaim();
    
    if (mounted) {
      result.fold(
        (failure) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 48),
            title: const Text('Erreur'),
            content: Text('Impossible de soumettre la réclamation: ${failure.message}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        (claimId) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
            title: const Text('Réclamation soumise !'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Votre réclamation a été soumise avec succès.'),
                const SizedBox(height: 8),
                Text(
                  'Numéro de réclamation: $claimId',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Vous recevrez un email de confirmation.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _departureDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}