import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/about/components/mission.dart';
import 'package:ecommerce/views/screens/about/components/statement.dart';
import 'package:ecommerce/views/screens/about/components/vision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class AboutUs extends StatefulWidget {
  final int? page;
  const AboutUs({
    Key? key,
    this.page
  }) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  Widget? _body;
  int _current = 0;

  List<Widget> _pages = [

    Vision(),
    
    Mission(),
    
    Statement(),

  ];

  void getBody(int page){
    _current=page;
    setState(() {
      _body = _pages.elementAt(_current);
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
              FontAwesomeIcons.lightbulb,
              
              ),

              label: 'vision'

            ),

          
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.rocket,
              ),

              label: 'mission'

            ),


          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.earHearing,
              ),

              label: 'statement'

            )
        ]
        
        
        
        ),

    );
    
  }
}




