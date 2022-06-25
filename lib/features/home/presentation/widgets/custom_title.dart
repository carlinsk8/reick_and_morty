import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final String setTitle;
  const CustomTextButton({
    Key? key,
    required this.title,
    this.onTap,
    required this.setTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
            fontSize: 12,
            fontWeight: setTitle == title ? FontWeight.w900 : null,
            color: Colors.white),
      ),
    );
  }
}
