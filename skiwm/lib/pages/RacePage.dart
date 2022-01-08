import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/main_training_page.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/widgets/leaderboard.dart';

class RacePage extends StatelessWidget {
  const RacePage({Key? key}) : super(key: key);

  final String image = "assets/images/Training_1.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Race",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.asset(image, fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                      children: [TextSpan(text: "Difficulty")]),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                          _buildChip("100"),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        "Leaderboard".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Leaderboard(),
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

  Widget _buildChip(String label) {
    return Chip(
        labelPadding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.white70,
          child: Text("C"),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: SkiWmColors.primary,
          ),
        ),
        backgroundColor: SkiWmColors.bgColorScreen,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(8.0),
        deleteIcon: Icon(
          Icons.add,
        ),
        onDeleted: () {});
  }

  Widget _buildStartButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              onPressed: () {
                Get.to(const MainTrainingPage());
              },
              child: Text("Start racing..."),
              color: SkiWmColors.primary,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
