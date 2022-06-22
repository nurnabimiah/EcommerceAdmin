
import 'package:flutter/material.dart';
class CustomProgressDialog extends StatelessWidget {
  final String title;
  const CustomProgressDialog({Key? key,required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          CircularProgressIndicator()
        ],

      ),


    );


  }
}
