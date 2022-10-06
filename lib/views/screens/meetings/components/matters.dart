import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';



class Matters extends StatelessWidget {
  const Matters({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
         top: 10,
         bottom: 15,
         left: 40,
         right: 30,
        ),
        child: Column(
          children: [

            Text(
              """
First thursday of every month.
    """,
    
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: cricGreen,
                height: 2.4,
                wordSpacing: 2
              ),
            ),


            Text(
              """
Matters of the Heart a marriage and relationship meeting for married and intending couples with Apostle David wale Feso, in this meeting, Youths and singles are also privileged to ask questions and real biblical answers are given.
    """,
    
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                color: general_text_color,
                height: 2.4,
                wordSpacing: 2
              ),
            ),
          ],
        ),
      ),
    );
  }
}



