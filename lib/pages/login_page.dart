import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat2/constant.dart';
import 'package:scholar_chat2/pages/chat_page.dart';
import 'package:scholar_chat2/widgets/custom_button.dart';
import 'package:scholar_chat2/widgets/custom_textfield.dart';
import 'package:scholar_chat2/widgets/helper/Show_snack_bar.dart';
import 'package:scholar_chat2/widgets/register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/scholar.png'),
                ),
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
                        'Sign In',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                CustomTextfield(
                  hinttext: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  obscureText: true,
                  hinttext: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        await loginUser();
                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        print(e.code);

                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'wrong password');
                        } else if (e.code == 'network-request-failed') {
                          showSnackBar(
                            context,
                            'check your internet connection',
                          );
                        } else {
                          showSnackBar(context, e.code);
                        }
                      } finally {
                        setState(() => isLoading = false);
                      }
                    }
                  },
                  text: 'Log In',
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have an account ? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
