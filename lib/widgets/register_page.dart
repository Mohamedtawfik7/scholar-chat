import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat2/pages/chat_page.dart';
import 'package:scholar_chat2/widgets/custom_button.dart';
import 'package:scholar_chat2/widgets/custom_textfield.dart';
import 'package:scholar_chat2/widgets/helper/Show_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Image.asset('assets/images/scholar.png'),
              SizedBox(
                child: Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
              CustomTextfield(
                onChanged: (data) {
                  email = data;
                },
                hinttext: 'Email',
              ),
              SizedBox(height: 10),
              CustomTextfield(
                onChanged: (data) {
                  password = data;
                },
                hinttext: 'Password',
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    )
                  : CustomButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() => isLoading = true);
                          try {
                            await registerUser();
                            Navigator.pushNamed(context, ChatPage.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context, 'weak password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context, 'email already in use');
                            }
                          } finally {
                            setState(() => isLoading = false);
                          }
                        }
                      },
                      text: 'Register',
                    ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I Already have an account ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
