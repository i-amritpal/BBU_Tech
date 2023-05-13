import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calander extends StatefulWidget {
  const Calander({Key? key}) : super(key: key);

  @override
  State<Calander> createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  //defining map to store data so that it can be used at backend
  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    //TODO: implement initstate
    super.initState();
    _selectedDate = _focusedDay;

    loadPreviousEvents();
  }

  //Displaying previous events
  loadPreviousEvents() {
    mySelectedEvents = {
      '2023-04-29': [
        {'eventDescp': '11', 'eventTitle': '111'},
        {'eventDescp': '22', 'eventTitle': '222'}
      ],
      '2023-05-04': [
        {'eventDescp': 'Day 1', 'eventTitle': 'Paper Presentstion'},
        {'eventDescp': 'Day 2', 'eventTitle': 'Paper Presentstion'}
      ],
    };
  }

  //Returning the added events
  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Add New Event",
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: Text('Add Event'),
            onPressed: () {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required Title and Description!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                print(titleController.text);
                print(descpController.text);

                //checking if there is any already existing event or not
                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    //if yes then add new event on that date as well
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      'eventTitle': titleController.text,
                      'eventDescp': descpController.text,
                    });
                  } else {
                    //if not then adding a new event
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        'eventTitle': titleController.text,
                        'eventDescp': descpController.text,
                      }
                    ];
                  }
                });

                //prnting the event made into the map
                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");

                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Calendar'),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue]
                )
            )
        ),
      ),

      //making simple calendar
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2060),
            calendarFormat: _calendarFormat,

            //Selecting a date
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                //call 'setState() when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },

            //changing calendar format
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                //call setState() when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              //no need to call setState() here
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          ..._listOfDayEvents(_selectedDate!).map(
            (myEvents) => ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.purple,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Event Title: ${myEvents['eventTitle']}'),
              ),
              subtitle: Text('Decoration: ${myEvents['eventDescp']}'),
            ),
          ),
        ],
      ),

      //making button to add events
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddEventDialog(),
          label: const Text('Add Event')),
    );
  }

}
