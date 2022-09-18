import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/pages/race_loading.dart';
import 'package:skiwm/resources/credits_service.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/utils/value_notifiers.dart';
import 'package:skiwm/widgets/button.dart';
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
          icon: const Icon(Icons.arrow_back, color: SkiWmColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [CreditChip(), SizedBox(width: 15)],
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3, // TODO
              child: Hero(
                tag: args.id!,
                child: Image.asset('assets/images/snow_race.jpg',
                    fit: BoxFit.cover),
              ),
            ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildStartButton(context, args.fromDate!,
                        args.racename!, args.credits!, args.id!),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
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
              children: const <Widget>[
                SizedBox(
                  height: 1,
                ),
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
                  'Start racing (-' + credits.toString() + ' Credits)',
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
                  'Start racing (-' + credits.toString() + ' Credits)',
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
            child: MyButton(
              onPressed: () => _onPressed(credits, title, raceId),
              child: Text('Start racing (-' + credits.toString() + ' Credits)'),
            ),
          ),
        ),
      ],
    );
  }

  void _onPressed(int credits, String title, String raceId) {
    CreditsService.addCredits(credits * -1);
    Get.to(LoadingPage(title, raceId));
  }
}
