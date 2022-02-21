import 'package:flutter/material.dart';
class ErrorPage extends StatelessWidget {
  String error;
  VoidCallback onPressed;
  ErrorPage({Key? key,required this.error, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          const SizedBox(height: 55,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: MaterialButton(
                color: Colors.blue,
                elevation: 5,
                minWidth: double.infinity,
                height: 50,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                onPressed: onPressed,
                child: const Text('Попробовать снова')),
          )
        ],
      ),
    );
  }
}
