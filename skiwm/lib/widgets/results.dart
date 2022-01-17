import 'package:flutter/material.dart';
import 'package:skiwm/models/leadboard_entry_response.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/network/leaderboard_bloc.dart';

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
  Widget build(BuildContext context) {
    return StreamBuilder<LeaderboardEntryResponse>(
      stream: leaderboardBloc.subject.stream,
      builder: (context, AsyncSnapshot<LeaderboardEntryResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildUserWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          //return _buildErrorWidget(snapshot.error);
          return _buildLoadingWidget();
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Loading data from API..."), CircularProgressIndicator()],
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
            children: data.results.map((entry) => createTile(entry)).toList(),
          ),
        ),
      ),
    );
  }

  Widget createTile(LeaderboardEntry entry) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: SkiWmColors.border, width: 1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 0.0),
                child: CircleAvatar(
                    radius: 15.0, child: Text(entry.username![0]))),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    entry.username!,
                  ),
                  SizedBox(width: 6.0),
                ],
              ),
            ),
            Container(
                width: 100.0,
                child: Text(
                  entry.finishedTime!,
                )),
          ],
        ),
      ),
    );
  }
}
