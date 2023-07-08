import 'package:aplicacion_peliculas/models/get_actors_model.dart';
import 'package:flutter/material.dart';

class CardActorInfo extends StatelessWidget {
  final Cast actor;
  const CardActorInfo({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(202, 190, 188, 188),
      title: Text(
        'Informacion del actor ${actor.name}',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        // color: Colors.transparent,
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          color: Colors.blue,
                          height: 150,
                          width: 150,
                          child: Image.network(
                            actor.addPosterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
