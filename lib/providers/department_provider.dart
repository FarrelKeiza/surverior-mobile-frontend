import 'package:flutter/widgets.dart';
import 'package:surverior_frontend_mobile/models/department.dart';
import 'package:surverior_frontend_mobile/services/department_service.dart';

class DepartmentProvider with ChangeNotifier {
  final _service = DepartmentService();

  List<Department>? _departments;

  List<Department>? get departments => _departments;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = '';

  String get error => _error;

  Future<void> fetchDepartments() async {
    if (_isLoading) return; // prevent concurrent calls

    _isLoading = true;
    _error = '';

    // notify after current frame to avoid build-phase conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      _departments = await _service.fetchDepartments();
    } catch (e) {
      _error = e.toString();
      _departments = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearDepartments() {
    _departments = null;
    _error = '';
    notifyListeners();
  }
}
