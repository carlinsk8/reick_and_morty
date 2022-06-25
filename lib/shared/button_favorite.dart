import 'package:flutter/material.dart';

class ButtonFavorite extends StatefulWidget {
  final bool status;
  final void Function()? onPressed;

  const ButtonFavorite({Key? key, required this.status, this.onPressed})
      : super(key: key);

  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  late bool status;
  @override
  void initState() {
    status = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          status = !widget.status;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      icon: CircleAvatar(
        backgroundColor: const Color(0xffF0F0F0),
        child: Icon(
          Icons.star,
          color:
              widget.status ? const Color(0xffEEBA00) : const Color(0xffB9B9B9),
        ),
      ),
    );
  }
}
