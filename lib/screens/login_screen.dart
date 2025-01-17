import 'package:electrosign/firebase/login_registration_auth.dart';
import 'package:electrosign/screens/register_screen.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

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
          child: Container(
            width: 600,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 20.0),
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
                          text: ' Sign In 👇',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.blue.shade900,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Hey, Enter your details to get signed in\nto your account!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  formField(
                    "Email",
                    "Enter your email",
                    emailController,
                    Icons.email,
                    "Please enter email",
                  ),
                  const SizedBox(height: 14.0),
                  formField(
                    "Password",
                    "Enter Password",
                    passwordController,
                    Icons.lock,
                    "Please enter your password",
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue.shade900,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            signIn(
                                emailController, passwordController, context);
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
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      screenWidth > 1000
                          ? TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                              },
                              icon: const Icon(
                                Icons.app_registration_rounded,
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                              label: const Text(
                                "Sign Up for free?",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password logic
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  screenWidth < 1000
                      ? TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                          },
                          icon: const Icon(
                            Icons.app_registration_rounded,
                            color: Colors.blueGrey,
                            size: 20,
                          ),
                          label: const Text(
                            "Sign Up for free?",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 50.0),
                ],
              ),
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
    Widget? suffixIcon,
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
            obscureText: obscureText,
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
              suffixIcon: suffixIcon,
            ),
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
