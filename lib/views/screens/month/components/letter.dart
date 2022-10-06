import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';



class Letter extends StatefulWidget {

  final String letter;
  final String? image;

  const Letter({
    Key? key,
    this.letter = '',
    this.image
  }) : super(key: key);

  @override
  State<Letter> createState() => _LetterState();
}

class _LetterState extends State<Letter> {

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {


    var pages = widget.letter.split('**new**').reversed;


    return PageView.builder(
      controller:pageController,
      itemCount: pages.length,
      itemBuilder: (context, index){
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                
                if(widget.image != null)
                  ...[
                    CachedNetworkImage(
                      imageUrl: widget.image!
                      )
                  ],
               
                Text(
                    '${pages.elementAt(index)}',
                
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: general_text_color,
                      height: 2,
                      wordSpacing: 2
                    ),
                  ),

                  SizedBox(
                    height: 50
                  )
                
                  ],
                ),
              ),
            ),




            Positioned(
              bottom: 10,
              right: 5,
              child:  TextButton(
                onPressed: (){
                  if(index < pages.length-1){
                      pageController.nextPage(
                      duration: Duration(milliseconds: 200), 
                      curve: Curves.easeInCirc
                    );
                  }
                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: cricGreen,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bg_color
                      ),
                    ),
                  ),
                ),
              )
              ),


            Positioned(
              bottom: 10,
              left: 5,
              child:  TextButton(
                onPressed: (){
                  if(index > 0){
                      pageController.previousPage(
                      duration: Duration(milliseconds: 200), 
                      curve: Curves.easeInCirc
                    );
                  }
                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: cricGreen,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Text(
                      'Prev',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bg_color
                      ),
                    ),
                  ),
                ),
              )
              ),



            Positioned(
              bottom: 20,
              right: (MediaQuery.of(context).size.width/2)-15,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: cricGreen,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Text(
                    '${index+1}/${pages.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: bg_color
                    ),
                  ),
                ),
              )
              ),

          ],
        );
      },
    );
  }
}



