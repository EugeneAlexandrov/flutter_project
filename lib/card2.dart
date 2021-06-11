import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';

import 'circle_image.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  final String smoothies = 'Smoothies';
  final String recipe = 'Recipe';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/mag5.png'), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        constraints: const BoxConstraints.expand(
          height: 450,
          width: 350,
        ),
        child: Column(children: [
          AuthorCard(
            authorName: 'Mike Katz',
            title: 'Smoothie Connoisseur',
            imageProvider: AssetImage('assets/author_katz.jpeg'),
          ),
          Expanded(
            child: Stack(children: [
              Positioned(
                bottom: 70,
                left: 16,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    smoothies,
                    style: FooderlichTheme.lightTextTheme.headline1,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Text(
                  recipe,
                  style: FooderlichTheme.lightTextTheme.headline1,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class AuthorCard extends StatefulWidget {
  const AuthorCard(
      {Key? key,
      this.authorName = '',
      this.title = '',
      this.imageProvider = const AssetImage('assets/mag4.png')})
      : super(key: key);

  final String authorName;
  final String title;
  final ImageProvider imageProvider;

  @override
  _AuthorCardState createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: FooderlichTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  ),
                ],
              )
            ],
          ),
          IconButton(
              icon: Icon(_isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,color:Colors.red,),
              iconSize: 30,
              color: Colors.grey[400],
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                const snackBar = SnackBar(content: Text('Press Favorite'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              })
        ],
      ),
    );
  }
}
