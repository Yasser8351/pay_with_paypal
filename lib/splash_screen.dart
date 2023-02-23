import 'package:fib/fcb_button.dart';
import 'package:fib/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {


  const SplashScreen(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children:[
       const Text("Amount 1000 SDG"),
       const SizedBox(height: 50),
       MyButton(text: "Pay",width: 150,onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomeScreen(),)))
        ],),
      ),

          
    );
  }
}


