import 'package:flutter/material.dart';
import 'package:skiwm/models/leadboard_entry_response.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/network/leaderboard_bloc.dart';
import 'package:collection/collection.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ResultPage extends StatefulWidget {
  final String raceId;
  const ResultPage({Key? key, required this.raceId}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    if (widget.raceId != '') {
      leaderboardBloc.getResults(widget.raceId);
    }
  }

  @override
  void dispose() {
    leaderboardBloc.emptyResult();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LeaderboardEntryResponse>(
      stream: leaderboardBloc.subject.stream,
      builder: (context, AsyncSnapshot<LeaderboardEntryResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          } else if (snapshot.data!.results.isEmpty) {
            return const Text("No results available yet");
          }
          return _buildUserWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.data!.error);
        } else {
          if (widget.raceId != '') {
            return _buildLoadingWidget();
          } else {
            return const Text("Choose Race Id before Results were loaded");
          }
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Loading data from API..."),
        CircularProgressIndicator()
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildUserWidget(LeaderboardEntryResponse data) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.results
                .mapIndexed((index, entry) => createTile(index + 1, entry))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget createTile(int index, LeaderboardEntry entry) {
    bool _isUsers = userLeaderboardEntries
        .where((element) => element.id == entry.id)
        .isNotEmpty;
    return Container(
      decoration: BoxDecoration(
        color: _isUsers ? SkiWmColors.success : SkiWmColors.white,
        border: const Border(
          bottom: BorderSide(color: SkiWmColors.border, width: 1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 0.0),
                child:
                    CircleAvatar(radius: 15.0, child: Text(index.toString()))),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    entry.username!,
                  ),
                  const SizedBox(width: 6.0),
                ],
              ),
            ),
            SizedBox(
              width: 100.0,
              child: Text(StopWatchTimer.getDisplayTime(entry.finishedTime!)),
            ),
          ],
        ),
      ),
    );
  }
}
