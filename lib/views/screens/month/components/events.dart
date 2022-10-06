//import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class Events extends StatefulWidget {
  final List events;

  const Events({
    Key? key,
    this.events=const []

  }) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
/////////////////////////
///'title': eventTitleController.text,
//        'date': e.toString(),
  //      'desc'


  final CalendarView calendarView = CalendarView.schedule;


  
List<Appointment> get getMeetings{
  return widget.events.map((e){
    final date = DateTime.parse(e['date']);

    return Appointment(
      startTime: DateTime(date.year, date.month, date.day, date.hour, date.minute, 0), 
      endTime: DateTime(date.year, date.month, date.day, date.hour, date.minute, 0).add(Duration(hours: 3)),
      subject: e['title'],
      notes: e['desc'],
      color: cricGreen
      );
  })
  .toList();
}

  List? appointments;


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
         top: 15,
         bottom: 15,
         left: 10,
         right: 10,
        ),
        child: SfCalendar(
              view: calendarView,

              minDate: DateTime.now().subtract(Duration(days: 10)),
              maxDate: DateTime.now().add(Duration(days: 30)),

              scheduleViewSettings: ScheduleViewSettings(
                appointmentItemHeight: 60,

                hideEmptyScheduleWeek: true,
                monthHeaderSettings: MonthHeaderSettings(
                  height: 100,
                  backgroundColor: Color.fromARGB(255, 45, 45, 247),
                  monthTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 1.5,
                  )
                ),

                weekHeaderSettings: WeekHeaderSettings(
                  height: 40,
                  textAlign: TextAlign.center
                )
              ),

              dataSource: Meetings(getMeetings),

              onTap: (detail){
                setState(() {
                  appointments = detail.appointments;
                });
              },

            ),
  /*        
          if(appointments!.isNotEmpty && appointments != null)
            ...[
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: appointments!.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: ClipOval(
                          
                              child: Container(
                                color: cricGreen,
                                padding: EdgeInsets.all(10),
                                child: Text('${index+1}',
                                
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber
                                ),
                                
                                )
                                ),
                          
                            ),
                          ),

                          Flexible(
                            child: Text(
                                
                                appointments![index].subject,
                                
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: cricGreen
                                ),
                                
                                )
                          )                          


                        ],
                      )
                    ],
                  );
                },
              )
            ]

*/


      ),
    );
  }
}




class Meetings extends CalendarDataSource{
  Meetings(List<Appointment> s){
    appointments = s;
  }
}

