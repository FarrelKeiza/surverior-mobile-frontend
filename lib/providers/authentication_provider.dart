import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/models/authentication_model.dart';
import 'package:surverior_frontend_mobile/models/otp_model.dart';
import 'package:surverior_frontend_mobile/services/authentication_service.dart';

class AuthenticationProvider with ChangeNotifier {
  final _authenticationService = AuthenticationService();
  AuthenticationModel? _authenticationModel;

  AuthenticationModel? get authenticationModel => _authenticationModel;
  OtpModel? _otpModel;

  OtpModel? get otpModel => _otpModel;
  bool _isObsecure = true;

  bool get isObsecure => _isObsecure;
  bool _isObsecureConfirmation = true;

  bool get isObsecureConfirmation => _isObsecureConfirmation;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // OTP error state
  String _otpError = '';

  String get otpError => _otpError;

  // Pin
  String? _pin;

  String? get pin => _pin;

  set pin(String? value) {
    _pin = value;
    notifyListeners();
  }

  // Signup data storage
  String? _signUpName;
  String? _signUpEmail;
  String? _signUpPassword;
  String? _signUpPasswordConfirmation;
  String? _signUpRoleId;
  String? _signUpEducationId;
  String? _signUpReferralId;
  String? _signUpNik;
  String? _signUpGender;
  String? _signUpBirthdate;
  String? _signUpDomicile;
  String? _signUpMarriedStatus;
  bool? _signUpIsAcademic;
  String? _signUpReason;
  String? _signUpProfilePhotoUrl;
  String? _signUpReferral;
  String? _signUpAcademicId;
  String? _signUpAcademicType;
  String? _signUpDateIn;
  String? _signUpCollege;
  String? _signUpDepartment;
  String? _signUpCollegeId;
  String? _signUpDepartmentId;

  // Getters for signup data
  String? get signUpName => _signUpName;

  String? get signUpEmail => _signUpEmail;

  String? get signUpPassword => _signUpPassword;

  String? get signUpPasswordConfirmation => _signUpPasswordConfirmation;

  String? get signUpRoleId => _signUpRoleId;

  String? get signUpEducationId => _signUpEducationId;

  String? get signUpReferralId => _signUpReferralId;

  String? get signUpNik => _signUpNik;

  String? get signUpGender => _signUpGender;

  String? get signUpBirthdate => _signUpBirthdate;

  String? get signUpDomicile => _signUpDomicile;

  String? get signUpMarriedStatus => _signUpMarriedStatus;

  bool? get signUpIsAcademic => _signUpIsAcademic;

  String? get signUpReason => _signUpReason;

  String? get signUpProfilePhotoUrl => _signUpProfilePhotoUrl;

  String? get signUpReferral => _signUpReferral;

  String? get signUpAcademicId => _signUpAcademicId;

  String? get signUpAcademicType => _signUpAcademicType;

  String? get signUpDateIn => _signUpDateIn;

  String? get signUpCollege => _signUpCollege;

  String? get signUpDepartment => _signUpDepartment;

  String? get signUpCollegeId => _signUpCollegeId;

  String? get signUpDepartmentId => _signUpDepartmentId;

