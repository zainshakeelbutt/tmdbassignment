const String cacheDbTable = 'cache_data';

class DbFields{
  static final List<String> values = [
    id, movie_id, original_title, overview, poster_path, release_date, genre_names
  ];
  static const String id = '_id';
  static const String movie_id = 'movie_id';
  static const String original_title = 'original_title';
  static const String overview = 'overview';
  static const String poster_path = 'poster_path';
  static const String release_date = 'release_date';
  static const String genre_names = 'genre_names';
}

class DbModel{

  final int? id;
  final String movie_id;
  final String original_title;
  final String overview;
  final String poster_path;
  final String release_date;
  final String genre_names;

  const DbModel({
    this.id,
    required this.movie_id,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.genre_names,
  });

  static DbModel fromJson(Map<String, Object?> json) => DbModel(
    id:  json[DbFields.id] as int?,
    movie_id:  json[DbFields.movie_id] as String,
    original_title:  json[DbFields.original_title] as String,
    overview:  json[DbFields.overview] as String,
    poster_path:  json[DbFields.poster_path] as String,
    release_date:  json[DbFields.release_date] as String,
    genre_names:  json[DbFields.genre_names] as String,

  );
  Map<String, Object?> toJson() => {
    DbFields.id: id,
    DbFields.movie_id: movie_id,
    DbFields.original_title: original_title,
    DbFields.overview: overview,
    DbFields.poster_path: poster_path,
    DbFields.release_date: release_date,
    DbFields.genre_names: genre_names,
  };

  DbModel copy({
    int? id,
    String? movie_id,
    String? original_title,
    String? overview,
    String? poster_path,
    String? release_date,
    String? genre_names,


  }) => DbModel(
    id: id ?? this.id,
    movie_id: movie_id ?? this.movie_id,
    original_title: original_title ?? this.original_title,
    overview: overview ?? this.overview,
    poster_path: poster_path ?? this.poster_path,
    release_date: release_date ?? this.release_date,
    genre_names: genre_names ?? this.genre_names,
  );



}
