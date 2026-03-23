class MovieModel {
  final String title;
  final String imageUrl;
  final String overview;
  final String releaseDate;
  final bool adult;
  final int voteCount;
  final double voteAverage;
  final double popularity;
  final String backImage;

  const MovieModel({
    required this.title,
    required this.imageUrl,
    required this.overview,
    required this.releaseDate,
    required this.adult,
    required this.voteCount,
    required this.voteAverage,
    required this.popularity,
    required this.backImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['original_title'] ?? json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
      adult: json['adult'] ?? false,
      voteCount: json['vote_count'] ?? 0,
      imageUrl: json['poster_path'] ?? '',
      backImage: json['backdrop_path'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
    );
  }
}
