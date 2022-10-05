import 'package:flutter/foundation.dart';
import 'package:retroskiing/models/leadboard_entry_response.dart';
import 'package:retroskiing/models/leaderboard_entry.dart';
import 'package:retroskiing/utils/constants.dart';

class LeaderboardApiProvider {
  Future<LeaderboardEntryResponse> getLeaderboardEntries(
      String id, int maxResults) async {
    try {
      final response = await supabase.from('results').select('''
          id,
          updated_at,
          user_id,
          race_id,
          finished_time,
          profiles (
            username,
            country
          )
          ''').eq('race_id', id).limit(maxResults).execute();
      final error = response.error;
      if (error != null && response.status != 406) {
        debugPrint("Exception occured: $error");
        return LeaderboardEntryResponse.withError("$error");
      }
      return LeaderboardEntryResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return LeaderboardEntryResponse.withError("$error");
    }
  }

  Future<LeaderboardEntryResponse> setLeaderboardEntry(
      LeaderboardEntry entry) async {
    final updates = {
      'id': entry.id,
      'updated_at': entry.updatedAt!.toIso8601String(),
      'user_id': entry.userId,
      'race_id': entry.raceId,
      'finished_time': entry.finishedTime
    };

    final response = await supabase.from('results').upsert(updates).execute();
    final error = response.error;
    if (error != null) {
      return LeaderboardEntryResponse.withError("$error");
    } else {
      return LeaderboardEntryResponse.fromMap([]);
    }
  }
}
