import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/widgets/drawer.dart';
import 'package:supabase/supabase.dart';
import 'package:retroskiing/components/auth_state.dart';
import 'package:retroskiing/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<LoginPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  late final TextEditingController _emailController;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase.auth.signIn(
        email: _emailController.text.trim(),
        options: AuthOptions(
            redirectTo: kIsWeb
                ? null
                : 'io.supabase.flutterquickstart://login-callback/'));
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    } else {
      context.showSnackBar(message: 'Check your email for login link!');
      _emailController.clear();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Sign in via your email below',
              style: TextStyle(color: RetroSkiingColors.white),
            ),
            const Text(
              'After receiving the email click on the link in the email',
              style: TextStyle(color: RetroSkiingColors.white),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(color: RetroSkiingColors.white),
            ),
            const SizedBox(height: 18),
            Container(
              height: RetroSkiingStyle.buttonHeight,
              decoration: BoxDecoration(
                gradient: _isLoading
                    ? RetroSkiingStyle.gradientGrey
                    : RetroSkiingStyle.gradient,
                borderRadius: RetroSkiingStyle.borderRadius,
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                child: Text(_isLoading ? 'Loading' : 'Send Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
