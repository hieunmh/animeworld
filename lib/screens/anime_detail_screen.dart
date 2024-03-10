import 'package:animeworld/api/get_anime_details.dart';
import 'package:animeworld/common/widgets/ios_back_button.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeDetailScreen extends StatelessWidget {
  const AnimeDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeDetailsApi(id: id), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final anime = snapshot.data;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top anime
                  _buildAnimeImageWidget(imageUrl: anime!.mainPicture.large),

                  // Anime title
                ],
              ),
            ),
          );
        }

        return ErrorScreen(error: snapshot.error.toString());
      }
    );
  }

  _buildAnimeImageWidget({required String imageUrl}) => Stack(
    children: [
      CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: 400,
        width: double.infinity,
      ),
      Positioned(
        top: 30,
        left: 20,
        child: Builder(builder: (context) {
          return IosBackButton(
            onPressed: Navigator.of(context).pop
          );
        }),
      )
    ],
  );
}