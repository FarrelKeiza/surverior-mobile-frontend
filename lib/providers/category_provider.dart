import 'package:flutter/widgets.dart';
import 'package:surverior_frontend_mobile/models/category.dart';
import 'package:surverior_frontend_mobile/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final _service = CategoryService();

  List<Category>? _categories;

  List<Category>? get categories => _categories;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = '';

  String get error => _error;

  Future<void> fetchCategories() async {
    if (_isLoading) return; // Prevent multiple calls

    _isLoading = true;
    _error = '';

    // Schedule notification for next frame to avoid build phase conflict
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _categories = await _service.fetchCategories();
    } catch (e) {
      _error = e.toString();
      _categories = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCategories() {
    _categories = null;
    _error = '';
    notifyListeners();
  }
}
