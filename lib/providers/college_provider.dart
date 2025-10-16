import 'package:flutter/widgets.dart';

import 'package:surverior_frontend_mobile/models/college.dart';
import 'package:surverior_frontend_mobile/services/college_service.dart';

class CollegeProvider with ChangeNotifier {
  final _service = CollegeService();

  List<College>? _colleges;

  List<College>? get colleges => _colleges;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = '';

  String get error => _error;

  Future<void> fetchColleges() async {
    if (_isLoading) return; // Prevent multiple concurrent calls

    _isLoading = true;
    _error = '';

    // Notify after the current frame to avoid build-phase conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _colleges = await _service.fetchColleges();
    } catch (e) {
      _error = e.toString();
      _colleges = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearColleges() {
    _colleges = null;
    _error = '';
    notifyListeners();
  }
}
