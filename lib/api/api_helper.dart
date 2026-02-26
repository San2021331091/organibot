import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:organibot/api/urls.dart';
import 'package:organibot/models/ai_bot_model.dart';

final class APIHelper {
  final Dio _dio;
  APIHelper() : _dio = Dio();

  /// Sends a message to the bot API
  Future<OrganiBotResponseModel> sendMessageAPI({required String msg}) async {
    try {
      Response response = await _dio.post(
        Urls.baseUrl,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "You are OrganiBot, an AI assistant specialized in organic chemistry. If anyone asks who you are, respond: 'I am an AI assistant in organic chemistry class.'",
                },
              ],
            },
            {
              "parts": [
                {"text": msg},
              ],
            },
          ],
        },
      );

      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      if (response.statusCode == 200 && data != null) {
        return OrganiBotResponseModel.fromJson(data as Map<String, dynamic>);
      } else {
        debugPrint("Failed with status: ${response.statusCode}");
        return OrganiBotResponseModel(candidates: []);
      }
    } on DioException catch (e) {
      debugPrint("DioException: ${e.message}");
      return OrganiBotResponseModel(candidates: []);
    } catch (e) {
      debugPrint("Unknown exception: $e");
      return OrganiBotResponseModel(candidates: []);
    }
  }
}
