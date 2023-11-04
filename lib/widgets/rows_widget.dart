import 'package:tmdbassignment/consts/consts.dart';

Widget rowsWidget(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 21),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '4 ',
                style: TextStyle(
                  color: Color(0xFF202C43),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.20,
                ),
              ),
              TextSpan(
                text: '/',
                style: TextStyle(
                  color: Color(0xFF202C43),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.20,
                ),
              ),
            ],
          ),
        ),
        const Text(
          '3 row',
          style: TextStyle(
            color: Color(0xFF202C43),
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.20,
          ),
        ),
        13.widthBox,
        const Icon(Icons.close, size: 18,)
      ],
    ),
  );
}