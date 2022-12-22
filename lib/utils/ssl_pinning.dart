import 'package:http/http.dart' as http;

class SSLPinning {
  static http.Client? clientConst;
  static http.Client get client => clientConst ??= http.Client();
  static Future<http.Client> get instance async {
    return clientConst!;
  }

  static Future<void> init() async {
    clientConst = await instance;
  }
}
