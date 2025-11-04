import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl {
    // 1. PRIORIDAD: --dart-define (móvil, ngrok, producción)
    final fromDefine = const String.fromEnvironment('API_URL');
    if (fromDefine.isNotEmpty) {
      return fromDefine;
    }

    // 2. DESARROLLO: .env (emulador)
    return dotenv.env['API_URL'] ?? 'http://10.0.2.2:3000';
  }
}