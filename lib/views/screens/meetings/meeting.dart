

import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/meetings/components/equip.dart';
import 'package:ecommerce/views/screens/meetings/components/fohp.dart';
import 'package:ecommerce/views/screens/meetings/components/matters.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class Meeting extends StatefulWidget {
  final int? page;
  const Meeting({
    Key? key,
    this.page
  }) : super(key: key);

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {


  Widget? _body;
  String _title='EQUIP';
  int _current = 0;

  List<String> _titles = [

    'EQUIP',
    'FOHP',
    'Matters of the Heart ',

  ];


  List<Widget> _pages = [

    EQUIP(),
    
    FOHP(),
    
    Matters(),

  ];

  void getBody(int page){
    _current=page;
    setState(() {
      _body = _pages.elementAt(_current);
      _title= _titles.elementAt(_current);
    });
  }

  @override
  void initState() {
    getBody(0);
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
              FontAwesomeIcons.personRunning
              
              ),

              label: 'EQUIP'

            ),

          
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.dove
              ),

              label: 'FoHP'

            ),


          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.heart,
              ),

              label: 'MOTH'

            )
        ]
         
        ),

    );
    
  }
}




