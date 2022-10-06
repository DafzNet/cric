// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, must_call_super

import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class DevSingleTextField extends StatefulWidget {

  final String head;
  final String? hintT;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final bool multLine;


  const DevSingleTextField({
    Key? key,
    
    required this.head,
    required this.hintT,
    required this.textController,
    this.focusNode,
    this.nextNode,
    this.multLine=true,
    }) : super(key: key);

  @override
  State<DevSingleTextField> createState() => _DevSingleTextFieldState();
}

class _DevSingleTextFieldState extends State<DevSingleTextField> {

    @override
    void dispose(){
      widget.textController!.dispose();
      widget.focusNode!.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 7, top: 7),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Text(
              '${widget.head}:',
              style: TextStyle(
                fontSize: 18,
                color: cricGreen,
              ),
            )
          ),



          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Container(
              
              decoration: BoxDecoration(
                color: bg_deep,
                borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.all(8),
          
              child: TextFormField(

                controller: widget.textController,
                focusNode: widget.focusNode,
                textInputAction: TextInputAction.next,

                maxLines: widget.multLine == true ? 2 : 1,
                minLines: 1,

                onFieldSubmitted: (submited){
                  FocusScope.of(context).requestFocus();
                },

                style: const TextStyle(
                  fontSize: 18,
                ),    


                decoration: InputDecoration.collapsed(
                  hintText: widget.hintT,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}










class DevMultTextField extends StatelessWidget {

  final String head;
  final String? hintT;
  final TextEditingController? textController;
  
  
  

  const DevMultTextField({
    Key? key,
    required this.head,
    required this.hintT,
    required this.textController,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              '$head:',
              style: TextStyle(
                fontSize: 18,
                color: cricGreen,
                fontWeight: FontWeight.bold
              ),
            ),
          ),



          Container(
            decoration: BoxDecoration(
                color: bg_deep,
                borderRadius: BorderRadius.circular(10)
              ),
            padding: EdgeInsets.all(15),
          
            child: TextFormField(
              controller: textController,
              maxLines: 10,
              minLines: 5,
              //expands: true,
              style: const TextStyle(
                fontSize: 20
              ),     
              decoration: InputDecoration.collapsed(
                hintText: hintT,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                )
                ),
            ),
          ),
        ],
      ),
    );
  }
}



