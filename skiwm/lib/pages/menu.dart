import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/main_training_page.dart';
import 'package:skiwm/pages/account.dart';
import 'package:skiwm/pages/leaderboard.dart';
import 'package:skiwm/pages/shop.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/widgets/daily_credits.dart';
import 'package:skiwm/widgets/card-small.dart';
import 'package:skiwm/widgets/card-square.dart';
import 'package:skiwm/widgets/credit.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.cog),
          tooltip: 'Settings',
          color: SkiWmColors.white,
          onPressed: () {
            Navigator.of(context).pushNamed('/setting');
          },
        ),
        title: const Text(
          'SKI WM',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: const <Widget>[
          CreditChip(),
        ]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                DailyCredit(),
                const SizedBox(height: 18),
                CardSquare(
                    cta: "Race",
                    title: 'Start Racing...',
                    img: "assets/images/Training_1.png",
                    tap: () {
                      Navigator.pushNamed(context, '/race');
                    }),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    CardSmall(
                        cta: "Training",
                        title: 'Start Training...',
                        tap: () {
                          Get.to(const MainTrainingPage());
                        }),
                    CardSmall(
                        cta: "Leaderboard",
                        title: 'check standings...',
                        img: "assets/images/podium.png",
                        tap: () {
                          Get.to(const LeaderboardPage());
                        })
                  ],
                ),
                Row(
                  children: [
                    CardSmall(
                        cta: "Profile",
                        title: 'edit your profile...',
                        img: "assets/images/user.png",
                        tap: () {
                          Get.to(const AccountPage());
                        }),
                    CardSmall(
                        cta: "Shop",
                        title: 'in app purchases...',
                        img: "assets/images/shop.png",
                        tap: () {
                          Get.to(const ShopPage());
                        })
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  "Made with ❤ by Toburg Labs.",
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 8.0),
                // ProductCarousel(imgArray: articlesCards["Music"]!["products"]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
