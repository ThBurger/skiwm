import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/pages/race_loading.dart';
import 'package:skiwm/resources/shared_preferences_service.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/utils/value_notifiers.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/results.dart';
import 'package:skiwm/utils/constants.dart';

class RaceStartPage extends StatelessWidget {
  const RaceStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Race;
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
          args.racename!,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
                foregroundDecoration:
                    const BoxDecoration(color: Colors.black26),
                height: 330, // TODO
                child: Image.asset(args.img!, fit: BoxFit.cover)),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 250),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      args.racename!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
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
                                    TextSpan(children: [
                                      TextSpan(text: "Difficulty")
                                    ]),
                                    style: TextStyle(
                                        color: SkiWmColors.white,
                                        fontSize: 12.0),
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
                              color: SkiWmColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  ResultPage(
                    raceId: args.id!,
                  ),
                  const SizedBox(height: 35.0),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildStartButton(context, args.fromDate!, args.racename!,
                    args.credits!, args.id!),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, DateTime from, String title,
      int credits, String raceId) {
    if (DateTime.now().isBefore(from)) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.transparent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                onPressed: () {
                  context.showErrorSnackBar(message: 'Not yet started');
                },
                child: Text(
                  'Start racing -' + credits.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (creditsValueNotifier.value < credits) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.transparent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                onPressed: () {
                  context.showErrorSnackBar(message: 'not enough credits');
                },
                child: Text(
                  'Start racing -' + credits.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                SharedPreferencesService().decreaseCredits(credits);
                Get.to(LoadingPage(title, raceId));
              },
              child: Text(
                'Start racing -' + credits.toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
