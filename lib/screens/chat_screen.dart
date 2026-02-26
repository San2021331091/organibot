import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:organibot/models/message_model.dart';
import 'package:organibot/notifier/message_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organibot/utils/utils_helper.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String query;
  const ChatScreen({super.key, required this.query});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController chatBoxController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final DateFormat dateFormat = DateFormat().add_jm();

  @override
  void initState() {
    super.initState();

    /// Send first message automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageProvider.notifier)
          .sendMessage(message: widget.query);
    });
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final listMsg = ref.watch(messageProvider);

    scrollToBottom();

    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xff1E293B),
        centerTitle: true,
        title: const Text(
          "AI OrganiGPT Assistant",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [

          /// ---------------- Messages ---------------- ///
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: listMsg.length,
              itemBuilder: (context, index) {
                return listMsg[index].sendId == 0
                    ? userChatBox(listMsg[index])
                    : botChatBox(listMsg[index], index);
              },
            ),
          ),

          /// ---------------- Input Box ---------------- ///
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xff1E293B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatBoxController,
                    style: AppTextStyles.headlineMedium(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Ask something...",
                      hintStyle:
                         AppTextStyles.caption(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xff0F172A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (chatBoxController.text.trim().isEmpty) return;

                    ref.read(messageProvider.notifier).sendMessage(
                        message: chatBoxController.text.trim());

                    chatBoxController.clear();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    child:
                        Icon(Icons.send, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// ---------------- USER MESSAGE ---------------- ///
  Widget userChatBox(MessageModel msgModel) {
    var time = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(msgModel.sendAt)));

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.blue ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msgModel.message,
              style: AppTextStyles.bodyLarge(color: Colors.white10),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: AppTextStyles.bodyMedium(color: Colors.white12)
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- BOT MESSAGE ---------------- ///
  Widget botChatBox(MessageModel msgModel, int index) {
    var time = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(msgModel.sendAt)));

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Animated Bot Text
            msgModel.isRead == true
                ? SelectableText(
                    msgModel.message ,
                    style: const TextStyle(
                        color: Colors.black87),
                  )
                : AnimatedTextKit(
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    onFinished: () {
                      ref
                          .read(messageProvider.notifier)
                          .updateMessageRead(index);
                    },
                    animatedTexts: [
                      TypewriterAnimatedText(
                        msgModel.message,
                        speed: const Duration(
                            milliseconds: 20),
                        textStyle: const TextStyle(
                            color: Colors.black87),
                      ),
                    ],
                  ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: msgModel.message));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content:
                            Text("Copied to clipboard"),
                      ),
                    );
                  },
                  child: const Icon(Icons.copy,
                      size: 18),
                ),
                Text(
                  time,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black45),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}