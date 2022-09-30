import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiwm/utils/theme.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _onIntroEnd(context) {
    _storeOnboarding();
    Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
  }

  Future<void> _storeOnboarding() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('onboardingDone', true);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: SkiWmColors.backgroundNew,
      imagePadding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
    );

    return IntroductionScreen(
      isTopSafeArea: true,
      key: introKey,
      globalBackgroundColor: SkiWmColors.backgroundNew,
      pages: [
        PageViewModel(
          title: "Welcome to Ski WM",
          body: "It's easy to play, hard to master",
          image: _buildImage('skier.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Easy",
          body:
              "Only 5 directions! click left and right on screen to change direction",
          image: _buildImage('tutorial.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Let's get started",
          body:
              "Happy gaming and improve your skills to get on the top of the leaderboard",
          image: _buildImage('podium.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: SkiWmColors.primaryNew,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
