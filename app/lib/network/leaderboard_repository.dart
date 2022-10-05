import 'package:retroskiing/models/leadboard_entry_response.dart';
import 'package:retroskiing/models/leaderboard_entry.dart';
import 'package:retroskiing/network/leaderboard_api_provider.dart';

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
