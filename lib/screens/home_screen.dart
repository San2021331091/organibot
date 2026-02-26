import 'package:flutter/material.dart';
import 'package:organibot/screens/chat_screen.dart';
import 'package:organibot/utils/app_constant.dart';
import 'package:organibot/utils/color.dart';
import 'package:organibot/utils/utils_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ---------------- AppBar ----------------
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text.rich(
          TextSpan(
            text: "Organi",
            style: AppTextStyles.headlineLarge(color: Colors.white),
            children: [
              TextSpan(
                text: "GPT",
                style: AppTextStyles.headlineMedium(color: Colors.lightGreenAccent),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: const Icon(Icons.face,color: Colors.white,),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),

      /// ---------------- Body ----------------
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.mediumGreenColor, AppColors.lightGreenColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Top Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 22),
                      const SizedBox(width: 6),
                      Text(
                        "New chat",
                        style: AppTextStyles.bodyLarge(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.history, color: Colors.white, size: 22),
                      const SizedBox(width: 6),
                      Text(
                        "History",
                        style: AppTextStyles.bodyLarge(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Search Box
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    style: AppTextStyles.bodyMedium(color: Colors.white70),
                    maxLines: 6,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(query: value.trim()),
                          ),
                        );
                        searchController.clear();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Write a question!",
                      hintStyle: AppTextStyles.bodyLarge(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.green.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  /// Send Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.mic, color: Colors.white, size: 28),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (searchController.text.trim().isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      query: searchController.text.trim()),
                                ),
                              );
                              searchController.clear();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.deepGreenAccentColor,AppColors.lightGreenAccentColor] ,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              child: Icon(Icons.send, color: Colors.white, size: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Category Tabs
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: AppConstant.defaultQues.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: index == selectedIndex
                            ? Border.all(width: 1, color: Colors.lightGreenAccent)
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Center(
                          child: Text(
                            AppConstant.defaultQues[index]["title"],
                            style: index == selectedIndex
                                ? AppTextStyles.bodyLarge(color: Colors.lightGreenAccent)
                                : AppTextStyles.bodyMedium(color: Colors.white60),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// Grid Questions
            Expanded(
              child: GridView.builder(
                itemCount: AppConstant.defaultQues[selectedIndex]['question'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final data = AppConstant.defaultQues[selectedIndex]['question'][index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(query: data['ques']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 11),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: data['color'],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(data['icon'], size: 28),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              data['ques'],
                              style: AppTextStyles.bodyMedium(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}