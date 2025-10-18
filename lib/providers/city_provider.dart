import 'package:flutter/widgets.dart';
import 'package:surverior_frontend_mobile/models/city.dart';
import 'package:surverior_frontend_mobile/services/city_service.dart';

class CityProvider with ChangeNotifier {
  final _service = CityService();

  List<City>? _cities;

  List<City>? get cities => _cities;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = '';

  String get error => _error;

  Future<void> fetchCities() async {
    if (_isLoading) return; // Prevent multiple calls

    _isLoading = true;
    _error = '';

    // Schedule notification for next frame to avoid build phase conflict
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _cities = await _service.fetchCities();
    } catch (e) {
      _error = e.toString();
      _cities = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCities() {
    _cities = null;
    _error = '';
    notifyListeners();
  }
}
