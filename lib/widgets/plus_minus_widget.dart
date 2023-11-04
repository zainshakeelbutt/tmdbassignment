import 'package:tmdbassignment/consts/consts.dart';

Widget plusMinusWidget(){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.8799999952316284),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.91, color: Color(0xFFEFEFEF)),
              borderRadius: BorderRadius.circular(18.21),
            ),
          ),
          child: Center(
            child: '+'.text.color(textDark).fontWeight(FontWeight.w500).size(28).make(),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.8799999952316284),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.91, color: Color(0xFFEFEFEF)),
              borderRadius: BorderRadius.circular(18.21),
            ),
          ),
          child: Center(
            child: '-'.text.color(textDark).fontWeight(FontWeight.w500).size(28).make(),
          ),
        ),
      ],
    ),
  );
}