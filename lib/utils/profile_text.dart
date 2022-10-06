// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

class ProfileText extends StatefulWidget {

  final String title;
  final IconData icon;
  final bool opacity;

  const ProfileText({
    Key? key,
    required this.title,
    required this.icon,
    required this.opacity
    }) : super(key: key);

  @override
  State<ProfileText> createState() => _ProfileTextState();
}

class _ProfileTextState extends State<ProfileText> {

  bool hide = true;
  double minSize = 0;

  void hideOrShow(bool cond){

    cond == false ?
    setState(() {
        hide = false;
        minSize = 28;
      }
    ) :
    setState(() {
        hide = true;
        minSize = 0;
      }
    )
    ;
    
  }


  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [

          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Icon(
              widget.icon,
            ),
          ),

          SizedBox(
            width: 10,
          ),

          Container(
             padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                fontSize: 22
              ),
            ),
          ),


          SizedBox(
            width: 5,
          ),

          Opacity(
            opacity: widget.opacity == true ? 1 : 0,
            child: Container(
              width: widget.opacity == true ? 35 : 0,
              height: widget.opacity == true ? 35 : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 237, 236, 236),
              ),
              child: IconButton(
                onPressed: () {
                  widget.opacity == true ? null : null;
                },
                
                icon: Icon(
                  Icons.edit,
                  size: widget.opacity == true ? 20 : 0,
                )),
            ),
          )




        ],
      ),
    );
    
  }
}