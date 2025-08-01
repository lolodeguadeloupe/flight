import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/network/supabase_client.dart';

class ClaimFormPage extends ConsumerStatefulWidget {
  const ClaimFormPage({super.key});

  @override
  ConsumerState<ClaimFormPage> createState() => _ClaimFormPageState();
}

class _ClaimFormPageState extends ConsumerState<ClaimFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  final int _totalSteps = 4;

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

  bool _isSubmitting = false;
  double? _estimatedCompensation;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle réclamation'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                _buildFlightInfoStep(),
                _buildDelayInfoStep(),
                _buildPassengerInfoStep(),
                _buildSummaryStep(),
              ],
            ),
          ),
          // Debug: Always show buttons
          Container(
            height: 80,
            color: Colors.red[50],
            child: Center(
              child: Text('Navigation Area - Step $_currentStep', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Row(
        children: List.generate(_totalSteps, (index) {
          final isActive = index == _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index < _totalSteps - 1 ? 8 : 0),
              child: Column(
                children: [
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isCompleted || isActive 
                          ? Theme.of(context).primaryColor 
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getStepTitle(index),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isCompleted || isActive 
                          ? Theme.of(context).primaryColor 
                          : Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  String _getStepTitle(int index) {
    switch (index) {
      case 0: return 'Informations\ndu vol';
      case 1: return 'Détails\ndu retard';
      case 2: return 'Informations\npersonnelles';
      case 3: return 'Récapitulatif';
      default: return '';
    }
  }

  Widget _buildFlightInfoStep() {
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

  Widget _buildDelayInfoStep() {
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
          
          if (_estimatedCompensation != null)
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
                          '${_estimatedCompensation!.toStringAsFixed(0)} €',
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

  Widget _buildPassengerInfoStep() {
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

  Widget _buildSummaryStep() {
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
            'Vol: ${_flightNumberController.text}',
            'Date: ${_departureDateController.text}',
            'De: ${_departureAirportController.text}',
            'Vers: ${_arrivalAirportController.text}',
          ]),
          
          const SizedBox(height: 16),
          
          _buildSummaryCard('Détails du retard', [
            'Durée: ${_delayDurationController.text} heures',
            'Raison: ${_delayReasonController.text}',
            if (_estimatedCompensation != null)
              'Indemnisation estimée: ${_estimatedCompensation!.toStringAsFixed(0)} €',
          ]),
          
          const SizedBox(height: 16),
          
          _buildSummaryCard('Informations personnelles', [
            'Nom: ${_passengerNameController.text}',
            'Email: ${_passengerEmailController.text}',
            if (_passengerPhoneController.text.isNotEmpty)
              'Téléphone: ${_passengerPhoneController.text}',
            'Adresse: ${_passengerAddressController.text}',
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

  Widget _buildNavigationButtons() {
    print('Building navigation buttons - Current step: $_currentStep');
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
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
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
              onPressed: _isSubmitting ? null : _nextStep,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
                  : Text(
                      _currentStep == _totalSteps - 1 ? 'Soumettre' : 'Suivant',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      if (_validateCurrentStep()) {
        setState(() {
          _currentStep++;
        });
      }
    } else {
      _submitClaim();
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _validateFlightInfo();
      case 1:
        return _validateDelayInfo();
      case 2:
        return _validatePassengerInfo();
      default:
        return true;
    }
  }

  bool _validateFlightInfo() {
    return _flightNumberController.text.isNotEmpty &&
           _departureDateController.text.isNotEmpty &&
           _departureAirportController.text.length == 3 &&
           _arrivalAirportController.text.length == 3;
  }

  bool _validateDelayInfo() {
    final duration = double.tryParse(_delayDurationController.text);
    return duration != null && 
           duration >= 3 && 
           _delayReasonController.text.isNotEmpty;
  }

  bool _validatePassengerInfo() {
    return _passengerNameController.text.trim().split(' ').length >= 2 &&
           RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_passengerEmailController.text) &&
           _passengerAddressController.text.isNotEmpty;
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

  void _calculateCompensation() {
    final duration = double.tryParse(_delayDurationController.text);
    if (duration != null && duration >= 3) {
      setState(() {
        // Calcul simplifié basé sur EC261
        if (duration >= 4) {
          _estimatedCompensation = 600.0; // Long courrier
        } else {
          _estimatedCompensation = 400.0; // Moyen courrier
        }
      });
    } else {
      setState(() {
        _estimatedCompensation = null;
      });
    }
  }

  Future<void> _submitClaim() async {
    if (!_validateCurrentStep()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Vérifier ou créer un utilisateur
      var currentUser = SupabaseConfig.auth.currentUser;
      if (currentUser == null) {
        // Créer un utilisateur temporaire pour le test
        final authResponse = await SupabaseConfig.auth.signUp(
          email: _passengerEmailController.text,
          password: 'TempPassword123!',
        );
        currentUser = authResponse.user;
      }

      if (currentUser == null) {
        throw Exception('Impossible de créer ou récupérer l\'utilisateur');
      }

      // Insérer la réclamation
      final claimData = {
        'user_id': currentUser.id,
        'flight_number': _flightNumberController.text.toUpperCase(),
        'departure_date': DateFormat('yyyy-MM-dd').format(
          DateFormat('dd/MM/yyyy').parse(_departureDateController.text)
        ),
        'departure_airport': _departureAirportController.text.toUpperCase(),
        'arrival_airport': _arrivalAirportController.text.toUpperCase(),
        'delay_duration': double.parse(_delayDurationController.text).round(),
        'delay_reason': _delayReasonController.text,
        'passenger_name': _passengerNameController.text,
        'passenger_email': _passengerEmailController.text,
        'passenger_phone': _passengerPhoneController.text.isNotEmpty 
            ? _passengerPhoneController.text 
            : null,
        'passenger_address': _passengerAddressController.text,
        'estimated_compensation': _estimatedCompensation,
        'status': 'SUBMITTED',
        'submitted_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseConfig.from('claims')
          .insert(claimData)
          .select()
          .single();

      // Afficher le succès
      if (mounted) {
        showDialog(
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
                  'Numéro de réclamation: ${response['id']}',
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
        );
      }

    } catch (error) {
      // Afficher l'erreur
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red, size: 48),
            title: const Text('Erreur'),
            content: Text('Impossible de soumettre la réclamation: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
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