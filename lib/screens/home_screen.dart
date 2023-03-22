// ignore_for_file: must_be_immutable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photolog/extensions/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../state/photolog/photolog_notifier.dart';
import '../utility/utility.dart';
import '_alert/daily_photo_alert.dart';
import '_parts/photolog_dialog.dart';
import 'input_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final Utility _utility = Utility();

  Map<DateTime, List<String>> eventsList = {};

  ///
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final photologState = _ref.watch(photologProvider);

    //--------------------------------------------- event
    var keepYmd = '';

    photologState.forEach((element) {
      final exGetDate = element.date.split(' ');
      if (exGetDate[0] != keepYmd) {
        eventsList[DateTime.parse(exGetDate[0])] = [];
      }
      eventsList[DateTime.parse(exGetDate[0])]?.add(exGetDate[0]);
      keepYmd = exGetDate[0];
    });

    final events = LinkedHashMap<DateTime, List<dynamic>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(eventsList);

    List<dynamic> getEventForDay(DateTime day) {
      return events[day] ?? [];
    }
    //--------------------------------------------- event

    final focusDayState = ref.watch(focusDayProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.yellowAccent.withOpacity(0.6),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputScreen()),
                          );
                        },
                        icon: Icon(
                          Icons.input,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Divider(
                color: Colors.white.withOpacity(0.3),
                thickness: 2,
              ),

              ///////////// calendar
              Container(
                height: context.screenSize.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                ),
                child: TableCalendar(
                  eventLoader: getEventForDay,

                  rowHeight: 35,

                  ///
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(color: Colors.transparent),
                    selectedDecoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),

                    ///
                    todayTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                    selectedTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                    rangeStartTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                    rangeEndTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                    disabledTextStyle: TextStyle(color: Colors.grey),
                    weekendTextStyle: TextStyle(color: Colors.white),

                    ///
                    markerDecoration: BoxDecoration(color: Colors.white),
                    rangeStartDecoration:
                        BoxDecoration(color: Color(0xFF6699FF)),
                    rangeEndDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                    holidayDecoration: BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Color(0xFF9FA8DA),
                        ),
                      ),
                    ),
                  ),

                  ///
                  headerStyle: const HeaderStyle(formatButtonVisible: false),
                  firstDay: DateTime.utc(2020),
                  lastDay: DateTime.utc(2030, 12, 31),

                  focusedDay: focusDayState,

                  ///
                  selectedDayPredicate: (day) {
                    return isSameDay(ref.watch(blueBallProvider), day);
                  },

                  ///
                  onDaySelected: (selectedDay, focusedDay) {
                    onDayPressed(date: selectedDay);
                  },

                  ///
                  onPageChanged: (focusedDay) {
                    onPageMoved(date: focusedDay);
                  },
                ),
              ),
              ///////////// calendar
            ],
          ),
        ],
      ),
    );
  }

  ///
  void onDayPressed({required DateTime date}) {
    _ref.watch(blueBallProvider.notifier).setDateTime(dateTime: date);
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);

    PhotologDialog(
      context: _context,
      widget: DailyPhotoAlert(date: date),
    );
  }

  ///
  void onPageMoved({required DateTime date}) {
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);
  }
}

////////////////////////////////////////////////////////////
final focusDayProvider =
    StateNotifierProvider.autoDispose<FocusDayStateNotifier, DateTime>((ref) {
  return FocusDayStateNotifier();
});

class FocusDayStateNotifier extends StateNotifier<DateTime> {
  FocusDayStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}

////////////////////////////////////////////////////////////
final blueBallProvider =
    StateNotifierProvider.autoDispose<BlueBallStateNotifier, DateTime>((ref) {
  return BlueBallStateNotifier();
});

class BlueBallStateNotifier extends StateNotifier<DateTime> {
  BlueBallStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}
