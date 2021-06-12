import 'package:flutter_bloc_pattern/src/models/movie_response.dart';
import 'package:flutter_bloc_pattern/src/resources/movie_api_provider.dart';

class MovieRepository {
  final movieProvider = MovieApiProvider();
  Future<MovieResponse> get movieResponse => movieProvider.getMovieResponse();
}
