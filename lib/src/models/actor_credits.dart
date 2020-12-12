class ActorCredits {
  List<PeliculaAparece> peliculas = new List<PeliculaAparece>();

  ActorCredits.fromJsonList(List<dynamic> jsonList) {
    if(jsonList == null)
      return;
    
    jsonList.forEach((item) {
      final PeliculaAparece peliculaAparece = PeliculaAparece.fromJsonMap(item);
      peliculas.add(peliculaAparece);
    });
  }
}

class PeliculaAparece {
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  double popularity;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  PeliculaAparece({
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.popularity,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  PeliculaAparece.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    voteCount = json['vote_count'];
    json['vote_average'] != null ? voteAverage = json['vote_average'] / 1 : voteAverage = json['vote_average'];
    title = json['title'];
    releaseDate = json['release_date'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    json['popularity'] != null ? popularity = json['popularity'] / 1 : popularity = json['popularity'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  getPosterImage() {
    if (posterPath == null)
      return 'https://748073e22e8db794416a-cc51ef6b37841580002827d4d94d19b6.ssl.cf3.rackcdn.com/not-found.png';
    else
      return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}