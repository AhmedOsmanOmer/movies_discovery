import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/core/widgets/app_widgets.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/views/movie_details/movie_details_view.dart';

class TrendCarouselWidget extends StatelessWidget {
  final Future<List<MovieModel>> data;
  const TrendCarouselWidget({super.key, required this.data});

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
        return CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
            height: screen.getHeight() * 0.3,
            autoPlay: true,
            viewportFraction: 0.85,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 3),
          ),
          itemBuilder: (context, index, _) {
            final movie = snapshot.data![index];
            return GestureDetector(
              onTap: () => Get.to(() => MovieDetailsView(movie: movie)),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Container(
                        width: screen.getWidth(),
                        color: Colors.black,
                        child: networkImage(
                            '${AppConstants.imagePath}${movie.imageUrl}'),
                      ),
                    ),
                  ),
                  SizedBox(height: screen.getHeight() * 0.01),
                  Text(
                    movie.title,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
