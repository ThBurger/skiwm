import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:skiwm/models/leadboard_entry_response.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/network/leaderboard_bloc.dart';
import 'package:collection/collection.dart';
import 'package:skiwm/utils/utils.dart';
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.results
            .mapIndexed((index, entry) => createTile(index + 1, entry))
            .toList(),
      ),
    );
  }

  Widget createTile(int index, LeaderboardEntry entry) {
    String userId = userProfile.id ?? '';
    bool _isUsers = userId == entry.userId;
    String rewardCredits = Utility.rewardedCretids(index);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            index.toString() + ".",
            style: TextStyle(
                color: _isUsers ? SkiWmColors.success : SkiWmColors.white),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Flag.fromString(
                  entry.country!,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 12.0),
                Text(
                  entry.username!,
                  style: TextStyle(
                      color:
                          _isUsers ? SkiWmColors.success : SkiWmColors.white),
                ),
              ],
            ),
          ),
          Chip(
            labelPadding: const EdgeInsets.all(3.0),
            avatar: const CircleAvatar(
              child: Text("C"),
            ),
            label: Text(
              rewardCredits,
              style: const TextStyle(
                color: SkiWmColors.primary,
              ),
            ),
            elevation: 6.0,
            shadowColor: Colors.grey[60],
          ),
          const SizedBox(width: 18.0),
          SizedBox(
            width: 75.0,
            child: Text(
                StopWatchTimer.getDisplayTime(entry.finishedTime!,
                    hours: false),
                style: TextStyle(
                    color: _isUsers ? SkiWmColors.success : SkiWmColors.white)),
          ),
        ],
      ),
    );
  }
}
