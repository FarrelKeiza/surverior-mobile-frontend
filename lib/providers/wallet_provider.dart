import 'package:flutter/foundation.dart';
import 'package:surverior_frontend_mobile/models/wallet_model.dart';
import 'package:surverior_frontend_mobile/services/wallet_service.dart';

class WalletProvider with ChangeNotifier {
  final _walletService = WalletService();
  WalletResponseModel? _walletResponseModel;

  WalletResponseModel? get walletResponseModel => _walletResponseModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  // Getters for wallet data
  WalletModel? get wallet => _walletResponseModel?.data;

  // Quick access getters
  String? get walletId => wallet?.id;
  String? get userId => wallet?.userId;
  String? get cardNumber => wallet?.cardNumber;
  double? get balances => wallet?.balances;
  bool? get isLocked => wallet?.isLocked;
  String? get pinSetAt => wallet?.pinSetAt;
  String? get createdAt => wallet?.createdAt;
  String? get updatedAt => wallet?.updatedAt;

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

  // Method untuk mengambil data wallet
  Future<bool> fetchWallet() async {
    setLoading(true);
    clearError();

    try {
      final data = await _walletService.getWallet();
      _walletResponseModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Wallet Response received");
        print("Metadata code: ${_walletResponseModel?.metadata?.code}");
        print("Card number: ${_walletResponseModel?.data?.cardNumber}");
        print("Balance: ${_walletResponseModel?.data?.balances}");
        print("Is locked: ${_walletResponseModel?.data?.isLocked}");
      }

      if (_walletResponseModel?.metadata?.code == 200) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setError(_walletResponseModel?.metadata?.message ??
            'Failed to fetch wallet');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError(e.toString());
      if (kDebugMode) {
        print("Wallet Error: $e");
      }
      return false;
    }
  }

  // Method untuk update PIN wallet
  Future<bool> updateWalletPin(String pin) async {
    setLoading(true);
    clearError();

    try {
      final data = await _walletService.updateWalletPin(pin);
      _walletResponseModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Update PIN Response received");
        print("Metadata code: ${_walletResponseModel?.metadata?.code}");
        print("PIN set at: ${_walletResponseModel?.data?.pinSetAt}");
      }

      if (_walletResponseModel?.metadata?.code == 200) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setError(_walletResponseModel?.metadata?.message ??
            'Failed to update wallet PIN');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError(e.toString());
      if (kDebugMode) {
        print("Update PIN Error: $e");
      }
      return false;
    }
  }

  // Method untuk lock wallet
  Future<bool> lockWallet() async {
    setLoading(true);
    clearError();

    try {
      final data = await _walletService.lockWallet();
      _walletResponseModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Lock Wallet Response received");
        print("Metadata code: ${_walletResponseModel?.metadata?.code}");
        print("Is locked: ${_walletResponseModel?.data?.isLocked}");
      }

      if (_walletResponseModel?.metadata?.code == 200) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setError(
            _walletResponseModel?.metadata?.message ?? 'Failed to lock wallet');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError(e.toString());
      if (kDebugMode) {
        print("Lock Wallet Error: $e");
      }
      return false;
    }
  }

  // Method untuk unlock wallet
  Future<bool> unlockWallet() async {
    setLoading(true);
    clearError();

    try {
      final data = await _walletService.unlockWallet();
      _walletResponseModel = data;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Unlock Wallet Response received");
        print("Metadata code: ${_walletResponseModel?.metadata?.code}");
        print("Is locked: ${_walletResponseModel?.data?.isLocked}");
      }

      if (_walletResponseModel?.metadata?.code == 200) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        setError(_walletResponseModel?.metadata?.message ??
            'Failed to unlock wallet');
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError(e.toString());
      if (kDebugMode) {
        print("Unlock Wallet Error: $e");
      }
      return false;
    }
  }

  // Method untuk clear wallet data (saat logout)
  void clearWalletData() {
    _walletResponseModel = null;
    _error = '';
    _isLoading = false;
    notifyListeners();
  }

  // Method untuk refresh wallet
  Future<void> refreshWallet() async {
    await fetchWallet();
  }

  // Helper methods untuk format data
  String getFormattedBalance() {
    if (balances == null) return 'Rp 0';

    // Format currency dengan pemisah ribuan
    String formatted = balances!.toStringAsFixed(0);
    String result = '';
    int count = 0;

    for (int i = formatted.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = '.$result';
      }
      result = formatted[i] + result;
      count++;
    }

    return 'Rp $result';
  }

  String getWalletStatus() {
    if (isLocked == null) return 'Status tidak diketahui';
    return isLocked! ? 'Terkunci' : 'Aktif';
  }

  bool get isPinSet => pinSetAt != null && pinSetAt!.isNotEmpty;

  // Method untuk format card number dengan masking
  String getFormattedCardNumber() {
    if (cardNumber == null || cardNumber!.isEmpty) return 'No card number';

    if (cardNumber!.length <= 4) return cardNumber!;

    // Show first 4 and last 4 characters, mask the middle
    String first4 = cardNumber!.substring(0, 4);
    String last4 = cardNumber!.substring(cardNumber!.length - 4);
    int middleLength = cardNumber!.length - 8;

    String masked = '*' * (middleLength > 0 ? middleLength : 0);

    return '$first4$masked$last4';
  }

  // Method untuk cek apakah wallet available
  bool get isWalletAvailable => wallet != null;

  // Method untuk cek apakah ada balance
  bool get hasBalance => balances != null && balances! > 0;
}
