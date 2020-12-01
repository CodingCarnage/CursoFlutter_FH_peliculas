class Peliculas {
  List<Pelicula> items = new List<Pelicula>();
  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null)
      return;
    for (var item in jsonList) {
      final Pelicula pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  bool video;
  double voteAverage;
  double popularity;
  int voteCount;
  String releaseDate;
  bool adult;
  String backdropPath;
  int id;
  List<int> genreIds;
  String title;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  String overview;

  Pelicula({
    this.video,
    this.voteAverage,
    this.popularity,
    this.voteCount,
    this.releaseDate,
    this.adult,
    this.backdropPath,
    this.id,
    this.genreIds,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.overview,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    releaseDate = json['release_date'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    overview = json['overview'];
  }

  getPosterImage() {
    if (posterPath == null)
      return 'https://748073e22e8db794416a-cc51ef6b37841580002827d4d94d19b6.ssl.cf3.rackcdn.com/not-found.png';
    else
      return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  getBackdropImage() {
    if (backdropPath == null)
      return 'https://748073e22e8db794416a-cc51ef6b37841580002827d4d94d19b6.ssl.cf3.rackcdn.com/not-found.png';
    else
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}
