import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/vital_record.dart';

enum SyncStatus { idle, syncing, success, error }

class VitalsService extends ChangeNotifier {
  static const String baseUrl = '/api/vitals';
  
  SyncStatus _syncStatus = SyncStatus.idle;
  String? _errorMessage;
  
  SyncStatus get syncStatus => _syncStatus;
  String? get errorMessage => _errorMessage;

  Future<VitalRecord?> submitVitals(VitalRecord record) async {
    _syncStatus = SyncStatus.syncing;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(record.toJson()),
      );

      if (response.statusCode == 201) {
        _syncStatus = SyncStatus.success;
        final data = jsonDecode(response.body);
        notifyListeners();
        return VitalRecord.fromJson(data);
      } else {
        _syncStatus = SyncStatus.error;
        _errorMessage = 'Failed to save vitals: ${response.statusCode}';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _syncStatus = SyncStatus.error;
      _errorMessage = 'Network error: $e';
      notifyListeners();
      return null;
    }
  }

  void resetStatus() {
    _syncStatus = SyncStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
