import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class ShowCard extends StatelessWidget {
  final Show show;

  const ShowCard({required this.show});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(show.imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
