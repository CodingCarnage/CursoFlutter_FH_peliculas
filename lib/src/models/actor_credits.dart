class ActorCredits {
  List<PeliculaAparece> items = new List<PeliculaAparece>();
  ActorCredits.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null)
      return;
    for (var item in jsonList) {
      final PeliculaAparece peliculaAparece = new PeliculaAparece.fromJsonMap(item);
      items.add(peliculaAparece);
    }
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
    voteCount = json['voteCount'];
    voteAverage = json['voteAverage'] / 1;
    title = json['title'];
    releaseDate = json['releaseDate'];
    originalLanguage = json['originalLanguage'];
    originalTitle = json['originalTitle'];
    genreIds = json['genreIds'].cast<int>();
    backdropPath = json['backdropPath'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['posterPath'];
    popularity = json['popularity'] / 1;
    character = json['character'];
    creditId = json['creditId'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }
}