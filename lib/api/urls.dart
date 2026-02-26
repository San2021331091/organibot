import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static const String _base =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

  static String get apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  static String get baseUrl => "$_base?key=$apiKey";

}