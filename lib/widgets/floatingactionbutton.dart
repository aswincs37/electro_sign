import 'package:flutter/material.dart';

class FloatingactionButton extends StatelessWidget {
  const FloatingactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 15,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.deepPurple,
              child: const Icon(
                Icons.message,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            right: 80,
            top: 8,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "2",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
