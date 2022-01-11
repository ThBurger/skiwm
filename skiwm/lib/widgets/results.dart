import 'package:flutter/material.dart';
import 'package:skiwm/utils/Theme.dart';

final List<Friend> friends = [
  Friend('1', 'John', 'Hello, how are you?', '😄'),
  Friend('2', 'RIna', 'Hello, how are you?', '😄'),
  Friend('3', 'Brad', 'Hello, how are you?', '1 hr.'),
  Friend('4', 'Don', 'Hello, how are you?', '1 hr.'),
  Friend('5', 'Mukambo', 'Hello, how are you?', '1 hr.'),
  Friend('6', 'Sid', 'Hello, how are you?', '1 hr.'),
  Friend('999', 'Sid', 'Hello, how are you?', '1 hr.'),
];

class Friend {
  String rank, name, message, msgTime;

  Friend(this.rank, this.name, this.message, this.msgTime);
}

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    createTile(Friend friend) => Container(
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
                    child:
                        CircleAvatar(radius: 15.0, child: Text(friend.rank))),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        friend.name,
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        friend.msgTime,
                      ),
                    ],
                  ),
                ),
                Container(width: 50.0, child: Text("02:50")),
              ],
            ),
          ),
        );

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: friends.map((book) => createTile(book)).toList(),
          ),
        ),
      ),
    );
  }
}
