import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:tmdbassignment/database/db_helper.dart';
import 'package:tmdbassignment/models/DbModel.dart';
import 'package:tmdbassignment/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:tmdbassignment/screens/movie_detail_screen/movie_offline_detail_screen.dart';
import 'package:tmdbassignment/screens/search_screen/search_screen.dart';
import '../../bloc/movies_bloc/movies_bloc.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  String networkStatus = 'Not Connected';
  void checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile){
        networkStatus = 'Mobile Data';
        // print(networkStatus);
      } else if(event == ConnectivityResult.wifi){
        networkStatus = 'Wifi';
        // print(networkStatus);
      } else{
        networkStatus = 'Not Connected';
        // print(networkStatus);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    checkConnectivity();
    CacheDatabaseHelper.instance.database;
    context.read<MoviesBloc>().add(MoviesLoadedEvent());
    super.initState();
  }

  clearData() async {
    await CacheDatabaseHelper.instance.deleteAllData();
  }

  saveData(movie_id,original_title,overview,poster_path,release_date,genre_names) async {
    // await CacheDatabaseHelper.instance.deleteAllData();
    try{
      DbModel dbModel = DbModel(movie_id: movie_id, original_title: original_title, overview: overview, poster_path: poster_path, release_date: release_date, genre_names: genre_names);
      await CacheDatabaseHelper.instance.addData(dbModel);
    } catch(e){
      print('Data is Unique');
    }

  }

  List<DbModel> dbDataList = [];

  Future<List<DbModel>> getOfflineData() async {
    try{
      dbDataList = await CacheDatabaseHelper.instance.readAllData();
      if(dbDataList.isEmpty){
        throw Exception('First Time Internet Connectivity Compulsory');
      }else{
        return dbDataList;
      }
    }
    catch(e){
      print(e);
    }
    return dbDataList;

  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Watch'.text.color(textDark).size(16).fontFamily(poppins).make(),
              const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(Icons.search,color: textDark, size: 18)).onTap(() {
                    Get.to(()=>const SearchScreen());
              })
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: networkStatus == 'Not Connected'
            ? FutureBuilder<List<DbModel>>(
            future: getOfflineData(),
            builder: (context, AsyncSnapshot<List<DbModel>> snapshot){
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator.adaptive(),);
              } else if(snapshot.data!.isEmpty){
                return Center(child: 'Connect Internet'.text.make(),);
              } else{
                var dbList = snapshot.data!;
                return ListView.builder(
                    itemCount: dbList.length,
                    itemBuilder: (context, index) {
                      var moviesData = dbList[index];

                      final String genreDbList = moviesData.genre_names.toString().replaceAll('"', '');
                      final split = genreDbList.toString().split(',');
                      final Map<int, String> values = {
                        for (int i = 0; i < split.length; i++)
                          i: split[i]
                      };
                      List genreName = [];

                      for(int i =0 ; i< values.length; i++){
                        genreName.add(values[i]!);
                      }

                      return GestureDetector(
                        onTap: (){
                         Get.to(()=>MovieOfflineDetailScreen(movieId:moviesData.movie_id, image: moviesData.poster_path.toString() ,title: moviesData.original_title.toString(), releaseDate: moviesData.release_date.toString(), overview: moviesData.overview.toString(), generName: genreName));
                        },
                        child: Column(
                          children: [
                            20.heightBox,
                            SizedBox(
                                height: size.width-200,
                                width: size.width,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider('https://image.tmdb.org/t/p/w500${moviesData.poster_path.toString()}'),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 20,
                                        bottom: 20,
                                        child: Container(
                                          child: moviesData.original_title.text.size(18).fontFamily(poppins).textStyle(const TextStyle(fontWeight: FontWeight.w600)).white.make(),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),

                          ],
                        ),
                      );
                    });
              }
            }
        )

        : BlocConsumer<MoviesBloc,MoviesState>(
            builder: (context, state){
              if(state is MoviesLoadingState){
                clearData();
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if(state is MoviesLoadedState){
                return
                ListView.builder(
                    itemCount: state.tmdbModel.results!.length,
                    itemBuilder: (context, index) {
                      var moviesData = state.tmdbModel.results!;
                      var genreData = state.genres.genres!;

                      List genreName = [];
                      for(int i=0 ; i<state.genres.genres!.length; i++ ){
                        for(int j=0; j<moviesData[index].genreIds!.length; j++){
                          if(genreData[i].id == moviesData[index].genreIds![j]){
                            genreName.add(genreData[i].name);
                          }
                        }
                      }
                      final genreString = genreName.join(',');
                      saveData(moviesData[index].id.toString(), moviesData[index].originalTitle.toString(),  moviesData[index].overview.toString(),  moviesData[index].posterPath.toString(),  moviesData[index].releaseDate.toString(),  genreString);
                      return GestureDetector(
                        onTap: (){
                          // Get.to(()=>MovieDetailScreen(movieId: moviesData[index].id.toString(), image: moviesData[index].backdropPath.toString() ,title: moviesData[index].originalTitle.toString(), releaseDate: moviesData[index].releaseDate.toString(), overview: moviesData[index].overview.toString(), generName: genreName));
                          Get.to(()=>MovieDetailScreen(movieId: moviesData[index].id.toString()));
                        },
                        child: Column(
                          children: [
                            20.heightBox,
                            SizedBox(
                                height: size.width-200,
                                width: size.width,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            'https://image.tmdb.org/t/p/w500${moviesData[index].posterPath.toString()}',
                                          ),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 20,
                                        bottom: 20,
                                        child: Container(
                                          child: moviesData[index].originalTitle!.text.size(18).fontFamily(poppins).textStyle(const TextStyle(fontWeight: FontWeight.w600)).white.make(),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),

                          ],
                        ),
                      );
                    });
              }
              // else if(state is MoviesErrorState){
              //   return Center(
              //     child: Text('Please Reload Page'),
              //   );
              // }
              else {
                return const SizedBox();
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
    );
  }
}
