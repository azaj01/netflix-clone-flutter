import 'package:flutter/material.dart';
import 'package:netflix_ui/assets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffSet;

  const CustomAppBar({super.key, this.scrollOffSet = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity((scrollOffSet / 350).clamp(0, 1).toDouble()),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(Assets.netflixLogo0),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppBarButton(
                      title: "TV Shows",
                      onTap: () {
                        print("TV Shows");
                      }),
                  _AppBarButton(
                      title: "Movies",
                      onTap: () {
                        print("Movies");
                      }),
                  _AppBarButton(
                      title: "My Lists",
                      onTap: () {
                        print("My Lists");
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const _AppBarButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
