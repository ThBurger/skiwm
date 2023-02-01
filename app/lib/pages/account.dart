import 'package:flutter/material.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/resources/shared_preferences_service.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/widgets/drawer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:retroskiing/utils/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _usernameController = TextEditingController();
  final _countryController = TextEditingController();
  var _loading = false;
  var _saving = false;
  int _races = 0;
  int _finished = 0;
  int _crashed = 0;
  int _time = 0;
  late AnimationController animationController;

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    String __username =
        await SharedPreferencesService().getString(profileUsername);
    String __country =
        await SharedPreferencesService().getString(profileCountry);
    _usernameController.text = __username;
    _countryController.text = __country;
    setState(() {
      _loading = false;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _saving = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    final userName = _usernameController.text;
    final country = _countryController.text;
    await SharedPreferencesService().setString(profileUsername, userName);
    await SharedPreferencesService().setString(profileCountry, country);
    userNameGlobal = userName;
    userCountryGlobal = country;
    setState(() {
      _saving = false;
    });
  }

  @override
  void initState() {
    loadCounter();
    _getProfile();
    animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _countryController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void loadCounter() async {
    int __races = await SharedPreferencesService().getScore(profileRaces);
    int __finished = await SharedPreferencesService().getScore(profileFinished);
    int __crashed = await SharedPreferencesService().getScore(profileCrashed);
    int __time = await SharedPreferencesService().getScore(profileTime);
    setState(() {
      _races = __races;
      _finished = __finished;
      _crashed = __crashed;
      _time = __time;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _loadingWidget();
    }

    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const SizedBox(height: 18),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text('Select Country',
                    style: TextStyle(color: Colors.white)),
                CountryCodePicker(
                  textStyle: const TextStyle(color: Colors.white),
                  onChanged: (value) => {_countryController.text = value.code!},
                  initialSelection: _countryController.text,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  alignLeft: false,
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.all(8), child: getRank(_races)),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      getTimeBoxUI(_races.toString(), 'Race started'),
                      getTimeBoxTime(_time, 'Time racing'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      getTimeBoxUI(_finished.toString(), 'Race finished'),
                      getTimeBoxUI(_crashed.toString(), 'Crashed'),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: RetroSkiingStyle.buttonHeight,
                  decoration: BoxDecoration(
                    gradient: RetroSkiingStyle.gradient,
                    borderRadius: RetroSkiingStyle.borderRadius,
                  ),
                  child: ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text(_saving ? 'Wird gespeichert...' : 'Speichern'),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Expanded(
                flex: 6,
                child: Align(
                  child: Text("loading Profile..."),
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.green,
                        valueColor: animationController.drive(ColorTween(
                            begin: RetroSkiingColors.primary,
                            end: RetroSkiingColors.label)),
                        minHeight: 7,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: RetroSkiingColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: RetroSkiingColors.primary,
                offset: Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: RetroSkiingColors.black,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: RetroSkiingColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRank(int races) {
    int maxRaces = 100;
    String rank = "";
    if (races <= 100) {
      maxRaces = 100;
      rank = "Rookie";
    } else if (races > 100 && races <= 500) {
      maxRaces = 500;
      rank = "Pro";
    } else if (races > 100 && races <= 2000) {
      maxRaces = 2000;
      rank = "Elite";
    } else if (races > 100 && races <= 5000) {
      maxRaces = 5000;
      rank = "Master";
    } else if (races > 100 && races <= 10000) {
      maxRaces = 10000;
      rank = "Grandmaster";
    } else {
      maxRaces = 50000;
      rank = "Legend";
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: RetroSkiingColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: RetroSkiingColors.primary,
                offset: Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(
                  value: races / maxRaces,
                ),
              ),
              Text(
                races.toString() + "/" + maxRaces.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: RetroSkiingColors.black,
                ),
              ),
              Text(
                rank,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: RetroSkiingColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxTime(int text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: RetroSkiingColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: RetroSkiingColors.primary,
                offset: Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                StopWatchTimer.getDisplayTime(text1, hours: false),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: RetroSkiingColors.black,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: RetroSkiingColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
