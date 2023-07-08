import 'package:aplicacion_peliculas/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/get_actors_model.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int id;
  const CastingCards({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
      future: moviesProvider.getActorsMovie(id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
              strokeWidth: 5,
            ),
          );
        }
        final List<Cast> cast = snapshot.data;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, int index) => _CastCard(actor: cast[index])),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({required this.actor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showDialog(
          context: context,
          builder: (context) => CardActorInfo(actor: actor),
        )
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(actor.addPosterPath),
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                actor.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
