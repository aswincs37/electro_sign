import 'package:flutter/material.dart';

class FooterBody extends StatelessWidget {
  const FooterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.grey[200],
        height: 100,
        width: double.infinity,
        child: screenWidth > 1000
            ? Row(
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  Image.asset("assets/images/socialMedia.png"),
                  const Spacer(),
                  Image.asset("assets/images/availableOn.png"),
                  const SizedBox(width: 100),
                ],
              )
            : Column(
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  Image.asset("assets/images/socialMedia.png"),
                ],
              ));
  }
}
