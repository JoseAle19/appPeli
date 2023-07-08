import 'package:aplicacion_peliculas/providers/movies_provider.dart';
import 'package:aplicacion_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenScreen extends StatelessWidget {
  const HomeScreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      drawer: Drawer(
          child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountEmail: Text("Dragon Ball Z"),
              accountName: Icon(Icons.yard_outlined, size: 60),
            ),
          ],
        ),
      )),
      appBar: AppBar(
        title: const Text("Peliculas en cines"),
        centerTitle: true,
        elevation: 0.0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: moviesProvider.onDisplayMovies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.indigo,
              strokeWidth: 5,
            ))
          : SingleChildScrollView(
              child: Column(
              children: [
                CardSwiper(movies: moviesProvider.onDisplayMovies),
                MovieSlider(
                    categoryMovie: 'Populares',
                    movies: moviesProvider.popularMovies,
                    onNextPage: () {
                      moviesProvider.getPopularMovies();
                    }),
                // moviesProvider.getPopularMovies()),
                MovieSlider(
                  categoryMovie: 'Los más valorados',
                  movies: moviesProvider.topRatedMovies,
                  onNextPage: () {
                    moviesProvider.getTopRatedMovies();
                  },
                ),
              ],
            )),
    );
  }
}
