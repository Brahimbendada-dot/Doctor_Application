import 'package:doctor_c/controller/patient/update_appointment_controller.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class UpdateAppointmentScreen extends StatefulWidget {
  UpdateAppointmentScreen({super.key});

  @override
  State<UpdateAppointmentScreen> createState() => _UpdateAppointmentScreenState();
}

class _UpdateAppointmentScreenState extends State<UpdateAppointmentScreen> {
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeek = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  CalendarFormat _format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<UpdateAppointmentController>(
      init: UpdateAppointmentController(),
      builder: (controller) => SafeArea(
          child: Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        _calendarTable(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Select Consultation Time',
                          style: textTheme.booldTextBlack,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  _isWeek
                      ? SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Weekend is not availaable, please select another date,',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    _timeSelected = true;
                                    _currentIndex = index;
                                    _currentDay =
                                        _currentDay.copyWith(hour: index + 8);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _currentIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      color: _currentIndex == index
                                          ? ColorTheme.primary
                                          : null),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                                    style: TextStyle(
                                      color: _currentIndex == index
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 8,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, childAspectRatio: 1.5),
                        ),
                  SliverToBoxAdapter(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 80),
                        child: Button('Update appointment', () {
                          AppointmentModel appointment = AppointmentModel(
                            validation: false,
                            doctorId: controller.doctor.id,
                            patientId: Apis.currentAuthenticateuser.uid,
                            dateTime: _currentDay,
                          );
                          if (_timeSelected && _dateSelected) {
                            final snackBar = SnackBar(
                              content: Text(
                                  "The appointment has been updated successfully"),
                            );
                            controller.updateAppointment(appointment);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        })),
                  )
                ],
              ))),
    ));
  }

  Widget _calendarTable() {
    return TableCalendar(
      calendarFormat: _format,
      rowHeight: 40,
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(3000),
      currentDay: _currentDay,
      calendarStyle: const CalendarStyle(
          todayDecoration:
              BoxDecoration(color: ColorTheme.primary, shape: BoxShape.circle)),
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          if (selectedDay.weekday == 5) {
            _isWeek = true;
            _currentIndex = null;
            _timeSelected = false;
          } else {
            _isWeek = false;
          }
        });
      }),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
    );
  }
}
