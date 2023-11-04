import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tmdbassignment/bloc/movies_detail_bloc/movies_detail_bloc.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tmdbassignment/screens/booking_screen/select_seat.dart';
import 'package:tmdbassignment/screens/movie_detail_screen/video_screen.dart';

class MovieOfflineDetailScreen extends StatefulWidget {
  final String movieId;
  final String image;
  final String title;
  final String releaseDate;
  final String overview;
  final List generName;
  const MovieOfflineDetailScreen({Key? key, required this.movieId, required this.title, required this.releaseDate, required this.overview, required this.generName, required this.image}) : super(key: key);
  // const MovieOfflineDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieOfflineDetailScreen> createState() => _MovieOfflineDetailScreenState();
}

class _MovieOfflineDetailScreenState extends State<MovieOfflineDetailScreen> {


  @override
  void initState() {
    context.read<MoviesDetailBloc>().add(MoviesDetailLoadedEvent(widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // var dateRelease = Jiffy.parse(widget.releaseDate).yMMMd;
    var colors = [
      cyan,
      pink,
      indigo,
      golden,
      cyan,
      pink,
      indigo,
      golden,
      cyan,
      pink,
      indigo,
      golden,
    ];
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: AppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
              backgroundColor: whiteColor,
              expandedHeight: 467,
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    width: double.infinity,
                    height: 467,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        // CachedNetworkImage(
                        //   imageUrl: 'https://image.tmdb.org/t/p/original${widget.image}',
                        //   height: double.infinity,
                        //   width: double.infinity,
                        //   fit: BoxFit.cover,
                        //
                        // ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 50),
                          height: double.infinity,
                          width: double.infinity,
                          color: grayDark,
                          child: 'Check Internet Connection'.text.color(Colors.redAccent).size(18).fontWeight(FontWeight.w600).makeCentered(),
                        ),

                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              widget.title.text.size(16).color(golden).fontWeight(FontWeight.w700).make().box.color(Colors.black.withOpacity(0.7)).padding(EdgeInsets.symmetric(vertical: 10, horizontal: 20)).roundedLg.make(),
                              6.heightBox,
                              'In Theaters ${widget.releaseDate}'.text.white.size(16).fontWeight(FontWeight.w700).make(),
                              15.heightBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 66),
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
                                      'Get Tickets',
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
                                  Get.to(()=> SelectSeat(title: widget.title,releaseDate: widget.releaseDate,));
                                }),
                              ),
                              10.heightBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 66),
                                child: Container(
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFF61C3F2)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.play_arrow, color: white,),
                                        8.widthBox,
                                        const Text(
                                          'Watch Trailer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.20,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ).onTap(() {
                                  VxToast.show(context, msg: 'Check Internet Connectivity');
                                 // Get.to(()=> VideosScreen(title: detailData.originalTitle.toString(), videoKey: videoKey!));
                                }),
                              ),

                              34.heightBox,

                            ],
                          ),
                        )

                      ],
                    ),
                  )
              ),
              title: Row(
                children: [
                  const Icon(Icons.arrow_back_ios),
                  15.widthBox,
                  'Watch'.text.make()
                ],
              ).onTap(() {
                Get.back();
              })
          ),
          buildScreen(context, size.height, size.width, widget.overview, widget.generName, colors),
        ],
      ),
    );
  }
}
Widget buildScreen(context, sHeight, sWidth, overView, generNames, multiColoros){
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         10.heightBox,
         const Text(
           'Genres',
           style: TextStyle(
             color: textDark,
             fontSize: 16,
             fontFamily: 'Poppins',
             fontWeight: FontWeight.w600,
           ),
         ),
         10.heightBox,
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           physics: const BouncingScrollPhysics(),
           child: Row(
             children: List.generate(generNames.length, (index){
               return '${generNames[index]}'.text.size(12).white.fontWeight(FontWeight.w600).make().box.color(multiColoros[index]).roundedLg.padding(const EdgeInsets.symmetric(horizontal: 10, vertical: 2)).margin(EdgeInsets.only(right: 5)).make();
             }),
           ),
         ),
         25.heightBox,
         const Text(
           'Overview',
           style: TextStyle(
             color: textDark,
             fontSize: 16,
             fontFamily: 'Poppins',
             fontWeight: FontWeight.w600,
           ),
         ),
         10.heightBox,
         SizedBox(
           width: 295,
           child: Text(
             overView,
             style: const TextStyle(
               color: Color(0xFF8F8F8F),
               fontSize: 12,
               fontFamily: 'Poppins',
               fontWeight: FontWeight.w400,
             ),
           ),
         )
       ],
      ),
    ),
  );
}