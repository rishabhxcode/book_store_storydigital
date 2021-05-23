import 'package:flutter/material.dart';

class DefaultAppButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const DefaultAppButton(
      {Key? key, required this.onPressed, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            onPressed == null ? Colors.amber.withOpacity(0.4) : Colors.amber),
      ),
    );
  }
}
