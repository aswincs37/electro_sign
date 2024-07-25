import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent, // Background color of the navbar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leading Menu Button
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Your menu button action here
            },
          ),
          // Company Name
          Text(
            'CompanyName',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Login and Register Buttons
          Row(
            children: [
              StylishTextButton(
                text: 'Login',
                onPressed: () {
                  // Your login action here
                },
              ),
              const SizedBox(width: 20),
              StylishTextButton(
                text: 'Register',
                onPressed: () {
                  // Your register action here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StylishTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const StylishTextButton(
      {required this.text, required this.onPressed, super.key});

  @override
  _StylishTextButtonState createState() => _StylishTextButtonState();
}

class _StylishTextButtonState extends State<StylishTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          foregroundColor: _isHovered ? Colors.blueAccent : Colors.white,
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration:
                _isHovered ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
