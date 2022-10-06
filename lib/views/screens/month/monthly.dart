import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/month/components/events.dart';
import 'package:ecommerce/views/screens/month/components/letter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class MyMonth extends StatefulWidget {
  final int? monthD;
  final Map<String,dynamic>? data;
  const MyMonth({
    Key? key,
    this.monthD,
    this.data
  }) : super(key: key);

  @override
  State<MyMonth> createState() => _MyMonthState();
}

class _MyMonthState extends State<MyMonth> {

  final months =['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  final  _myMonthData = Monthly();
  Map<String, dynamic> myData={};

  Future<void> gmyMonth()async{

    final id = '${DateTime.now().month}_${DateTime.now().year}';
    final d=await  _myMonthData.getMonthData(id);
    setState(() {
      myData = d!;
    });
    
  }


  void screens(){
    setState(() {
      _pages=[
        Letter(
          letter: widget.data!['letter'],
          image: widget.data!['img'],
    ),
    
    Events(
        events: widget.data!['events'],
      )

      ];
    }
    );
  }


  Widget? _body;
  String _title='';
  int _current = 0;

  List _titles = [

    'Letter',
    'Events and Calendar',
  ];


  List<Widget> _pages = [

    Letter(
    ),
    
    Events(),

  ];

  void getBody(int page){
    _current=page;


    setState(() {
      if(_current == 0){
      _title='${months.elementAt(DateTime.now().month-1)} Letter';
    }
    else{
      _title=_titles.elementAt(_current);
    }
      _body = _pages.elementAt(_current);
      
    });
  }

  @override
  void initState() {
    screens();
    getBody(0);
    gmyMonth();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      appBar: AppBar(
        backgroundColor: bg_color,
        title: Text(
          _title,
          style: TextStyle(
            color: general_text_color
          ),
        ),

        elevation: 0,

        leading: IconButton(
          onPressed:(){
            Navigator.pop(context);
          }, icon: Icon(
            Icons.arrow_back,
            color: general_text_color,
          )),

      ),

      body: _body,

      bottomNavigationBar: BottomNavigationBar(

        onTap: (index){
          getBody(index);
        },

        elevation: 0,
        selectedItemColor: cricGreen,
        unselectedItemColor: bg_deep,
        showUnselectedLabels: false,
        currentIndex: _current,

        backgroundColor: bg_color,



        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bookOpen
              
              ),

              label: 'Letter'

            ),

          
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.calendar
              ),

              label: 'Event'

            ),

        ]
         
        ),

    );
    
  }
}




