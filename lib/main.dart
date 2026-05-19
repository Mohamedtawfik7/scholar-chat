import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat2/firebase_options.dart';
import 'package:scholar_chat2/pages/chat_page.dart';
import 'package:scholar_chat2/pages/login_page.dart';
import 'package:scholar_chat2/widgets/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },

      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
    );
  }
}
