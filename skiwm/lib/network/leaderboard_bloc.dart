import 'package:rxdart/rxdart.dart';
import 'package:skiwm/models/leadboard_entry_response.dart';
import 'package:skiwm/network/leaderboard_repository.dart';

class LeaderboardBloc {
  final LeaderBoardRepository _repository = LeaderBoardRepository();
  final BehaviorSubject<LeaderboardEntryResponse> _subject =
      BehaviorSubject<LeaderboardEntryResponse>();

  getResults(String id, int maxResults) async {
    LeaderboardEntryResponse response =
        await _repository.getLeaderboardEntries(id, maxResults);

    _subject.sink.add(response);
  }

  emptyResult() {
    LeaderboardEntryResponse response =
        LeaderboardEntryResponse(List.empty(), "");

    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LeaderboardEntryResponse> get subject => _subject;
}

final leaderboardBloc = LeaderboardBloc();