  checkObsecure() {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  checkObsecureConfirmation() {
    _isObsecureConfirmation = !_isObsecureConfirmation;
    notifyListeners();
  }

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setOtpError(String error) {
    _otpError = error;
    notifyListeners();
  }

  clearOtpError() {
    _otpError = '';
    notifyListeners();
  }

  Future<bool> signIn(
    String email,
    String password,
  ) async {
    checkLoading(true);

    try {
      final data = await _authenticationService.signIn(
        email,
        password,
      );
      _authenticationModel = data;

      if (_authenticationModel?.metadata?.code == 200) {
        checkLoading(false);
        return true;
      } else {
        checkLoading(false);
        return false;
      }
    } catch (e) {
      checkLoading(false);
      throw Exception("$e");
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String roleId,
    required String educationId,
    String? referralId,
    required String nik,
    required String gender,
    required String birthdate,
    required String domicile,
    required String marriedStatus,
    required bool isAcademic,
    required String reason,
    String? profilePhotoUrl,
    String? referral,
    required String academicId,
    required String academicType,
    required String dateIn,
    required String college,
    required String department,
    required String collegeId,
    required String departmentId,
  }) async {
    checkLoading(true);

    try {
      final data = await _authenticationService.signUp(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        roleId: roleId,
        educationId: educationId,
        referralId: referralId,
        nik: nik,
        gender: gender,
        birthdate: birthdate,
        domicile: domicile,
        marriedStatus: marriedStatus,
        isAcademic: isAcademic,
        reason: reason,
        profilePhotoUrl: profilePhotoUrl,
        referral: referral,
        academicId: academicId,
        academicType: academicType,
        dateIn: dateIn,
        college: college,
        department: department,
        collegeId: collegeId,
        departmentId: departmentId,
      );
      _authenticationModel = data;

      if (_authenticationModel?.metadata?.code == 201) {
        checkLoading(false);
        return true;
      } else {
        checkLoading(false);
        return false;
      }
    } catch (e) {
      checkLoading(false);
      throw Exception("$e");
    }
  }

  Future<bool> signUpNonAcademic({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String roleId,
    required String educationId,
    String? referralId,
    required String nik,
    required String gender,
    required String birthdate,
    required String domicile,
    required String marriedStatus,
    required bool isAcademic,
    // required String reason,
    String? reason,
    String? profilePhotoUrl,
    String? referral,
  }) async {
    checkLoading(true);

    try {
      final data = await _authenticationService.signUpNonAcademic(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        roleId: roleId,
        educationId: educationId,
        referralId: referralId,
        nik: nik,
        gender: gender,
        birthdate: birthdate,
        domicile: domicile,
        marriedStatus: marriedStatus,
        isAcademic: isAcademic,
        reason: reason,
        profilePhotoUrl: profilePhotoUrl,
        referral: referral,
      );

      _authenticationModel = data;

      if (_authenticationModel?.metadata?.code == 201) {
        checkLoading(false);
        return true;
      } else {
        checkLoading(false);
        return false;
      }
    } catch (e) {
      checkLoading(false);
      throw Exception("$e");
    }
  }

  // Method untuk menyimpan data signup step by step
  void setAccountInfo({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    _signUpRoleId = "12345678-9abc-def0-1234-56789abcdef0";
    _signUpName = name;
    _signUpEmail = email;
    _signUpPassword = password;
    _signUpPasswordConfirmation = passwordConfirmation;
    notifyListeners();
  }

  void setPersonalInfo({
    required String roleId,
    required String educationId,
    String? referralId,
    required String nik,
    required String gender,
    required String birthdate,
    required String domicile,
    required String marriedStatus,
    required bool isAcademic,
    required String reason,
    String? profilePhotoUrl,
    String? referral,
  }) {
    _signUpRoleId = roleId;
    _signUpEducationId = educationId;
    _signUpReferralId = referralId;
    _signUpNik = nik;
    _signUpGender = gender;
    _signUpBirthdate = birthdate;
    _signUpDomicile = domicile;
    _signUpMarriedStatus = marriedStatus;
    _signUpIsAcademic = isAcademic;
    _signUpReason = reason;
    _signUpProfilePhotoUrl = profilePhotoUrl;
    _signUpReferral = referral;
    notifyListeners();
  }

  void setPersonalInfo1({
    required String fullName,
    required String nik,
    required String birthdate,
    required String gender,
  }) {
    _signUpName = fullName;
    _signUpNik = nik;
    _signUpBirthdate = birthdate;
    _signUpGender = gender;
    notifyListeners();
  }

  void setPersonalInfo2({
    required String domicile,
    required String marriedStatus,
    required String lastEducation,
    required bool isAcademic,
  }) {
    _signUpDomicile = domicile;
    _signUpMarriedStatus = marriedStatus;
    _signUpEducationId = lastEducation;
    _signUpIsAcademic = isAcademic;
    notifyListeners();
  }

  void setReasonSigningUp({
    required String reason,
  }) {
    _signUpReason = reason;
    notifyListeners();
  }

  void setAcademicInfo({
    required String academicId,
    required String academicType,
    required String dateIn,
    required String college,
    required String department,
    required String collegeId,
    required String departmentId,
  }) {
    _signUpAcademicId = academicId;
    _signUpAcademicType = academicType;
    _signUpDateIn = dateIn;
    _signUpCollege = college;
    _signUpDepartment = department;
    _signUpCollegeId = collegeId;
    _signUpDepartmentId = departmentId;
    notifyListeners();
  }

  // Method untuk update reason saja
  void setReason(String reason) {
    _signUpReason = reason;
    notifyListeners();
  }

  // Method untuk determine final signup flow
  Future<bool> performFinalSignUp() async {
    if (_signUpIsAcademic == true) {
      return await finalSignUpAcademic();
    } else {
      return await finalSignUpNonAcademic();
    }
  }

  // Method untuk mengirim OTP
  Future<bool> sendOtp(String email) async {
    checkLoading(true);

    try {
      final data = await _authenticationService.sendOtp(email);
      _otpModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("OTP Response received");
        print("Metadata code: ${_otpModel?.metadata?.code}");
        print("Metadata message: ${_otpModel?.metadata?.message}");
      }

      if (_otpModel?.metadata?.code == 200) {
        checkLoading(false);
        return true;
      } else {
        checkLoading(false);
        if (kDebugMode) {
          print(
              "OTP Failed - Code: ${_otpModel?.metadata?.code}, Message: ${_otpModel?.metadata?.message}");
        }
        return false;
      }
    } catch (e) {
      checkLoading(false);
      if (kDebugMode) {
        print("OTP Error: $e");
        print("Stack trace: ${StackTrace.current}");
      }
      throw Exception("Gagal mengirim OTP: $e");
    }
  }

  // Method untuk verifikasi OTP
  Future<bool> verifyOtp(String email, String otp) async {
    checkLoading(true);
    clearOtpError(); // Clear any previous error

    try {
      final data = await _authenticationService.verifyOtp(email, otp);
      _authenticationModel = data;

      if (_authenticationModel?.metadata?.code == 200) {
        checkLoading(false);
        return true;
      } else {
        checkLoading(false);
        return false;
      }
    } catch (e) {
      checkLoading(false);
      throw Exception("$e");
    }
  }

  // Method untuk final signup (academic)
  Future<bool> finalSignUpAcademic() async {
    if (_signUpName == null ||
        _signUpEmail == null ||
        _signUpPassword == null ||
        _signUpPasswordConfirmation == null ||
        _signUpRoleId == null ||
        _signUpEducationId == null ||
        _signUpNik == null ||
        _signUpGender == null ||
        _signUpBirthdate == null ||
        _signUpDomicile == null ||
        _signUpMarriedStatus == null ||
        _signUpIsAcademic == null ||
        _signUpReason == null ||
        _signUpAcademicId == null ||
        _signUpAcademicType == null ||
        _signUpDateIn == null ||
        _signUpCollege == null ||
        _signUpDepartment == null ||
        _signUpCollegeId == null ||
        _signUpDepartmentId == null) {
      throw Exception("Data signup tidak lengkap");
    }

    return await signUp(
      name: _signUpName!,
      email: _signUpEmail!,
      password: _signUpPassword!,
      passwordConfirmation: _signUpPasswordConfirmation!,
      roleId: _signUpRoleId!,
      educationId: _signUpEducationId!,
      referralId: _signUpReferralId,
      nik: _signUpNik!,
      gender: _signUpGender!,
      birthdate: _signUpBirthdate!,
      domicile: _signUpDomicile!,
      marriedStatus: _signUpMarriedStatus!,
      isAcademic: _signUpIsAcademic!,
      reason: _signUpReason!,
      profilePhotoUrl: _signUpProfilePhotoUrl,
      referral: _signUpReferral,
      academicId: _signUpAcademicId!,
      academicType: _signUpAcademicType!,
      dateIn: _signUpDateIn!,
      college: _signUpCollege!,
      department: _signUpDepartment!,
      collegeId: _signUpCollegeId!,
      departmentId: _signUpDepartmentId!,
    );
  }

  // Method untuk final signup (non-academic)
  Future<bool> finalSignUpNonAcademic() async {
    if (_signUpName == null ||
        _signUpEmail == null ||
        _signUpPassword == null ||
        _signUpPasswordConfirmation == null ||
        _signUpRoleId == null ||
        _signUpEducationId == null ||
        _signUpNik == null ||
        _signUpGender == null ||
        _signUpBirthdate == null ||
        _signUpDomicile == null ||
        _signUpMarriedStatus == null ||
        _signUpIsAcademic == null ||
        _signUpReason == null) {
      throw Exception("Data signup tidak lengkap");
    }

    return await signUpNonAcademic(
      name: _signUpName!,
      email: _signUpEmail!,
      password: _signUpPassword!,
      passwordConfirmation: _signUpPasswordConfirmation!,
      roleId: _signUpRoleId!,
      educationId: _signUpEducationId!,
      referralId: _signUpReferralId,
      nik: _signUpNik!,
      gender: _signUpGender!,
      birthdate: _signUpBirthdate!,
      domicile: _signUpDomicile!,
      marriedStatus: _signUpMarriedStatus!,
      isAcademic: _signUpIsAcademic!,
      reason: _signUpReason,
      profilePhotoUrl: _signUpProfilePhotoUrl,
      referral: _signUpReferral,
    );
  }

  // Method untuk clear signup data
  void clearSignUpData() {
    _signUpName = null;
    _signUpEmail = null;
    _signUpPassword = null;
    _signUpPasswordConfirmation = null;
    _signUpRoleId = null;
    _signUpEducationId = null;
    _signUpReferralId = null;
    _signUpNik = null;
    _signUpGender = null;
    _signUpBirthdate = null;
    _signUpDomicile = null;
    _signUpMarriedStatus = null;
    _signUpIsAcademic = null;
    _signUpReason = null;
    _signUpProfilePhotoUrl = null;
    _signUpReferral = null;
    _signUpAcademicId = null;
    _signUpAcademicType = null;
    _signUpDateIn = null;
    _signUpCollege = null;
    _signUpDepartment = null;
    notifyListeners();
  }

  Future<void> createPin(BuildContext context) async {
    try {
      final success =
          await _authenticationService.createPin(_signUpEmail!, _pin!);
      if (!context.mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN created successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create PIN'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating PIN: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      notifyListeners();
    }
  }
}
