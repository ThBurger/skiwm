import 'package:skiwm/models/leadboard_entry_response.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/network/leaderboard_api_provider.dart';

class LeaderBoardRepository {
  final LeaderboardApiProvider _apiProvider = LeaderboardApiProvider();

  Future<LeaderboardEntryResponse> getLeaderboardEntries(
      String id, int maxResults) {
    return _apiProvider.getLeaderboardEntries(id, maxResults);
  }

  Future<LeaderboardEntryResponse> setLeaderboardEntry(
      LeaderboardEntry entry) async {
    return _apiProvider.setLeaderboardEntry(entry);
  }
}
