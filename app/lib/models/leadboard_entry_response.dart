import 'package:retroskiing/models/leaderboard_entry.dart';

class LeaderboardEntryResponse {
  final List<LeaderboardEntry> results;
  final String error;

  LeaderboardEntryResponse(this.results, this.error);

  LeaderboardEntryResponse.fromMap(List<dynamic> json)
      : results = json.map((i) => LeaderboardEntry.fromMap(i)).toList(),
        error = "";

  LeaderboardEntryResponse.fromJson(Map<String, dynamic> json)
      : results = (json["results"] as List)
            .map((i) => LeaderboardEntry.fromMap(i))
            .toList(),
        error = "";

  LeaderboardEntryResponse.withError(String errorValue)
      : results = List.empty(),
        error = errorValue;
}
