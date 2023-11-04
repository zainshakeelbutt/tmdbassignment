
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tmdbassignment/database/db_helper.dart';
import 'package:tmdbassignment/models/DbModel.dart';
import 'package:tmdbassignment/models/GenreModel.dart';
import '../models/TMDBModel.dart';


class MoviesRepo{

    Future<TMDBModel> getMoviesApi() async {
    String url= "https://api.themoviedb.org/3/movie/upcoming?api_key=e73b4e8154a31942aa463b07eaf9f23f";
      final response = await Dio().get(url);
      var data  = TMDBModel.fromJson(response.data);
      // print(response.data);
      if(response.statusCode == 200){
        return data;
      }
      return data;

  }

  Future<GenreModel> getMoviesGenreApi() async {
    String url= "https://api.themoviedb.org/3/genre/movie/list?api_key=e73b4e8154a31942aa463b07eaf9f23f";

      final response = await Dio().get(url);
      var data  = GenreModel.fromJson(response.data);
      if(response.statusCode == 200){
        return data;
      }
      return data;
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

}