import 'package:animeworld/api/get_anime_details.dart';
import 'package:animeworld/common/extensions/extension.dart';
import 'package:animeworld/common/styles/padding.dart';
import 'package:animeworld/common/styles/text_style.dart';
import 'package:animeworld/common/widgets/ios_back_button.dart';
import 'package:animeworld/common/widgets/network_image_view.dart';
import 'package:animeworld/common/widgets/read_more_text.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:animeworld/cubits/anime_title_language_cubit.dart';
import 'package:animeworld/models/anime_details.dart';
import 'package:animeworld/models/picture.dart';
import 'package:animeworld/views/similar_animes.dart';
import 'package:animeworld/widgets/info_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

                  Padding(
                    padding: Paddings.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         _buildAnimeTitle(
                          name: anime.title, 
                          englishName: anime.alternativeTitles.en
                        ),
                        const SizedBox(height: 20),
                        
                        ReadMoreText(longText: anime.synopsis),

                        const SizedBox(height: 10),

                        // anime info
                        _buildAnimeInfo(anime: anime),

                        const SizedBox(height: 20),

                        // anime background
                        anime.background.isNotEmpty ?
                        _buildAnimeBackground(background: anime.background)
                        : const SizedBox.shrink(),

                        const SizedBox(height: 20),

                        // image gallery
                        _buildImageGallery(images: anime.pictures),

                        const SizedBox(height: 20),

                        SimilarAnimesView(
                          animes: anime.relatedAnime.map(
                            (animeRe) => animeRe.node
                          ).toList(),
                          label: 'Related Animes',
                        ),

                        const SizedBox(height: 20),

                        SimilarAnimesView(
                          animes: anime.recommendations.map(
                            (animeRe) => animeRe.node
                          ).toList(),
                          label: 'Recommendations',
                        ),
                        
                      ],
                    ),
                  )
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

  Widget _buildAnimeTitle({
    required String name, required String englishName
  }) => BlocBuilder<AnimeTitleLanguageCubit, bool>(
    builder: (context, state) {
      bool isEnglish  = state;  

      return Text(
        isEnglish ? englishName : name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor
        ),
      );
    }
  );

  Widget _buildAnimeInfo({required AnimeDetails anime}) {
    String studios = anime.studios.map((studio) => studio.name).join(', ');
    String genres = anime.genres.map((genre) => genre.name).join(', ');
    String otherNames =
        anime.alternativeTitles.synonyms.map((title) => title).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(label: 'Genres: ', info: genres),
        InfoText(label: 'Start date: ', info: anime.startDate),
        InfoText(label: 'End date: ', info: anime.endDate),
        InfoText(label: 'Episodes: ', info: anime.numEpisodes.toString()),
        InfoText(
          label: 'Average Episode Duration: ',
          info: anime.averageEpisodeDuration.toMinute(),
        ),
        InfoText(label: 'Status: ', info: anime.status),
        InfoText(label: 'Rating: ', info: anime.rating),
        InfoText(label: 'Studios: ', info: studios),
        InfoText(label: 'Other Names: ', info: otherNames),
        InfoText(label: 'English Name: ', info: anime.alternativeTitles.en),
        InfoText(label: 'Japanese Name: ', info: anime.alternativeTitles.ja),
      ],
    );
  }

  Widget _buildAnimeBackground({required String background}) {
    return WhiteContainer(
      child: Text(
        background,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildImageGallery({required List<Picture> images}) {
    return Column(
      children: [
        const Text(
          'Image Gallery',
          style: TextStyles.mediumText,
        ),
        GridView.builder(
          itemCount: images.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9 /16,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
          ), 
          itemBuilder: (context, index) {
            final image = images[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NetworkImageView(imageUrl: image.large)
                    )
                  );
                },
                child: Image.network(image.medium, fit: BoxFit.cover)
              ),
            );
          }
        )
      ],
    );
  }
  
}

class WhiteContainer extends StatelessWidget {
  const WhiteContainer({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}