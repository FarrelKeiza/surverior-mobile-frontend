import 'package:flutter/widgets.dart';
import 'package:surverior_frontend_mobile/models/education.dart';
import 'package:surverior_frontend_mobile/services/education_service.dart';

class EducationProvider with ChangeNotifier {
  final _service = EducationService();

  List<Education>? _educations;

  List<Education>? get educations => _educations;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = '';

  String get error => _error;

  Future<void> fetchEducations() async {
    if (_isLoading) return; // Prevent multiple calls

    _isLoading = true;
    _error = '';

    // Schedule notification for next frame to avoid build phase conflict
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _educations = await _service.fetchEducations();
    } catch (e) {
      _error = e.toString();
      _educations = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearEducations() {
    _educations = null;
    _error = '';
    notifyListeners();
  }
}
