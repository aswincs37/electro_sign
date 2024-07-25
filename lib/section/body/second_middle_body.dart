import 'package:electrosign/widgets/body_button.dart';
import 'package:flutter/material.dart';

class SecondMiddleBody extends StatelessWidget {
  const SecondMiddleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Experience it for yourself",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Make your business faster, simpler and more cost-efficient with electronic agreements.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          BodyButton(
              label: "Try ElectroSign",
              btnIcn: Icons.arrow_forward,
              icnClr: Colors.white,
              labelClr: Colors.white,
              btnClr: Colors.purple,
              buttonfunction: () {})
        ],
      ),
    );
  }
}
