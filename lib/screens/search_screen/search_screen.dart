import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:tmdbassignment/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:tmdbassignment/screens/search_screen/search_result_screen.dart';
import 'package:tmdbassignment/widgets/custom_textfield.dart';

import '../../bloc/movies_bloc/movies_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    context.read<MoviesBloc>().add(MoviesLoadedEvent());
    super.initState();
  }

  var searchController = TextEditingController();
  String search = '';
  var genreName = '';
  var genreImage = '';
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 132,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: ShapeDecoration(
              color: const Color(0xFFF2F2F6),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: customTextField(context, searchController,
                  (){setState(() {
                    searchController.clear();
                    search='';
                  });},
                    (String value){
                    setState(() {
                      search = value.toString();
                    });
                  },
                (value){
                  if(searchController.text.isNotEmptyAndNotNull){
                    Get.to(()=>SearchResult(query: searchController.text,));
                  }
                }
            )

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            if(search!='')
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
                    return searchController.text.isEmptyOrNull
                        ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.4, crossAxisSpacing: 10 ),
                        itemCount: state.genres.genres!.length,
                        itemBuilder: (context,index){
                          var moviesData = state.tmdbModel.results!;
                          var genreData = state.genres.genres!;

                          for(int i=0 ; i<moviesData.length; i++ ){
                            if(genreData[index].id == moviesData[i].genreIds![0]){
                              genreImage = 'https://image.tmdb.org/t/p/original${moviesData[i].posterPath.toString()}';
                            }
                          }

                          return Column(
                            children: [

                              SizedBox(
                                  height: size.width-280,
                                  width: size.width-163,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(genreImage),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 10,
                                          bottom: 20,
                                          child: Container(
                                            child: genreData[index].name!.text.size(18).fontFamily(poppins).textStyle(const TextStyle(height: 0.07, fontWeight: FontWeight.w500)).white.make(),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),

                            ],
                          );
                        }
                    )

                        : ListView.builder(
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

                              //if we pass data from this screen to detail screen then this loop we will use
                              // This Loop for getting all Genre names of movies and Pass to Detailed Class
                              // List genreNameList = [];
                              // for(int i=0 ; i<state.genres.genres!.length; i++ ){
                              //   for(int j=0; j<moviesData[index].genreIds!.length; j++){
                              //     if(genreData[i].id == moviesData[index].genreIds![j]){
                              //       genreNameList.add(genreData[i].name);
                              //     }
                              //   }
                              // }

                                if(searchText.toLowerCase().contains(search.toLowerCase())){
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
                                        const Spacer(),
                                        const Icon(Icons.more_horiz_rounded,size: 20, color: blueLight,)
                                      ],
                                    ),
                                  )
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
        ],),
      )
    );
  }
}
