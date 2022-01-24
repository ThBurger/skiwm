import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/training_game_main.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/results.dart';

class RacePage extends StatelessWidget {
  const RacePage({Key? key}) : super(key: key);

  final String image = "assets/images/Training_1.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Race",
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: const BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.asset(image, fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Bormio",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    const Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                    const Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                    const Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                    const Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                  ],
                                ),
                                const Text.rich(
                                  TextSpan(
                                      children: [TextSpan(text: "Difficulty")]),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                          const CreditChip(),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        "Leaderboard".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                const ResultPage(
                  raceId: '',
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildStartButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              onPressed: () {
                Get.to(const MainTrainingPage());
              },
              child: const Text("Start racing..."),
              color: SkiWmColors.primary,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
