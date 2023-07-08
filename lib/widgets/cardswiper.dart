// ignore_for_file: prefer_final_fields

import 'package:aplicacion_peliculas/models/getNowPlayingModel.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({Key? key, required this.movies}) : super(key: key);
  final List<Result> movies;

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  PageController _controller = PageController();
  double? _currentpage = 0;
  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _currentpage = _controller.page;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.maxFinite,
      height: size.height * 0.6,
      child: PageView.builder(
        itemCount: widget.movies.length,
        controller: _controller,
        itemBuilder: (_, int index) {
          final rotate = index - _currentpage!;
          return Transform(
            transform: Matrix4.identity()
              ..rotateX(rotate)
              ..rotateY(rotate),
            alignment: Alignment.topLeft,
            child: MovieCard(widget: widget, index: index),
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.widget,
    required this.index,
  }) : super(key: key);

  final index;
  final CardSwiper widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "detailscreen",
          arguments: {"movie": widget.movies[index]}),
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage("assets/no-image.jpg"),
              image: NetworkImage(widget.movies[index].addPosterPath),
            )),
      ),
    );
  }
}
