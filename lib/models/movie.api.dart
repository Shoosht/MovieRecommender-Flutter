import 'dart:convert';
import 'package:movierecommender/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static Future<List<Movie>> getMovies(String? genre, int? year, String? category ) async {

    final Map<String, String> queryParams = {
      if (genre != null) "genre": genre, 
      "info": 'base_info',
      "sort": 'year.decr',
      if (year != null) "year": year.toString(), 
      if (category != null) "list": category,  
    };

    var uri = Uri.https('moviesdatabase.p.rapidapi.com', '/titles', queryParams);


    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'api_key',
      'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com',
      "useQueryString": "true"
    });

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _temp = data['results'] as List;

      return Movie.moviesFromSnapshot(_temp);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
