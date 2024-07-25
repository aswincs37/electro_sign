import 'package:electrosign/section/body/footer_body.dart';
import 'package:electrosign/section/body/header_body.dart';
import 'package:electrosign/section/body/first_middle_body.dart';
import 'package:electrosign/section/body/second_middle_body.dart';
import 'package:electrosign/widgets/commonAppbar.dart';
import 'package:electrosign/widgets/floatingactionbutton.dart';

import 'package:electrosign/widgets/header_drawer.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: HeaderDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CommonAppBar()),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Header_body(),
                SizedBox(
                  height: 20,
                ),
                FirstMiddleBody(),
                SizedBox(
                  height: 20,
                ),
                SecondMiddleBody(),
                SizedBox(
                  height: 10,
                ),
                FooterBody()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingactionButton(),
    );
  }
}
