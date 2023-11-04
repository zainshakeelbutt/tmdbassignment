import 'package:tmdbassignment/consts/consts.dart';

Widget seatWidget(color, String lable){
  return Row(
    children: [
      SizedBox(
        width: 17.01,
        height: 16.16,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 17.01,
                height: 12.76,
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            Positioned(
              left: 2.55,
              top: 13.61,
              child: Container(
                width: 11.91,
                height: 2.55,
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
          ],
        ),
      ),
      10.widthBox,
      lable.text.size(12).color(grayDark).fontWeight(FontWeight.w500).make()
    ],
  );
}