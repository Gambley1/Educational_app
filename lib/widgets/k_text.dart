import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  const KText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
      textAlign: textAlign,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
