part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent  extends Equatable{
  const MoviesEvent();
  @override
  List<Object> get props => [];
}

class MoviesLoadedEvent extends Equatable{
  @override
  List<Object?> get props => [];

}