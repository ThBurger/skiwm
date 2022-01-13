import 'package:flutter/material.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/results.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    print(races);
    AppBar appBar = AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Leaderboards',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          creditChip(),
        ]);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Select Race",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                DropdownSearch<Race>(
                  showSelectedItems: true,
                  compareFn: (i, s) => i?.isEqual(s) ?? false,
                  validator: (v) => v == null ? "required field" : null,
                  dropdownSearchDecoration: const InputDecoration(
                    hintText: "Select a race",
                    labelText: "Race",
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                    border: OutlineInputBorder(),
                  ),
                  mode: Mode.MENU,
                  items: races,
                  itemAsString: (Race? r) => r!.racename!,
                  onChanged: (Race? data) => print(data),
                ),
                const Divider(),
                const SizedBox(height: 8.0),
                Results(),
                SizedBox(height: 10.0),
                Text(
                  "Made with ❤ by Toburg Labs.",
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 8.0),
                // ProductCarousel(imgArray: articlesCards["Music"]!["products"]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _customDropDownExample(BuildContext context, Race? item) {
  if (item == null) {
    return Container();
  }

  return Container(
    child: ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(item.racename!),
    ),
  );
}
