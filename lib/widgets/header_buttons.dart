import 'package:flutter/material.dart';

class StylishTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const StylishTextButton(
      {required this.text, required this.onPressed, super.key});

  @override
  State<StylishTextButton> createState() => _StylishTextButtonState();
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
          foregroundColor: _isHovered ? Colors.red : Colors.white,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
