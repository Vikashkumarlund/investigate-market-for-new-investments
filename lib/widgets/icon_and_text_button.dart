import 'package:flutter/material.dart';

class IconAndTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Function()? onPressed;
  const IconAndTextButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
      label: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {},
    );
  }
}
