import 'package:skiwm/models/leadboard_entry_response.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/network/leaderboard_api_provider.dart';

class LeaderBoardRepository {
  final LeaderboardApiProvider _apiProvider = LeaderboardApiProvider();

  Future<LeaderboardEntryResponse> getLeaderboardEntries(String id) {
    return _apiProvider.getLeaderboardEntries(id);
  }

  Future<LeaderboardEntryResponse> setLeaderboardEntry(
      LeaderboardEntry entry) async {
    return _apiProvider.setLeaderboardEntry(entry);
  }
}
