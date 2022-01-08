import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/main_training_page.dart';
import 'package:skiwm/pages/AccountPage.dart';
import 'package:skiwm/pages/ShopPage.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/widgets/card-small.dart';
import 'package:skiwm/widgets/card-square.dart';
import 'package:skiwm/widgets/slider-product.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'SKI WM',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.cog),
              tooltip: 'Settings',
              color: SkiWmColors.primary,
              onPressed: () {
                Navigator.of(context).pushNamed('/setting');
              },
            ),
          ]),
      backgroundColor: SkiWmColors.bgColorScreen,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                          Navigator.pushNamed(context, '/pro');
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
