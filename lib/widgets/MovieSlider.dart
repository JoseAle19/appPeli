// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key,
      required this.movies,
      this.categoryMovie,
      required this.onNextPage});
  final movies;
  final categoryMovie;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.categoryMovie ?? 'Sin categoria')),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (BuildContext context, int index) =>
                    _MoviePoster(index: index, movies: widget.movies),
              ),
            ),
          ],
        ));
  }
}

// ignore: unused_element
class _MoviePoster extends StatelessWidget {
  const _MoviePoster({Key? key, required this.index, required this.movies})
      : super(key: key);
  final int index;
  final movies;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "detailscreen",
                  arguments: {"movie": movies[index]});
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(movies[index].addPosterPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movies[index].title ?? 'Sin titulo',
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
