import 'package:flutter/material.dart';
import 'package:skiwm/utils/Theme.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/results.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool enableList = false;
  int _selectedIndex = 0;
  _onhandleTap() {
    setState(() {
      enableList = !enableList;
    });
  }

  _onChanged(int position) {
    setState(() {
      _selectedIndex = position;
      enableList = !enableList;
    });
  }

  List<Map> _testList = [
    {'no': 1, 'keyword': 'North Dron'},
    {'no': 2, 'keyword': 'Mabygo'},
    {'no': 3, 'keyword': 'La Shdencoe-In-Hayya'},
    {'no': 4, 'keyword': 'Manslodfield'},
    {'no': 5, 'keyword': 'Bridsportsicast'},
    {'no': 6, 'keyword': 'West Ston'},
    {'no': 7, 'keyword': 'Telshamtwich'},
    {'no': 8, 'keyword': 'Bingombmurington'},
    {'no': 9, 'keyword': 'Port Marlta'},
    {'no': 10, 'keyword': 'Leinecoffs'},
  ];

  Widget _buildSearchList() => Container(
        height: 150.0,
        decoration: BoxDecoration(
          border: Border.all(color: SkiWmColors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: EdgeInsets.only(top: 5.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: _testList.length,
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  _onChanged(position);
                },
                child: Container(
                    // padding: widget.padding,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: position == _selectedIndex
                            ? Colors.grey[100]
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    child: Text(
                      _testList[position]['keyword'],
                      style: TextStyle(color: Colors.black),
                    )),
              );
            }),
      );
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
                Text("Select Race"),
                const SizedBox(height: 8.0),
                InkWell(
                  onTap: _onhandleTap,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: enableList ? Colors.black : Colors.grey,
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 48.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          _selectedIndex != null
                              ? _testList[_selectedIndex]['keyword']
                              : "Select value",
                          style: TextStyle(fontSize: 16.0),
                        )),
                        Icon(Icons.expand_more,
                            size: 24.0, color: Color(0XFFbbbbbb)),
                      ],
                    ),
                  ),
                ),
                enableList ? _buildSearchList() : Container(),
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
