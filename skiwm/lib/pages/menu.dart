import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:skiwm/pages/account.dart';
import 'package:skiwm/pages/leaderboard.dart';
import 'package:skiwm/pages/race.dart';
import 'package:skiwm/pages/settings.dart';
import 'package:skiwm/pages/shop.dart';
import 'package:skiwm/widgets/credit.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<MenuPage> {
  int selectedpage = 0;
  final _pageNo = [
    const RacePage(),
    const LeaderboardPage(),
    const ShopPage(),
    const AccountPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const <Widget>[
          CreditChip(),
        ]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: _pageNo[selectedpage],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.sports_score, title: 'Races'),
          TabItem(icon: Icons.leaderboard, title: 'Score'),
          TabItem(icon: Icons.shopping_cart, title: 'Shop'),
          TabItem(icon: Icons.account_circle, title: 'Profile'),
          TabItem(icon: Icons.settings, title: 'Options'),
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
      //   child: Container(
      //     padding: const EdgeInsets.only(right: 12, left: 12),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: const [
      //           SizedBox(height: 50),
      //           Text(
      //             "Credits",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 23,
      //             ),
      //           ),
      //           SizedBox(height: 10.0),
      //           Text(
      //             "Made with ❤ by Toburg Labs.",
      //             textAlign: TextAlign.center,
      //           ),
      //           SizedBox(height: 10.0),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
