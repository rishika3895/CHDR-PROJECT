import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vital_record.dart';
import '../services/vitals_service.dart';

class VitalsEntryScreen extends StatefulWidget {
  const VitalsEntryScreen({super.key});

  @override
  State<VitalsEntryScreen> createState() => _VitalsEntryScreenState();
}

class _VitalsEntryScreenState extends State<VitalsEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectIdController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();

  @override
  void dispose() {
    _subjectIdController.dispose();
    _heartRateController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final heartRate = int.parse(_heartRateController.text);
      
      if (heartRate > 100) {
        final shouldContinue = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('High Heart Rate Alert'),
            content: Text(
              'Heart rate of $heartRate bpm exceeds normal range (>100). '
              'Do you want to continue?'
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Continue'),
              ),
            ],
          ),
        );
        
        if (shouldContinue != true) return;
      }

      final record = VitalRecord(
        subjectId: _subjectIdController.text,
        heartRate: heartRate,
        bloodPressure: '${_systolicController.text}/${_diastolicController.text}',
      );

      final service = context.read<VitalsService>();
      final result = await service.submitVitals(record);

      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vitals saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _clearForm();
      }
    }
  }

  void _clearForm() {
    _subjectIdController.clear();
    _heartRateController.clear();
    _systolicController.clear();
    _diastolicController.clear();
    context.read<VitalsService>().resetStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinical Vitals Entry'),
        elevation: 2,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter Patient Vitals',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    TextFormField(
                      controller: _subjectIdController,
                      decoration: const InputDecoration(
                        labelText: 'Subject ID',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Subject ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _heartRateController,
                      decoration: const InputDecoration(
                        labelText: 'Heart Rate (bpm)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.favorite),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter heart rate';
                        }
                        final hr = int.tryParse(value);
                        if (hr == null || hr < 30 || hr > 250) {
                          return 'Heart rate must be between 30 and 250';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _systolicController,
                            decoration: const InputDecoration(
                              labelText: 'Systolic',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              final val = int.tryParse(value);
                              if (val == null || val < 50 || val > 250) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('/', style: TextStyle(fontSize: 24)),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _diastolicController,
                            decoration: const InputDecoration(
                              labelText: 'Diastolic',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              final val = int.tryParse(value);
                              if (val == null || val < 30 || val > 150) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    Consumer<VitalsService>(
                      builder: (context, service, child) {
                        return Column(
                          children: [
                            _buildSyncStatusIndicator(service.syncStatus),
                            const SizedBox(height: 16),
                            
                            ElevatedButton(
                              onPressed: service.syncStatus == SyncStatus.syncing
                                  ? null
                                  : _submitForm,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: service.syncStatus == SyncStatus.syncing
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Text('Submit Vitals'),
                            ),
                            
                            if (service.errorMessage != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                service.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSyncStatusIndicator(SyncStatus status) {
    IconData icon;
    Color color;
    String text;

    switch (status) {
      case SyncStatus.idle:
        icon = Icons.cloud_outlined;
        color = Colors.grey;
        text = 'Ready to sync';
        break;
      case SyncStatus.syncing:
        icon = Icons.cloud_upload;
        color = Colors.blue;
        text = 'Syncing...';
        break;
      case SyncStatus.success:
        icon = Icons.cloud_done;
        color = Colors.green;
        text = 'Synced successfully';
        break;
      case SyncStatus.error:
        icon = Icons.cloud_off;
        color = Colors.red;
        text = 'Sync failed';
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
