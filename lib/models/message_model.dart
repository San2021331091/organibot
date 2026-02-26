final class MessageModel {
  final String _msg;
  final int _sendId;
  final String _sendAt;
  bool ?isRead;

  MessageModel({
    required String msg,
    required int sendId,
    required String sendAt,
    this.isRead = false
  }) : _msg = msg,
       _sendId = sendId,
       _sendAt = sendAt;
      

  String get message => _msg;
  int get sendId => _sendId;
  String get sendAt => _sendAt;
}
