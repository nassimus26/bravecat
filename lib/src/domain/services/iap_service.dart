class IapService {
  static final IapService _instance = IapService._internal();
  factory IapService() => _instance;
  IapService._internal();

  Future<bool> purchaseSkin(String skinId) async {
    // In-App Purchase logic stub
    return true;
  }

  Future<bool> purchaseAdFree() async {
    return true;
  }
}
