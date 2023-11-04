import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tmdbassignment/consts/consts.dart';
import '../../bloc/movies_bloc/movies_bloc.dart';
import '../movie_detail_screen/movie_detail_screen.dart';

class SearchResult extends StatefulWidget {
  final String query;
  const SearchResult({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    context.read<MoviesBloc>().add(MoviesLoadedEvent());
    super.initState();
  }
  var genreName = '';
  var genreImage = '';
  int results = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        // toolbarHeight: 132,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios, color: textDark,),
              15.widthBox,
              '$results Results Found'.text.size(16).fontWeight(FontWeight.w500).color(textDark).make()
            ],
          ).onTap(() {
            Get.back();
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Top Results'.text.size(12).fontWeight(FontWeight.w500).fontFamily(poppins).make(),
                Divider(
                  thickness: 1,
                  color: Colors.black.withOpacity(0.10999999940395355),
                ),
                20.heightBox
              ],
            ),
            Expanded(
              child: BlocConsumer<MoviesBloc,MoviesState>(
                  builder: (context, state){
                    if(state is MoviesLoadingState){
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }


                    else if(state is MoviesLoadedState){
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.tmdbModel.results!.length,
                          itemBuilder: (context, index){
                            var moviesData = state.tmdbModel.results!;
                            var genreData = state.genres.genres!;
                            final searchText =  moviesData[index].originalTitle!.toString();

                            // This Loop for getting one Genre of movie and show in this class
                            for(int i=0 ; i<state.genres.genres!.length; i++ ){
                              if(genreData[i].id == moviesData[index].genreIds![0]){
                                genreName = genreData[i].name.toString();
                              }
                            }

                            // This Loop for getting all Genre names of movies and Pass to Detailed Class
                            // List genreNameList = [];
                            // for(int i=0 ; i<state.genres.genres!.length; i++ ){
                            //   for(int j=0; j<moviesData[index].genreIds!.length; j++){
                            //     if(genreData[i].id == moviesData[index].genreIds![j]){
                            //       genreNameList.add(genreData[i].name);
                            //     }
                            //   }
                            // }

                            if(searchText.toLowerCase().contains(widget.query.toLowerCase())){
                              results = results +1;
                              return GestureDetector(
                                  onTap: (){
                                    Get.to(()=>MovieDetailScreen(movieId: moviesData[index].id.toString()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          height: 100,
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage('https://image.tmdb.org/t/p/original${moviesData[index].posterPath.toString()}'),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                        ),
                                        21.widthBox,
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                moviesData[index].originalTitle!,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: textDark,
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                              ),
                                              20.heightBox,
                                              Text(
                                                genreName,
                                                style: const TextStyle(
                                                  color: grayLight,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0.10,
                                                ),
                                              )
                                            ],),
                                        ),
                                        Spacer(),
                                        Icon(Icons.more_horiz_rounded,size: 20, color: blueLight,)
                                      ],
                                    ),
                                  )




                                // Column(
                                //   children: [
                                //
                                //     SizedBox(
                                //         height: size.width-180,
                                //         width: size.width,
                                //         child: Padding(
                                //           padding: const EdgeInsets.only(right: 10),
                                //           child: Container(
                                //             clipBehavior: Clip.antiAlias,
                                //             width: 150,
                                //             height: 190,
                                //             decoration: BoxDecoration(
                                //                 borderRadius: BorderRadius.circular(10),
                                //                 image: DecorationImage(
                                //                     image: NetworkImage('https://image.tmdb.org/t/p/w500${moviesData[index].posterPath.toString()}'),
                                //                     fit: BoxFit.cover
                                //                 )
                                //             ),
                                //             child: Stack(
                                //               children: [
                                //                 Positioned(
                                //                   left: 20,
                                //                   bottom: 20,
                                //                   child: Container(
                                //                     child: moviesData[index].originalTitle!.text.size(18).fontFamily(poppins).textStyle(const TextStyle(height: 0.07, fontWeight: FontWeight.w500)).white.make(),
                                //                   ),
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //         )
                                //     ),
                                //
                                //   ],
                                // ),
                              );

                            }
                            else{
                              return Container();
                            }
                          });

                    }

                    else if(state is MoviesErrorState){
                      return Center(
                        child: Text(state.errorMessage),
                      );
                    }
                    else {
                      return Container();
                    }

                  },
                  listener: (context, state){
                    if(state is MoviesLoadedState){
                      VxToast.show(context, msg: 'Data Loaded');
                    }
                    else if(state is MoviesErrorState){
                      VxToast.show(context, msg: 'Something went wrong');
                    }
                  }),
            )
          ],
        ),
      ),

    );
  }
}
