import 'dart:async';
import 'package:flutter_bloc_pattern/src/models/movie_response.dart';
import 'package:flutter_bloc_pattern/src/models/task_model.dart';
import 'package:flutter_bloc_pattern/src/resources/movie_repository.dart';
import 'bloc.dart';

class MovieBloc implements Bloc {
  final _repository = MovieRepository();
  MovieResponse _movieData;
  static final MovieBloc instance = MovieBloc._instance();

  MovieBloc._instance();

  final _movieController = StreamController<MovieResponse>();

  void fetchAllMovies() async {
    _movieData = await _repository.movieResponse;
    _movieController.sink.add(_movieData);
  }

  Stream<MovieResponse> get movieFetcher => _movieController.stream;

  @override
  void dispose() {
    _movieController.close();
  }
}
