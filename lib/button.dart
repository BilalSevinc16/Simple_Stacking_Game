import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final VoidCallback function;

  const MyButton({
    Key? key,
    required this.child,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey.shade900,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
