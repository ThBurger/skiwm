import 'package:flutter/material.dart';
import 'package:skiwm/resources/shared_preferences_service.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:supabase/supabase.dart';
import 'package:skiwm/components/auth_required_state.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends AuthRequiredState<AccountPage>
    with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _countryController = TextEditingController();
  var _loading = false;
  var _unAuthenticated = false;
  int _races = 0;
  int _finished = 0;
  int _crashed = 0;
  int _time = 0;
  late AnimationController animationController;

  Future<void> _getProfile(String userId) async {
    setState(() {
      _loading = true;
    });
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single()
        .execute();
    final error = response.error;
    if (error != null && response.status != 406) {
      context.showErrorSnackBar(message: error.message);
    }
    final data = response.data;
    if (data != null) {
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['website'] ?? '') as String;
      _countryController.text = (data['country'] ?? '') as String;
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text;
    final website = _websiteController.text;
    final country = _countryController.text;
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'country': country,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };
    final response = await supabase.from('profiles').upsert(updates).execute();
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    } else {
      context.showSnackBar(message: 'Successfully updated profile!');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    }
  }

  @override
  void onAuthenticated(Session session) {
    loadCounter();
    final user = session.user;
    if (user != null) {
      _getProfile(user.id);
    }
  }

  @override
  void onUnauthenticated() {
    setState(() {
      _unAuthenticated = true;
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/menu'));
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void loadCounter() async {
    int __races = await SharedPreferencesService().getScore(PROFILE_RACES);
    int __finished =
        await SharedPreferencesService().getScore(PROFILE_FINISHED);
    int __crashed = await SharedPreferencesService().getScore(PROFILE_CRASHED);
    int __time = await SharedPreferencesService().getScore(PROFILE_TIME);
    setState(() {
      _races = __races;
      _finished = __finished;
      _crashed = __crashed;
      _time = __time;
    });
  }

  void deleteSharedPrefs() async {
    await SharedPreferencesService().deleteAllSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    if (_unAuthenticated) {
      return _unAuthenticatedWidget();
    }
    if (_loading) {
      return _loadingWidget();
    }

    return Scaffold(
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
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'User Name'),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _websiteController,
                  decoration: const InputDecoration(labelText: 'Website'),
                ),
                const SizedBox(height: 18),
                const Text('Select Country'),
                CountryCodePicker(
                  onChanged: (value) => {_countryController.text = value.code!},
                  initialSelection: _countryController.text,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  alignLeft: false,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      getTimeBoxUI(_races.toString(), 'Race started'),
                      getTimeBoxTime(_time, 'Time racing'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      getTimeBoxUI(_finished.toString(), 'Race finished'),
                      getTimeBoxUI(_crashed.toString(), 'Crashed'),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text(_loading ? 'Saving...' : 'Update')),
                const SizedBox(height: 18),
                ElevatedButton(
                    onPressed: _signOut, child: const Text('Sign Out')),
                ElevatedButton(
                    onPressed: deleteSharedPrefs,
                    child: const Text('Delete Shared Prefs')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _unAuthenticatedWidget() {
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
                  child: Text("you are not logged in ..."),
                ),
              ),
              const Expanded(
                flex: 6,
                child: Align(
                  child: Text("please login to see your stats"),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', ModalRoute.withName('/menu'));
                          },
                          child: const Text('Go to Login'),
                        )),
                  ),
                ],
              ),
            ],
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
                            begin: SkiWmColors.primary,
                            end: SkiWmColors.label)),
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
          color: SkiWmColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: SkiWmColors.primary,
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
                  color: SkiWmColors.black,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: SkiWmColors.black,
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
          color: SkiWmColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: SkiWmColors.primary,
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
                  color: SkiWmColors.black,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: SkiWmColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
