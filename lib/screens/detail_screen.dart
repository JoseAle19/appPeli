import 'package:aplicacion_peliculas/models/models.dart';
import 'package:aplicacion_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailScreenScreen extends StatelessWidget {
  const DetailScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var movie = ModalRoute.of(context)?.settings.arguments as Map;
    Result movieIndex = movie["movie"];
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            _CustomAppBar(movie: movieIndex),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _PosterAndTitle(movie: movieIndex),
                  _OverView(movie: movieIndex),
                  CastingCards(id: movieIndex.id),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({required this.movie});
  final Result movie;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.indigo,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.all(0),
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            color: const Color.fromARGB(78, 0, 0, 0),
            child: Text(movie.title,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center),
          ),
          background: FadeInImage(
            placeholder: const AssetImage("assets/no-image.jpg"),
            image: NetworkImage(movie.addbackdropPath),
            fit: BoxFit.cover,
          ),
        ));
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({required this.movie});
  final Result movie;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage("assets/no-image.jpg"),
              image: NetworkImage(movie.addPosterPath),
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outlined,
                        size: 15, color: Color.fromARGB(255, 255, 235, 57)),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({Key? key, required this.movie}) : super(key: key);
  final Result movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
