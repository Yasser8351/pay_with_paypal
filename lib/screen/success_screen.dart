import 'package:fib/screen/splash_screen.dart';
import 'package:fib/widgets/fib_button.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.done,
                color: Colors.green,
                size: 50,
              ),
              Text(
                "The bill has been successfully paid",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),

          MyButton(
            width: 200,
            text: "Back To Home",
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SplashScreen())),
          ),
          // Center(
          //   child: ElevatedButton(onPressed: () {

          //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) =>const SplashScreen()));

          //   }, child:const Text("Back To Home")),
          // ),
        ],
      ),
    );
  }
}
