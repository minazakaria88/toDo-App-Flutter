import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({
    super.key, required this.onPressed, required this.iconData,
  });
  final Function onPressed;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.green,Colors.blue],
              )
          ),
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}