import 'package:skiwm/resources/globals.dart';

class Utility {
  static bool isUser() {
    return userProfile.id != null && userProfile.id!.isNotEmpty;
  }
}
