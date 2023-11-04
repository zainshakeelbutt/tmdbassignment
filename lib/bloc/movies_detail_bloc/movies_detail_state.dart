part of 'movies_detail_bloc.dart';

@immutable
abstract class MoviesDetailState extends Equatable{
  const MoviesDetailState();
  @override
  List<Object?> get props => [];
}

class MoviesDetailInitial extends MoviesDetailState {}

class MoviesDetailLoading extends MoviesDetailState {}


class MoviesDetailLoaded extends MoviesDetailState {
  final MovieDetailModel movieDetailModel;
  final VideosModel videosModel;
  const MoviesDetailLoaded(this.movieDetailModel, this.videosModel);

  @override
  List<Object?> get props => [movieDetailModel, videosModel];
}


class MoviesDetailError extends MoviesDetailState {
  final String errorMessage;
  const MoviesDetailError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
