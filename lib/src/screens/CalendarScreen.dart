import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_template/src/widgets/CircleButton.dart';
import 'package:flutter_template/src/widgets/AppBottomNavigationBar.dart';

const double _calendarHeight = 300;

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  ScrollController scrollController;

  String locale = "en_UK";
  DateTime selectedDate = DateTime.now();
  DateTime oldest = DateTime.now();
  DateTime newest = DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

  List<DateTime> monthList = [DateTime.now(), DateTime(DateTime.now().year, DateTime.now().month + 1, 1)];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(locale);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.outOfRange) {
        return;
      }

      // NOTE: If scroll when offset is 0, exception will be thrown. (needs framework improvement:()
      if (scrollController.position.minScrollExtent < scrollController.offset && scrollController.offset <= 10) {
        prependMonths();
      } else if (scrollController.offset >= scrollController.position.maxScrollExtent) {
        appendMonths();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: _scrollToToday,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            // NOTE: Because we can't scroll up from the initial position (y == 0),
            // it'll offer a better scrolling experience to wrap Calendar with GestureDetector.
            child: GestureDetector(
              onVerticalDragDown: (DragDownDetails detail) {
                if (scrollController.offset == 0) {
                  prependMonths();
                }
              },
              child: _buildCalendar(context),
            ),
          ),
          _buildSchedules(context),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.white, fontSize: 12);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Center(child: Text("Su", style: style))),
            Expanded(child: Center(child: Text("Mo", style: style))),
            Expanded(child: Center(child: Text("Tu", style: style))),
            Expanded(child: Center(child: Text("We", style: style))),
            Expanded(child: Center(child: Text("Th", style: style))),
            Expanded(child: Center(child: Text("Fr", style: style))),
            Expanded(child: Center(child: Text("Sa", style: style))),
          ],
        ),
        Padding(padding: const EdgeInsets.only(bottom: 5)),
        Container(
          height: _calendarHeight,
          child: ListView.builder(
            controller: scrollController,
            itemCount: monthList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: _calendarHeight,
                child: _buildMonth(context, monthList[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonth(BuildContext context, DateTime date) {
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = () {
      DateTime nextMonthFirstDay = DateTime(date.year, date.month + 1, 1);
      return DateTime(nextMonthFirstDay.year, nextMonthFirstDay.month, nextMonthFirstDay.day - 1);
    }();
    int skippedSlotCount = 0;
    return Container(
      height: _calendarHeight,
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              DateFormat.yMMM(locale).format(date),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              // NOTE: physics: resolve the conflict with ListView's scroll events
              // @link https://github.com/flutter/flutter/issues/19205
              physics: ScrollPhysics(),
              crossAxisCount: 7,
              children: List.generate(35, (int index) {
                if (firstDay.weekday != 7 && index < 7 && (index < firstDay.weekday)) {
                  ++skippedSlotCount;
                  return GridTile(child: Container());
                }
                if (lastDay.day < index - skippedSlotCount + 1) {
                  return GridTile(child: Container());
                }
                int day = index - skippedSlotCount + 1;
                bool selected = selectedDate != null &&
                    date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    day == selectedDate.day;
                return GridTile(
                  child: TextCircleButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = DateTime(date.year, date.month, day);
                      });
                    },
                    elevation: 0,
                    text: '$day',
                    fontSize: 16,
                    textColor: selected ? Theme.of(context).primaryColor : Colors.white,
                    backgroundColor: selected ? Colors.white : Theme.of(context).primaryColor,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedules(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).splashColor,
        child: ListView(
          children: _getSchedule(),
        ),
      ),
    );
  }

  List<Widget> _getSchedule() {
    return [
      _buildSchedule("${selectedDate.month}/${selectedDate.day} - 1", "Location 1"),
      _buildSchedule("${selectedDate.month}/${selectedDate.day} - 2", "Location 2"),
      _buildSchedule("${selectedDate.month}/${selectedDate.day} - 3", "Location 3"),
    ];
  }

  Widget _buildSchedule(String title, String location) {
    TextStyle caption = Theme.of(context).textTheme.caption;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("9:00-", style: caption),
                Text("12:00", style: caption),
              ],
            ),
            Padding(padding: const EdgeInsets.only(left: 30.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title),
                  Text(location, style: caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void prependMonths() {
    setState(() {
      monthList.insert(0, DateTime(oldest.year, oldest.month - 1, 1));
      monthList.insert(0, DateTime(oldest.year, oldest.month - 2, 1));
      oldest = DateTime(oldest.year, oldest.month - 2, 1);
    });
    // NOTE: Because `setState` set scroll offset to 0, we have to restore current position.
    scrollController.jumpTo(_calendarHeight * 2);
  }

  void appendMonths() {
    setState(() {
      monthList.add(DateTime(newest.year, newest.month + 1, 1));
      monthList.add(DateTime(newest.year, newest.month + 2, 1));
      newest = DateTime(newest.year, newest.month + 2, 1);
    });
  }

  void _scrollToToday() {
    DateTime now = DateTime.now();
    int monthDiff = (now.year - oldest.year) == 0
        ? now.month - oldest.month
        : (now.year * 12 + now.month) - (oldest.year * 12 + oldest.month);
    int distance = ((_calendarHeight * monthDiff) - scrollController.offset).floor().abs();

    // NOTE: If distance is less than 20 months, then scroll back smoothly.
    if (distance < _calendarHeight * 20) {
      scrollController.animateTo(
        _calendarHeight * monthDiff,
        duration: Duration(milliseconds: (distance / 3).floor()),
        curve: Curves.linear,
      );
      setState(() {
        selectedDate = now;
      });
      return;
    }

    // NOTE: Otherwise, jump.
    scrollController.jumpTo(_calendarHeight * monthDiff);
    setState(() {
      selectedDate = now;
    });
  }
}
