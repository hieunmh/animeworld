import 'package:animeworld/widgets/top_anime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime world'),
        actions: [IconButton(
          onPressed: () {}, 
          icon: const Icon (CupertinoIcons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: TopAnimeList(),
            )
          ],
        ),
      ),
    );
  }
}