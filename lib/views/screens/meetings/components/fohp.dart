import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';



class FOHP extends StatelessWidget {
  const FOHP({
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
Fifth friday of every month.
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
Fragrance of His Presence is a meeting where God meets the needs of His children and a meeting where the Sick receives their healing and destinies are altered, the word of God is taught and the love of God is tangible in the atmosphere.
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



