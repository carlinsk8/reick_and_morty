import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final String keyValue;
  final String value;
  const CustomBox({
    Key? key,
    required this.keyValue,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: const Color(0xffB9B9B9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info,
                  color: Color(0xff7A7A7A),
                ),
                Text('$keyValue:')
              ],
            ),
            Text(
              value,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
