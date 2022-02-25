import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/models/race_arguments.dart';
import 'package:skiwm/pages/account.dart';
import 'package:skiwm/pages/leaderboard.dart';
import 'package:skiwm/pages/shop.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/widgets/daily_credits.dart';
import 'package:skiwm/widgets/card_small.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/slide_item.dart';

List trainings = [
  {
    "img": "assets/images/Training_1.png",
    "title": "Sölden",
    "text": "start easy training",
    "rating": 1.2
  },
  {
    "img": "assets/images/Training_1.png",
    "title": "Saalbach",
    "text": "start medium training",
    "rating": 2.5
  }
];

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
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Credits",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                const DailyCredit(),
                const SizedBox(height: 18),
                const Text(
                  "Races",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                SlideItem(
                    title: "Bormio",
                    text: 'Start Racing...',
                    img: "assets/images/Training_1.png",
                    rating: "3,4",
                    tap: () {
                      Navigator.pushNamed(
                        context,
                        '/race',
                        arguments: RaceArguments(
                            'Bormio', 'assets/images/Training_1.png', 2),
                      );
                    }),
                const SizedBox(height: 8.0),
                const Text(
                  "Trainings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                buildTrainingList(context),
                const Text(
                  "Other Stuff",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                Row(
                  children: [
                    CardSmall(
                        cta: "Leaderboard",
                        title: 'check standings...',
                        img: "assets/images/podium.png",
                        tap: () {
                          Get.to(const LeaderboardPage());
                        }),
                    CardSmall(
                        cta: "Profile",
                        title: 'edit your profile...',
                        img: "assets/images/user.png",
                        tap: () {
                          Get.to(const AccountPage());
                        }),
                  ],
                ),
                Row(
                  children: [
                    CardSmall(
                        cta: "Shop",
                        title: 'in app purchases...',
                        img: "assets/images/shop.png",
                        tap: () {
                          Get.to(const ShopPage());
                        })
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text(
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

  buildTrainingList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: trainings.length,
        itemBuilder: (BuildContext context, int index) {
          Map training = trainings[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SlideItem(
                img: training["img"],
                title: training["title"],
                text: training["text"],
                rating: training["rating"].toString(),
                tap: () {
                  Navigator.pushNamed(
                    context,
                    '/race',
                    arguments: RaceArguments(
                        training["title"], training["img"], training["rating"]),
                  );
                }),
          );
        },
      ),
    );
  }
}
