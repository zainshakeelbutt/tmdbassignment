part of 'movies_detail_bloc.dart';

@immutable
abstract class MoviesDetailEvent extends Equatable{
  const MoviesDetailEvent();
  @override
  List<Object> get props => [];
}

class MoviesDetailLoadedEvent extends Equatable{
  final String movieId;
  const MoviesDetailLoadedEvent(this.movieId);
  @override
  List<Object?> get props => [];

}
