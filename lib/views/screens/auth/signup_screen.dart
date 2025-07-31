import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:video_uploader/controllers/auth_controller.dart'; // Make sure this path is correct
import 'package:video_uploader/views/screens/auth/login_screen.dart';

import '../../../constants.dart';
import '../../widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png'),
                  const SizedBox(height: 25),
                  const Text('Create a New Account',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: authController.profilePhoto != null
                            ? FileImage(authController.profilePhoto!)
                            : const NetworkImage(
                                    'https://via.placeholder.com/300')
                                as ImageProvider,
                        backgroundColor: Colors.black,
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () => authController.pickImage(),
                          icon: const Icon(Icons.add_a_photo),
                          splashRadius: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(
                          controller: _usernameController,
                          labelText: 'Username',
                          icon: Icons.person)),
                  const SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(
                          controller: _emailController,
                          labelText: 'Email',
                          icon: Icons.email)),
                  const SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(
                        controller: _passwordController,
                        labelText: 'Password',
                        icon: Icons.lock,
                        isObscure: true,
                      )),
                  const SizedBox(height: 20),
                  authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: () => authController.registerUser(
                              _usernameController.text,
                              _emailController.text,
                              _passwordController.text,
                              authController.profilePhoto),
                          splashColor: Colors.white,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: buttonColor),
                            child: const Center(
                                child: Text('Sign Up',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                        ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                          style: TextStyle(fontSize: 16)),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())),
                        child: Text(' Login now',
                            style: TextStyle(
                                fontSize: 16,
                                color: buttonColor,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
