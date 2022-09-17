import 'package:flutter/material.dart';
import 'package:skiwm/models/profile.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/utils/value_notifiers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    debugPrint("on UNauthenticatd in AuthState");
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      _getProfile(supabase.auth.user()!.id).then((value) => {
            userProfile = value,
            creditsValueNotifier.value = userProfile.credits!,
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/menu', (route) => false)
          });
    }
  }

  Future<Profile> _getProfile(String userId) async {
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
      return Profile.fromMap(data);
    }
    return const Profile();
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    //context.showErrorSnackBar(message: message);
  }
}
