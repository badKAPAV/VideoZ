import 'package:flutter/material.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/views/screens/auth/signup_screen.dart';
import 'package:video_uploader/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Video Uploader',
              style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              'Login',
              style: TextStyle(
                  fontSize: 25,
                  // color: buttonColor,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  isObscure: true,),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => authController.loginUser(_emailController.text, _passwordController.text),
              splashColor: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: buttonColor,
                ),
                child: const Center(
                    child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen())),
                  child: Text(
                    ' Register',
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
