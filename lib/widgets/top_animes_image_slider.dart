
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/constant/app_colors.dart';
import 'package:animeworld/models/anime.dart';

class TopAnimesImageSlider extends StatefulWidget {
  const TopAnimesImageSlider({
    super.key, required this.animes
  });

  final Iterable<Anime> animes;

  @override
  State<TopAnimesImageSlider> createState() => _TopAnimesImageSliderState();
}

class _TopAnimesImageSliderState extends State<TopAnimesImageSlider> {

  @override
  Widget build(BuildContext context) {
    int _currentPageIndex = 0;
    final CarouselController _controller = CarouselController();
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.animes.length,
            itemBuilder: (context, index, realIndex) {
              final anime = widget.animes.elementAt(index);
              return TopAnimePicture(anime: anime);
            },
            options: CarouselOptions(
              enlargeFactor: 0.22,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              aspectRatio: 16/9,
              viewportFraction: 0.88,
              autoPlay: true,
              enlargeCenterPage: true,
              initialPage: _currentPageIndex
            ),
          )
        ],
      ),
    );
  }
}

