import 'package:animeworld/models/anime_category.dart';
import 'package:animeworld/views/anime_grid_view.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final _animeTabs = animeCategories.map(
    (animeCat) => Tab(text: animeCat.title)
  ).toList();

  final _screens = animeCategories.map(
    (animeCat) => AnimeGridView(category: animeCat)
  ).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anime Categories'),
          bottom: TabBar(
            tabs: _animeTabs, 
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicatorColor: Colors.red,
            labelColor: Colors.red,
          ),
        ),
        body: TabBarView(
          children: _screens,
        ),
      )
    );
  }
}