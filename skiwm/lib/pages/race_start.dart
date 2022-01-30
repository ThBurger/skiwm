import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/models/race_arguments.dart';
import 'package:skiwm/pages/loading.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/results.dart';

class RaceStartPage extends StatelessWidget {
  const RaceStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RaceArguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          args.title,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: const BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.asset(args.image, fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    args.title,
                    style: const TextStyle(
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
                                  children: const <Widget>[
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
              _buildStartButton(args.title),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStartButton(String title) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(LoadingPage(title));
              },
              child: const Text('Start racing'),
            ),
          ),
        ),
      ],
    );
  }
}
