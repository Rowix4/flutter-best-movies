class Movie {
  final int id;
  final String title;
  final List genres;
  final String posterPath;
  final String type;
  final String releaseDate;
  final String overview;
  final String rate;

  Movie({this.id, this.title, this.genres, this.posterPath, this.type, this.releaseDate, this.overview, this.rate});

  factory Movie.fromJson(Map<String, dynamic> json, type) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? json['original_name'],
      genres: json['genres'],
      posterPath: json['poster_path'],
      releaseDate: json['first_air_date'] ?? json['release_date'],
      overview: json['overview'],
      rate: json['vote_average'].toString(),
      type: type
    );
  }
}