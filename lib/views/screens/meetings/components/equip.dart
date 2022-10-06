import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';



class EQUIP extends StatelessWidget {
  const EQUIP({
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
Last Mondays & Tuesdays of every month.
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
EQUIP ( Encouraging Quality, unity and Integrity in Pastors) is a Pastors and Leaders meeting, where Pastors gather from all over the country to Learn Biblical principle in the word of God for the furtherance of the Gospel.
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



