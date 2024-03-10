import 'package:animeworld/common/styles/padding.dart';
import 'package:animeworld/views/featured_animes.dart';
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

            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  // top animes
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Ranked',
                      rankingType: 'all',
                    ),
                  ),

                  // Top popular
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Polular',
                      rankingType: 'bypopularity',
                    ),
                  ),

                  // Top movie
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Movie',
                      rankingType: 'movie',
                    ),
                  ),

                  // Top Up Coming
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Up Coming',
                      rankingType: 'upcoming',
                    ),
                  ),

                  // Top Favorite
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: 'Top Favorite',
                      rankingType: 'favorite',
                    ),
                  ),
                ]
              ),
            )
              
          ],
        ),
      ),
    );
  }
}