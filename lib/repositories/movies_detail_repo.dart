
import 'package:dio/dio.dart';
import 'package:tmdbassignment/models/VideosModel.dart';

import '../bloc/movies_bloc/movies_bloc.dart';
import '../models/MovieDetailModel.dart';
import '../models/TMDBModel.dart';

class MoviesDetailRepo{

  Future<MovieDetailModel> getMoviesDetailApi(movieId) async {

    try{
      final response = await Dio().get('https://api.themoviedb.org/3/movie/$movieId?api_key=e73b4e8154a31942aa463b07eaf9f23f');
      if(response.statusCode == 200){
        return MovieDetailModel.fromJson(response.data);
      } else{
        throw Exception('Failed to load movies');
      }
    }
    catch(e){
      throw Exception('Failed to load movies');
    }
  }

  Future<VideosModel> getVideosApi(movieId) async {

    try{
      final response = await Dio().get('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=e73b4e8154a31942aa463b07eaf9f23f');
      if(response.statusCode == 200){
        return VideosModel.fromJson(response.data);
      } else{
        throw Exception('Failed to load Videos');
      }
    }
    catch(e){
      throw Exception('Failed to load Videos');
    }
  }

}