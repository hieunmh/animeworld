import 'package:animeworld/api/get_anime_by_ranking_type.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:animeworld/widgets/top_animes_image_slider.dart';
import 'package:flutter/material.dart';

class TopAnimeList extends StatefulWidget {
  const TopAnimeList({super.key});

  @override
  State<TopAnimeList> createState() => _TopAnimeListState();
}

class _TopAnimeListState extends State<TopAnimeList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeByRankingTypeApi(
        rankingType: 'all', 
        limit: 4 
      ), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          return TopAnimesImageSlider(animes: [],);
        }

        return ErrorScreen(error: snapshot.error.toString());
      }
    );
  }
}