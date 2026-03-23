import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/views/movie_details/movie_details_view.dart';

class DiscoverMoviesWidget extends StatelessWidget {
  final Future<List<MovieModel>> data;
  const DiscoverMoviesWidget({super.key, required this.data});

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
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final movie = snapshot.data![index];
            return GestureDetector(
              onTap: () => Get.to(() => MovieDetailsView(movie: movie)),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        height: screen.getHeight() * 0.5,
                        color: Colors.black,
                        child: networkImage(
                            '${AppConstants.imagePath}${movie.imageUrl}'),
                      ),
                    ),
                  ),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
