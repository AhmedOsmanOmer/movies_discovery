import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/views/movie_details/movie_details_view.dart';

class MoviesListWidget extends StatelessWidget {
  final Future<List<MovieModel>> data;
  const MoviesListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context: context);
    return FutureBuilder<List<MovieModel>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasError) return internetError();
        if (!snapshot.hasData) {
          return Container(
              color: Colors.black, height: screen.getHeight() * 0.3);
        }
        return SizedBox(
          height: screen.getHeight() * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () => Get.to(() => MovieDetailsView(movie: movie)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          width: screen.getWidth() * 0.4,
                          height: screen.getHeight() * 0.26,
                          color: Colors.black,
                          child: networkImage(
                              '${AppConstants.imagePath}${movie.imageUrl}'),
                        ),
                      ),
                      SizedBox(height: screen.getHeight() * 0.01),
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
