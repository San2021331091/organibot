import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:organibot/models/message_model.dart';
import 'package:organibot/notifier/message_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organibot/utils/color.dart';
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

    // Send first message automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageProvider.notifier).sendMessage(message: widget.query);
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
      backgroundColor: AppColors.lightGreenColor,
      appBar: AppBar(
        backgroundColor: AppColors.mediumGreenColor,
        centerTitle: true,
        title: Text(
          "AI OrganiGPT Assistant",
          style: AppTextStyles.bodyLarge(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
            color: AppColors.lightGreenColor,
            child: Row(
              children: [
                /// Text Field with proper green background
                Expanded(
                  child: TextField(
                    controller: chatBoxController,
                    style: AppTextStyles.headlineMedium(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Ask something...",
                      hintStyle: AppTextStyles.caption(color: Colors.white,fontWeight: FontWeight.w600),
                      filled: true,
                      fillColor: AppColors.mediumGreenColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// Send button with gradient green
                GestureDetector(
                  onTap: () {
                    if (chatBoxController.text.trim().isEmpty) return;

                    ref.read(messageProvider.notifier).sendMessage(
                        message: chatBoxController.text.trim());

                    chatBoxController.clear();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lightGreenColor,
                          AppColors.mediumGreenColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.send, color: Colors.white),
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
        DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sendAt)));

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightGreenColor, AppColors.mediumGreenColor],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msgModel.message,
              style: AppTextStyles.bodyLarge(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(time, style: AppTextStyles.bodyMedium(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  /// ---------------- BOT MESSAGE ---------------- ///
 Widget botChatBox(MessageModel msgModel, int index) {
  var time = dateFormat.format(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sendAt)));

  return Align(
    alignment: Alignment.centerLeft,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Chat Icon (Bot Avatar)
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 6),
          child: Image.asset(
            "assets/icon/icon_chat.png",
            height: 30,
            width: 30,
          ),
        ),

        /// Message Bubble
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.lightGreenAccentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔥 SHOW TYPING ICON FIRST
                if (msgModel.isRead == false) ...[
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/icon_typing.png",
                        height: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Typing...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                /// Animated Bot Text
                msgModel.isRead == true
                    ? SelectableText(
                        msgModel.message,
                        style: AppTextStyles.bodyMedium(color: Colors.white),
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
                            speed: const Duration(milliseconds: 20),
                            textStyle:
                                AppTextStyles.bodyLarge(color: Colors.white),
                          ),
                        ],
                      ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: msgModel.message));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Copied to clipboard")),
                        );
                      },
                      child: const Icon(Icons.copy,
                          size: 18, color: Colors.white),
                    ),
                    Text(
                      time,
                      style: AppTextStyles.caption(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
 }
}