import 'package:get/get.dart';
import 'package:retroskiing/models/profile.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/constants.dart';
import 'package:retroskiing/utils/value_notifiers.dart';

class CreditsService {
  static int getCredits() {
    return userProfile.credits ?? 0;
  }

  static int addCredits(int credits) {
    int newCredits = getCredits() + credits;
    _updateCredits(newCredits);
    userProfile = Profile(
        id: userProfile.id,
        username: userProfile.username,
        country: userProfile.country,
        credits: newCredits);
    creditsValueNotifier.value = newCredits;
    return getCredits();
  }

  static Future<void> _updateCredits(int newCredits) async {
    final updates = {
      'id': userProfile.id!,
      'updated_at': DateTime.now().toIso8601String(),
      'username': userProfile.username!,
      'country': userProfile.country,
      'credits': newCredits,
    };

    final responseUpsert =
        await supabase.from('profiles').upsert(updates).execute();
    final errorUpsert = responseUpsert.error;
    if (errorUpsert != null && responseUpsert.status != 406) {
      Get.context!.showErrorSnackBar(message: errorUpsert.message);
    }
  }
}
