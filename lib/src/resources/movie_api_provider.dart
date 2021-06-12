import 'dart:convert';

import 'package:flutter_bloc_pattern/src/models/movie_response.dart';
import 'package:http/http.dart';

class MovieApiProvider {
  Future<MovieResponse> getMovieResponse() async {
    final response = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=9aeaa4994a27aedb991bf0bea7ee555b&language=en-US&page=1'));
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Network Error');
    }
  }
}
