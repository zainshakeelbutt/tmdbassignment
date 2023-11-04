import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdbassignment/models/DbModel.dart';
import 'package:tmdbassignment/models/GenreModel.dart';
import '../../models/TMDBModel.dart';
import '../../repositories/movies_repo.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesLoadedEvent, MoviesState> {
  final MoviesRepo moviesRepo;
  MoviesBloc(this.moviesRepo) : super(MoviesLoadingState()) {
    on<MoviesLoadedEvent>((event, emit) async {
      try{
        emit(MoviesLoadingState());
        final data = await moviesRepo.getMoviesApi();
        final genreData = await moviesRepo.getMoviesGenreApi();
        emit(MoviesLoadedState(data,genreData,));
      }catch(e){
        final data = await moviesRepo.getMoviesApi();
        final genreData = await moviesRepo.getMoviesGenreApi();
        emit(MoviesErrorState(e.toString(),data,genreData));
      }
    });
  }
}
