import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Utility/CalendarUtility.dart';
import 'dart:collection';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  List<Event> getDailyEvent(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> getDailyEvents(Iterable<DateTime> days) {
    return [
      for (final day in days) ...getDailyEvent(day),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    // String noteText = "";

    // for (TextNote textNote in noteObserver.usersNotes) {
    //   bool isEvent = textNote.isEvent;
    //   if (isEvent) {
    //     if (textNote.text.toString() != "") {
    //       noteText = textNote.text.toString();
    //     }
    //     eventDate = textNote.eventDate;
    //   }
    // }
    return Text("Coming");
    // return Column(children: [
    //   TableCalendar<Event>(
    //     firstDay: kFirstDay,
    //     lastDay: kLastDay,
    //     focusedDay: _focusedDay.value,
    //     headerVisible: true,
    //     //selectedDayPredicate: (day) => selectedDays.contains(day),
    //     selectedDayPredicate: (day) => selectedDays.contains(day),
    //     rangeStartDay: _rangeStart,
    //     rangeEndDay: _rangeEnd,
    //     calendarFormat: _calendarFormat,
    //     rangeSelectionMode: _rangeSelectionMode,
    //     eventLoader: getDailyEvent,
    //     calendarStyle: CalendarStyle(outsideDaysVisible: false),
    //     onDaySelected: selectedDay,

    //     onCalendarCreated: (controller) => pageController = controller,
    //     onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
    //     onFormatChanged: (format) {
    //       if (_calendarFormat != format) {
    //         setState(() => _calendarFormat = format);
    //       }
    //     },
    //   ),
    //   const SizedBox(height: 8.0),
    //   Expanded(
    //     child: ValueListenableBuilder<List<Event>>(
    //       valueListenable: calendarEvents,
    //       builder: (context, value, _) {
    //         return ListView.builder(
    //           itemCount: value.length,
    //           itemBuilder: (context, index) {
    //             return Container(
    //               margin: const EdgeInsets.symmetric(
    //                 horizontal: 12.0,
    //                 vertical: 4.0,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(),
    //                 borderRadius: BorderRadius.circular(12.0),
    //               ),
    //               child: ListTile(
    //                 onTap: () => (noteObserver.currNoteForDetails),
    //                 title: Text(noteText),
    //               ),
    //             );
    //           },
    //         );
    //       },
    //     ),
    //   ),
    // ]);
  }
}

// based on https://github.com/aleksanderwozniak/table_calendar/blob/master/example/lib/pages/basics_example.dart