import 'package:animeworld/common/styles/padding.dart';
import 'package:animeworld/views/featured_anime.dart';
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // feature anime
            SizedBox(
              height: 300,
              child: TopAnimeList(),
            ),

            // top animes
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Ranked',
                      rankingType: 'all',
                    ),
                  )
                ]
              ),
            )
              
          ],
        ),
      ),
    );
  }
}