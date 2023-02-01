import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retroskiing/models/race.dart';
import 'package:retroskiing/pages/race_loading.dart';
import 'package:retroskiing/utils/theme.dart';

class RaceStartPage extends StatefulWidget {
  const RaceStartPage({Key? key}) : super(key: key);

  @override
  _RaceStartPageState createState() => _RaceStartPageState();
}

class _RaceStartPageState extends State<RaceStartPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Race;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: RetroSkiingColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              height: MediaQuery.of(context).size.height * 0.3,
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
                    child: Text(
                      args.raceType!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildStartButton(context, args.racename!, args.id!),
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

  Widget _buildStartButton(BuildContext context, String title, String raceId) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              height: RetroSkiingStyle.buttonHeight,
              decoration: BoxDecoration(
                gradient: RetroSkiingStyle.gradient,
                borderRadius: RetroSkiingStyle.borderRadius,
              ),
              child: ElevatedButton(
                onPressed: () => Get.to(LoadingPage(title, raceId))
                    ?.then((_) => setState(() {})),
                child: const Text('Start racing'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
