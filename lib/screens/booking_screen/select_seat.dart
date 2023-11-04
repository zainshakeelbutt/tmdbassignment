import 'package:get/get.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:tmdbassignment/screens/booking_screen/payment_screen.dart';
import 'package:tmdbassignment/widgets/hall_widget.dart';

class SelectSeat extends StatefulWidget {
  final String title;
  final String releaseDate;
  const SelectSeat({Key? key, required this.title, required this.releaseDate}) : super(key: key);

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  int days = 5;
  int selectedDay = 5;
  int selectedDateIndex = 0;
  int selectedSeatIndex = 0;
  bool selectedSeat = false;

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
                  'In Theaters ${widget.releaseDate}'.text.color(blueLight).size(12).fontWeight(FontWeight.w500).make(),
                ],
              ),
              const Spacer(),
            ],
          ).onTap(() {
            Get.back();
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Date',
                style: TextStyle(
                  color: textDark,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(8, (index){
                    return '${days+index} Mar'.text.color(selectedDateIndex == index ? white : textDark).size(12).fontWeight(FontWeight.w600).make().box.color(selectedDateIndex == index ? blueLight : grayLight).padding(const EdgeInsets.symmetric(horizontal: 16, vertical: 6)).margin(const EdgeInsets.only(right: 12)).roundedSM.make().onTap(() {
                      setState(() {
                        selectedDateIndex = index;
                        // days = days+index;
                      });
                    });
                  }),
                ),
              ),
              20.heightBox,
              SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(2, (index){
                  return hallWidget( index == 0 ? '12.30' : '13.30', index == 0 ? 'Cinetech + hall 1' : 'Cinetech + hall 2', index == 0 ? '50' : '75', index == 0 ? '2500' : '300', selectedSeatIndex == index ? blueLight : Colors.transparent).onTap(() {
                    setState(() {
                      selectedSeatIndex = index;
                    });
                  });
                })
              ),
            ),
              const Spacer(),
              Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: blueLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Select Seats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
              ).onTap(() {
                Get.to(()=>PaymentScreen(title: widget.title, selectedDate: 'March ${days+selectedDateIndex}, 2023', selectedHall: selectedSeatIndex == 0 ? '12.30 Hall 1' : '13.30 Hall 2' , amount: selectedSeatIndex == 0 ? '50' : '75'));
              }),

            ],
          ),
        ),
      ),
    );
  }
}
