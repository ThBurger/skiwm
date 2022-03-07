import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:skiwm/models/race.dart';

class SlideItem extends StatefulWidget {
  final Race raceItem;

  const SlideItem({
    Key? key,
    required this.raceItem,
  }) : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width / 1.3,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/race',
              arguments: widget.raceItem,
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.7,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.asset(
                          widget.raceItem.img!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.star,
                                size: 10,
                              ),
                              Text(
                                " ${widget.raceItem.difficulty!} ",
                                style: const TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    buildOpenClosedWidget(),
                  ],
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.raceItem.racename!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Credits entry costs: " +
                          widget.raceItem.credits!.toString(),
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildOpenClosedWidget() {
    if (DateTime.now().isBefore(widget.raceItem.fromDate!)) {
      return Positioned(
        top: 6.0,
        left: 6.0,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Text('Starts in ',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    )),
                CountdownTimer(
                    endTime: (widget.raceItem.fromDate!.millisecondsSinceEpoch),
                    textStyle: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        top: 6.0,
        left: 6.0,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              " OPEN ",
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }
}
