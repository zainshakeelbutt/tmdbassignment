import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:tmdbassignment/widgets/seat_widget.dart';

import '../../widgets/plus_minus_widget.dart';
import '../../widgets/rows_widget.dart';

class PaymentScreen extends StatefulWidget {
  final String title;
  final String selectedDate;
  final String selectedHall;
  final String amount;
  const PaymentScreen({Key? key, required this.title, required this.selectedDate, required this.selectedHall, required this.amount}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 132,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back_ios, color: textDark,),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.title.text.color(textDark).size(16).fontWeight(FontWeight.w500).make(),
                  '${widget.selectedDate} | ${widget.selectedHall}'.text.color(blueLight).size(12).fontWeight(FontWeight.w500).make(),
                ],
              ),
              const Spacer(),
            ],
          ).onTap(() {
            Get.back();
          }),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.3, top: 45),
                child: Image.asset(indexes),
              ),
              Expanded(child: Image.asset(seats_img_book))
            ],
          ),
          const Spacer(),
          plusMinusWidget(),
          Opacity(
            opacity: 0.30,
            child: Container(
              width: 334,
              height: 5,
              decoration: ShapeDecoration(
                color: textDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          7.heightBox,
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    seatWidget(golden,'Selected'),
                    15.heightBox,
                    seatWidget(indigo,'VIP (150\$)'),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    seatWidget(grayLight,'Not available'),
                    15.heightBox,
                    seatWidget(blueLight,'Regular (50 \$)'),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const Spacer(),
          rowsWidget(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        color: Color(0xFF202C43),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.20,
                      ),
                    ),
                    Text(
                      '\$ ${widget.amount}',
                      style: TextStyle(
                        color: Color(0xFF202C43),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ],
                ).box.padding(const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 38)).make(),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: ShapeDecoration(
                      color: blueLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Proceed to pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          20.heightBox,
        ],
      ),
    );
  }
}
