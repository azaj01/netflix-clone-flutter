import 'package:flutter/material.dart';
import 'package:netflix_ui/customWidget/vertical_icon_button.dart';
import 'package:netflix_ui/models/content_model.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(featuredContent.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250,
            child: Image.asset(featuredContent.titleImageUrl!),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                    icon: Icons.add, title: "Add", onTap: () => print("Add")),
                _PlayButton(),
                VerticalIconButton(
                    icon: Icons.info_outline,
                    title: "Info",
                    onTap: () => print("Add")),
              ],
            ))
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: const EdgeInsets.fromLTRB(10.0, 5.0, 20.0, 5.0)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: 30.0,
      ),
      label: const Text("Play",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: Colors.black),),
    );
  }
}
