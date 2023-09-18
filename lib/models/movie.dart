class Movie {
  final String title;
  final int year;
  final String image;
  final double rating; 

  Movie({required this.title, required this.year, required this.image, required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['originalTitleText']['text'] as String,
      year: json['releaseYear']['year'] as int,
      image: json['primaryImage'] != null
          ? json['primaryImage']['url'] as String
          : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=', // Handle the case where 'primaryImage' is null
      rating: (json['ratingsSummary'] != null && json['ratingsSummary']['aggregateRating'] != null)
        ? json['ratingsSummary']['aggregateRating'].toDouble()
        : 0.0, // Provide a default value of 0.0 when rating is null
    );
  }

  static List<Movie> moviesFromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) {
      return Movie.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Movie {title $title, year $year, image $image}';
  }
}