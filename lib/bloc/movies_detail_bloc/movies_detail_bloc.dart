import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tmdbassignment/models/VideosModel.dart';
import 'package:tmdbassignment/repositories/movies_detail_repo.dart';

import '../../models/MovieDetailModel.dart';

part 'movies_detail_event.dart';
part 'movies_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailLoadedEvent, MoviesDetailState> {
  final MoviesDetailRepo moviesDetailRepo;
  MoviesDetailBloc(this.moviesDetailRepo) : super(MoviesDetailLoading()) {
    on<MoviesDetailLoadedEvent>((event, emit) async {
      try{
        emit(MoviesDetailLoading());
        final data = await moviesDetailRepo.getMoviesDetailApi(event.movieId);
        final videoData = await moviesDetailRepo.getVideosApi(event.movieId);
        emit(MoviesDetailLoaded(data,videoData));

      }catch(e){
        emit(MoviesDetailError(e.toString()));
      }
    });
  }


}
