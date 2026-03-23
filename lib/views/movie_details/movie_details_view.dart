import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailsView extends StatelessWidget {
  final MovieModel movie;
  const MovieDetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context: context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                    networkImage('${AppConstants.imagePath}${movie.imageUrl}'),
              ),
              const SizedBox(height: 15),
              Text(
                movie.title,
                style: TextStyle(
                    fontSize: screen.fontSize(35), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statCard(
                    context,
                    label: 'Popularity',
                    value: movie.popularity.toString(),
                  ),
                  _statCard(
                    context,
                    label: 'Vote Count',
                    value: movie.voteCount.toString(),
                  ),
                  _statCard(
                    context,
                    icon: Icon(Icons.star, color: Colors.yellow[900]),
                    value: '${movie.voteAverage}',
                  ),
                ],
              ),
              SizedBox(height: screen.getHeight() * 0.02),
              const Divider(
                  color: Colors.grey, thickness: 1, indent: 3, endIndent: 3),
              SizedBox(height: screen.getHeight() * 0.02),
              Text('Release Date',
                  style: TextStyle(
                      fontSize: screen.fontSize(30),
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(movie.releaseDate,
                  style: TextStyle(fontSize: screen.fontSize(23))),
              const SizedBox(height: 10),
              const Divider(
                  color: Colors.grey, thickness: 1, indent: 50, endIndent: 50),
              Text('Description',
                  style: TextStyle(
                      fontSize: screen.fontSize(30),
                      fontWeight: FontWeight.bold)),
              SizedBox(height: screen.getHeight() * 0.01),
              Text(movie.overview,
                  style: TextStyle(fontSize: screen.fontSize(23))),
              SizedBox(height: screen.getHeight() * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(BuildContext context,
      {String? label, required String value, Icon? icon}) {
    final screen = ScreenSize(context: context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screen.getHeight() * 0.01,
        horizontal: screen.getWidth() * 0.04,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          if (icon != null) icon,
          if (label != null)
            Text(label, style: const TextStyle(color: Colors.black)),
          SizedBox(height: screen.getHeight() * 0.01),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
