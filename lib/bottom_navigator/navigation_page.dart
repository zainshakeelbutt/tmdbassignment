import 'package:tmdbassignment/screens/watch_screen/watch_screen.dart';

import '../consts/consts.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int myCurrentIndex = 1;

  @override
  Widget build(BuildContext context) {
    List pages = [
      Container(color: whiteColor,child: Center(child: 'Dashboard'.text.make(),),),
      const WatchScreen(),
      Container(color: whiteColor,child: Center(child: 'Media'.text.make(),),),
      Container(color: whiteColor,child: Center(child: 'More'.text.make(),),),
    ];
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: dark,
            highlightColor: dark,
            colorScheme: const ColorScheme.light(primary:dark),
            splashFactory: NoSplash.splashFactory,
          // primaryColor: Colors.red,
          textTheme: Theme.of(context).textTheme
            .copyWith(bodySmall: const TextStyle(color: Colors.white) )
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: dark,
              primaryColor: dark,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(27)),
            child: SizedBox(
              height: 75,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: dark,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30), topLeft: Radius.circular(30)),

                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BottomNavigationBar(
                    elevation: 0,
                    useLegacyColorScheme: false,
                    type: BottomNavigationBarType.fixed,
                      backgroundColor: dark,
                      selectedItemColor: white,
                      unselectedItemColor: grayDark,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      unselectedFontSize: 10,
                      selectedFontSize: 10,
                      selectedLabelStyle: const TextStyle(height: 2, fontWeight: FontWeight.w700),
                      selectedIconTheme: const IconThemeData(
                        color: white,
                      ),
                      currentIndex: myCurrentIndex,
                      onTap: (index){
                        setState(() {
                          myCurrentIndex = index;
                        });
                      },
                      items: [
                      BottomNavigationBarItem(icon: Image.asset(dashboarrd_ic, width: 16,), label: 'Dashboard'),
                      BottomNavigationBarItem(icon: Image.asset(watch_ic, width: 18,), label: 'Watch'),
                      BottomNavigationBarItem(icon: Image.asset(media_ic, width: 18,), label: 'Media Library'),
                      BottomNavigationBarItem(icon: Image.asset(more_ic, width: 24,), label: 'More'),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
