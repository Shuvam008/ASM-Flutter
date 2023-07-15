import '../utils/index.dart';

Widget customText(
  String text,
  double fontSize,
  FontWeight fontWeight,
  Color textColor,
) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
    ),
  );
}
