import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/cubit/app_bar_cubit.dart';
import 'package:netflix_ui/customWidget/customAppBar.dart';
import 'package:netflix_ui/data/data.dart';
import '../customWidget/contentHeader.dart';
import '../customWidget/contentList.dart';
import '../customWidget/previews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffSet(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOfSet) {
            return CustomAppBar(
              scrollOffSet: scrollOfSet,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          SliverToBoxAdapter(
            child: ContentHeader(
              key: PageStorageKey('contentHeader'),
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: "Previews",
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('myList'),
                title: "My List",
                contentList: myList),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('originals'),
                title: "Netflix Orignals",
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                  key: PageStorageKey('trending'),
                  title: "Trending",
                  contentList: trending),
            ),
          )
        ],
      ),
    );
  }
}
