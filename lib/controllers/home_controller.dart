import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/models/movie_model.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(
        '${AppConstants.trendingMoviesUrl}?api_key=${AppConstants.apiKey}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Exception('Failed to load trending movies');
  }

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(Uri.parse(
        '${AppConstants.popularMoviesUrl}?api_key=${AppConstants.apiKey}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Exception('Failed to load popular movies');
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(
        '${AppConstants.upcomingMoviesUrl}?api_key=${AppConstants.apiKey}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Exception('Failed to load upcoming movies');
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(
        '${AppConstants.topRatedMoviesUrl}?api_key=${AppConstants.apiKey}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Exception('Failed to load top rated movies');
  }

  Future<List<MovieModel>> discoverMovies() async {
    final response = await http.get(Uri.parse(
        '${AppConstants.discoverMoviesUrl}?api_key=${AppConstants.apiKey}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      return data.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Exception('Failed to discover movies');
  }

  void scrollListener() {
    if (scrollController.offset <= scrollController.position.minScrollExtent) {
      update();
    }
  }
}
