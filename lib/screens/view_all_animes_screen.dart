import 'package:animeworld/api/get_anime_by_ranking_type.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:animeworld/views/ranked_animes_list_view.dart';
import 'package:flutter/material.dart';

class ViewAllAnimesScreen extends StatelessWidget {
  const ViewAllAnimesScreen({
    super.key, 
    required this.rankingType,
    required this.label
  });

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: FutureBuilder(
        future: getAnimeByRankingTypeApi(
          rankingType: rankingType, 
          limit: 500
        ), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          
          if (snapshot.data != null) {
            return RankedAnimesListView(animes: snapshot.data!);
          }
      
          return ErrorScreen(error: snapshot.error.toString());
        }
      ),
    );
  }
}