import 'package:flutter/material.dart';
import 'package:scholar_chat2/constant.dart';
import 'package:scholar_chat2/models/message.dart';
import 'package:scholar_chat2/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kmessagescollection,
  );
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt).snapshots(),
      builder: (context, snapshot) {
        List<Message> messagelist = [];

        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(Message.fromJson(snapshot.data!.docs[i]));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300), // سرعة الحركة
                curve: Curves.easeOut, // نوع الحركة
              );
            });
          }

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 215, 216, 184),
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize
                    .min, // ⬅️ المهم دي عشان الـ Row متاخدش كل العرض
                children: [
                  Image.asset(kLogo, height: 50),
                  SizedBox(width: 8),
                  Text(
                    'Chat',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messagelist.length,
                    itemBuilder: (context, index) {
                      return messagelist[index].id == email
                          ? ChatBubble(message: messagelist[index])
                          : ChatBubbleForFriend(message: messagelist[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kmessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                    },

                    decoration: InputDecoration(
                      hintText: 'send message',
                      suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
