import 'package:flutter/material.dart';
import 'package:netflix_ui/data/data.dart';

import '../customWidget/image_card.dart';

final images = [
  'assets/images/iron_man.png',
  'assets/images/avengers.png',
  'assets/images/miss_marvel.png',
  'assets/images/d_strange.png',
  'assets/images/spider_man.png',
  'assets/images/civil_war.png',
  'assets/images/black_panther.png',
  'assets/images/ant_man.png',
];

final names = [
  'Iron Man 3',
  'Avengers',
  'Miss Marvel',
  'Doctor Strange',
  'Spider Man',
  'Civil War',
  'Blank Panther',
  'Ant Man',
];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 24, right: 24, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search Screen',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    _customTextField(),
                    const Text(
                      'Recent Watch',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: PageView.builder(
                    itemCount: images.length,
                    controller: _pageController,
                    onPageChanged: (index) => setState(() {
                          _selectedIndex = index;
                        }),
                    itemBuilder: (context, index) {
                      return ImageCard(
                        contentData: myList[index],
                        isSelected: _selectedIndex == index,
                        onItemTap: (content){
                          print("Item tap :: ${content.name}");
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField() {
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: TextFormField(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          obscureText: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: 'Search here...',
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.grey.withOpacity(0.3),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.only(left: 12.0, top: 20, bottom: 20),
          ),
        ));
  }
}
