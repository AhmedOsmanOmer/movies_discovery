import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/connectivity_controller.dart';
import 'package:movie_app/controllers/home_controller.dart';
import 'package:movie_app/controllers/login_controller.dart';
import 'package:movie_app/core/utils/screen_size.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/views/home/widgets/discover_movies_widget.dart';
import 'package:movie_app/views/home/widgets/movies_label_widget.dart';
import 'package:movie_app/views/home/widgets/movies_list_widget.dart';
import 'package:movie_app/views/home/widgets/trend_carousel_widget.dart';
import 'package:movie_app/views/no_internet/no_internet_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    homeController.scrollController.addListener(homeController.scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: Text(
            'Max Movies',
            style: TextStyle(
                fontSize: ScreenSize(context: context).fontSize(30),
                color: Colors.red[900]),
          ),
        ),
        actions: [
          if (pref.getBool('isLoggedIn') ?? false)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: loginController.logout,
            ),
        ],
      ),
      body: GetBuilder<ConnectivityController>(
        builder: (conn) => conn.isOnline
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: GetBuilder<HomeController>(
                  builder: (controller) => ListView(
                    children: [
                      const SizedBox(height: 20),
                      const MoviesLabelWidget(text: 'Trending Now'),
                      TrendCarouselWidget(data: controller.getTrendingMovies()),
                      const SizedBox(height: 25),
                      const MoviesLabelWidget(text: 'Popular'),
                      MoviesListWidget(data: controller.getPopularMovies()),
                      const Divider(thickness: 0.5, color: Colors.grey),
                      const MoviesLabelWidget(text: 'Top Rated'),
                      MoviesListWidget(data: controller.getTopRatedMovies()),
                      const Divider(thickness: 0.5, color: Colors.grey),
                      const MoviesLabelWidget(text: 'Upcoming'),
                      MoviesListWidget(data: controller.getUpcomingMovies()),
                      const Divider(thickness: 0.5, color: Colors.grey),
                      const MoviesLabelWidget(text: 'Discover'),
                      DiscoverMoviesWidget(data: controller.discoverMovies()),
                    ],
                  ),
                ),
              )
            : const NoInternetView(),
      ),
    );
  }
}
