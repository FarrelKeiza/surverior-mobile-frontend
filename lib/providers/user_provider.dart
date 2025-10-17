import 'package:flutter/foundation.dart';
import 'package:surverior_frontend_mobile/models/user_profile_model.dart';
import 'package:surverior_frontend_mobile/models/user_model.dart';
import 'package:surverior_frontend_mobile/models/end_user_model.dart';
import 'package:surverior_frontend_mobile/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService();
  UserProfileModel? _userProfileModel;

  UserProfileModel? get userProfileModel => _userProfileModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  // Getters for user data
  UserModel? get user => _userProfileModel?.data?.user;
  EndUserModel? get endUser => _userProfileModel?.data?.endUser;

  // Quick access getters
  String? get userName => user?.name;
  String? get userEmail => user?.email;
  String? get userNik => endUser?.nik;
  String? get userGender => endUser?.gender;
  String? get userBirthdate => endUser?.birthdate;
  String? get userDomicile => endUser?.domicile;
  String? get userMarriedStatus => endUser?.marriedStatus;
  bool? get userIsAcademic => endUser?.isAcademic;
  String? get userReason => endUser?.reason;
  String? get userProfilePhotoUrl => endUser?.profilePhotoUrl;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  // Method untuk mengambil data profile user
  Future<bool> fetchUserProfile() async {
    setLoading(true);
    clearError();

    try {
      final data = await _userService.getUserProfile();
      _userProfileModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("User Profile Response received");
        print("Metadata code: ${_userProfileModel?.metadata?.code}");
        print("User name: ${_userProfileModel?.data?.user?.name}");
        print("User email: ${_userProfileModel?.data?.user?.email}");
      }

      if (_userProfileModel?.metadata?.code == 200) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setError(_userProfileModel?.metadata?.message ??
            'Failed to fetch user profile');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError(e.toString());
      if (kDebugMode) {
        print("User Profile Error: $e");
      }
      return false;
    }
  }

  // Method untuk update profile user
  Future<bool> updateUserProfile({
    String? name,
    String? nik,
    String? gender,
    String? birthdate,
    String? domicile,
    String? marriedStatus,
    String? profilePhotoUrl,
  }) async {
    setLoading(true);
    clearError();

    try {
      final data = await _userService.updateUserProfile(
        name: name,
        nik: nik,
        gender: gender,
        birthdate: birthdate,
        domicile: domicile,
        marriedStatus: marriedStatus,
        profilePhotoUrl: profilePhotoUrl,
      );
      _userProfileModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Update Profile Response received");
        print("Metadata code: ${_userProfileModel?.metadata?.code}");
        print("Updated user name: ${_userProfileModel?.data?.user?.name}");
      }

      if (_userProfileModel?.metadata?.code == 200) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setError(_userProfileModel?.metadata?.message ??
            'Failed to update user profile');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError(e.toString());
      if (kDebugMode) {
        print("Update Profile Error: $e");
      }
      return false;
    }
  }

  // Method untuk clear user data (saat logout)
  void clearUserData() {
    _userProfileModel = null;
    _error = '';
    _isLoading = false;
    notifyListeners();
  }

  // Method untuk refresh user profile
  Future<void> refreshUserProfile() async {
    await fetchUserProfile();
  }

  // Helper methods untuk format data
  String getFormattedGender() {
    switch (userGender?.toLowerCase()) {
      case 'm':
      case 'male':
        return 'Laki-laki';
      case 'f':
      case 'female':
        return 'Perempuan';
      default:
        return 'Tidak diketahui';
    }
  }

  String getFormattedMarriedStatus() {
    switch (userMarriedStatus?.toLowerCase()) {
      case 'married':
        return 'Menikah';
      case 'unmarried':
      case 'single':
        return 'Belum Menikah';
      case 'divorced':
        return 'Bercerai';
      case 'widowed':
        return 'Janda/Duda';
      default:
        return 'Tidak diketahui';
    }
  }

  String getFormattedAcademicStatus() {
    return userIsAcademic == true ? 'Akademisi' : 'Non-Akademisi';
  }

  // Method untuk format birthdate
  String getFormattedBirthdate() {
    if (userBirthdate == null) return 'Tidak diketahui';

    try {
      DateTime date = DateTime.parse(userBirthdate!);
      List<String> months = [
        '',
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];

      return '${date.day} ${months[date.month]} ${date.year}';
    } catch (e) {
      return userBirthdate ?? 'Tidak diketahui';
    }
  }
}
