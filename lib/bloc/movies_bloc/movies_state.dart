part of 'movies_bloc.dart';

@immutable
abstract class MoviesState extends Equatable {
  const MoviesState();
  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final TMDBModel tmdbModel;
  final GenreModel genres;
  const MoviesLoadedState(this.tmdbModel, this.genres,);
  @override
  List<Object?> get props => [tmdbModel,genres,];
}

class MoviesErrorState extends MoviesState {
  final String errorMessage;
  final TMDBModel tmdbModel;
  final GenreModel genres;
  const MoviesErrorState(this.errorMessage, this.tmdbModel, this.genres);
  @override
  List<Object?> get props => [tmdbModel,genres,errorMessage];

}