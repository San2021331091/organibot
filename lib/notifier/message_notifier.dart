import 'package:flutter_riverpod/legacy.dart';
import 'package:organibot/api/api_helper.dart';
import 'package:organibot/models/ai_bot_model.dart';
import 'package:organibot/models/message_model.dart';

/// StateNotifier for managing chat messages
class MessageNotifier extends StateNotifier<List<MessageModel>> {
  final APIHelper _apiHelper;
  MessageNotifier(this._apiHelper) : super([]);

  /// Send a message and receive bot response
  Future<void> sendMessage({required String message}) async {
    try {
      // Add user message at top
      final userMessage = MessageModel(
        msg: message,
        sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
        sendId: 0,
      );
      state = [userMessage, ...state];

      // Call OrganiBot API
      final OrganiBotResponseModel response =
          await _apiHelper.sendMessageAPI(msg: message);

      // Add bot response
      final botMessage = MessageModel(
        msg: response.firstText, // Uses helper to get combined text
        sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
        sendId: 1,
      );
      state = [botMessage, ...state];
    } catch (e) {
      // Add error message as bot response
      final errorMessage = MessageModel(
        msg: "Error: ${e.toString()}",
        sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
        sendId: 1,
      );
      state = [errorMessage, ...state];
    }
  }

  /// Mark a message as read
  void updateMessageRead(int index) {
    final updated = [...state];
    if (index >= 0 && index < updated.length) {
      updated[index].isRead = true;
      state = updated;
    }
  }
}

/// Riverpod provider
final messageProvider =
    StateNotifierProvider<MessageNotifier, List<MessageModel>>(
  (ref) => MessageNotifier(APIHelper()),
);