import 'package:electrosign/firebase/login_registration_auth.dart';
import 'package:electrosign/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final _formKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Let’s',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.blue.shade900,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Sign Up 👇',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.blue.shade900,
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Hey, Enter your details to get signed up\nto your account!',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              formField(
                                "Name",
                                "Enter your name",
                                nameController,
                                Icons.person,
                                "Please enter name",
                              ),
                              const SizedBox(height: 10.0),
                              formField(
                                "Phone",
                                "Enter your phone number",
                                phoneController,
                                Icons.phone,
                                "Please Enter phone number",
                              ),
                              const SizedBox(height: 10.0),
                              formField(
                                "Email",
                                "Enter your email",
                                emailController,
                                Icons.email,
                                "Please Enter email",
                              ),
                              const SizedBox(height: 10.0),
                              formField(
                                "Password",
                                "Enter Password",
                                passwordController,
                                Icons.lock,
                                "Please enter your password",
                                obscureText: true,
                              ),
                              const SizedBox(height: 20.0),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUp(
                                        emailController,
                                        passwordController,
                                        phoneController,
                                        nameController,
                                        context);
                                  }
                                },
                                borderRadius: BorderRadius.circular(16.0),
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70.0, vertical: 18.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.app_registration_rounded,
                                  color: Colors.blueGrey,
                                  size: 30,
                                ),
                                label: const Text(
                                  "Have an account? Sign In",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    screenWidth > 1000
                        ? Expanded(
                            child: SizedBox(
                              height: 300, // Adjust the height as needed
                              child: Lottie.network(
                                  "https://lottie.host/ed34bce1-d667-411f-8cd3-735ecc736048/35vQGQB1tY.json"),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formField(
    String fieldName,
    String hintTxt,
    TextEditingController properController,
    IconData prefixIcon,
    String warningMsg, {
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            fieldName,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: properController,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.blue.shade900,
              fontSize: 15.0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(prefixIcon, color: Colors.blue.shade900),
              contentPadding: const EdgeInsets.only(top: 16.0),
              hintText: hintTxt,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.blue.shade900.withOpacity(0.5),
                fontSize: 15.0,
              ),
            ),
            obscureText: obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return warningMsg;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
