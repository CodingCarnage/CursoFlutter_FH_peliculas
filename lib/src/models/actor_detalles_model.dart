class Detalles {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  String birthday;
  String deathday;
  int gender;
  String homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  Detalles({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  Detalles.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    json['also_known_as'] != null ? alsoKnownAs = json['also_known_as'].cast<String>() : alsoKnownAs = json['also_known_as'];
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    json['popularity'] != null ? popularity = json['popularity'] / 1 : popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  getFoto(){
    if (profilePath == null)
      return 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png';
    else
      return 'https://image.tmdb.org/t/p/w500$profilePath';
  }
}
