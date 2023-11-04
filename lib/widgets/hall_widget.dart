import 'package:tmdbassignment/consts/consts.dart';

Widget hallWidget(String time, String hallName, String amount, String bonus, color){

  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          time.text.color(textDark).size(12).fontWeight(FontWeight.w500).make(),
          10.widthBox,
          hallName.text.color(grayDark).size(12).fontWeight(FontWeight.w400).make(),
        ],
      ),
      12.heightBox,
      Image.asset(seats_img,width: 145,).box.padding(const EdgeInsets.symmetric(horizontal: 60,vertical: 30)).border(color: color).rounded.make(),
      12.heightBox,
      RichText(text: TextSpan(
        children: [
          const TextSpan(
            text: 'From ',
            style: TextStyle(color: grayDark, fontSize: 12, fontWeight: FontWeight.w500)
          ),
          TextSpan(
              text: '$amount\$ ',
              style: TextStyle(color: textDark, fontSize: 12, fontWeight: FontWeight.w600)
          ),
          const TextSpan(
              text: 'or ',
              style: TextStyle(color: grayDark, fontSize: 12, fontWeight: FontWeight.w500)
          ),
          TextSpan(
              text: '$bonus Bonus ',
              style: TextStyle(color: textDark, fontSize: 12, fontWeight: FontWeight.w600)
          ),
        ]
      ))
    ],
  ).box.margin(const EdgeInsets.only(right: 10)).make();
}