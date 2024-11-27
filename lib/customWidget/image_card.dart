import 'package:flutter/material.dart';
import 'package:netflix_ui/models/content_model.dart';

typedef GestureTapUpCallback = void Function(Content content);
class ImageCard extends StatefulWidget {
  final Content contentData;
  final bool isSelected;
  final GestureTapUpCallback? onItemTap;

  const ImageCard({
    Key? key,
    required this.contentData,
    required this.isSelected,
    this.onItemTap,
  }) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  final GlobalKey _videoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onItemTap!(widget.contentData);
      },
      child: Stack(
        children: [
          AnimatedContainer(
              margin: widget.isSelected
                  ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4)
                  : const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 10)
                  ]),
              duration: const Duration(milliseconds: 250),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Flow(
                    delegate: ParallaxFlowDelegate(
                        scrollable: Scrollable.of(context),
                        listItemContext: context,
                        backgroundImageKey: _videoKey),
                    children: [
                      Image.asset(
                        widget.contentData.imageUrl,
                        fit: BoxFit.cover,
                        key: _videoKey,
                      )
                    ],
                  ))
          ),
          AnimatedContainer(
              width: double.infinity,
              height: double.infinity,
              margin: widget.isSelected
                  ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4)
                  : const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: const LinearGradient(colors: [
                    Colors.black87,
                    Colors.black26,
                    Colors.transparent,
                    Colors.transparent,
                  ], stops: [
                    0,
                    0.20,
                    0.30,
                    1
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              duration: const Duration(milliseconds: 250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: Text(
                      widget.contentData.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxHeight,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.topCenter(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final horizontalAlignment = Alignment(scrollFraction * 2 - 1, 0.0);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = horizontalAlignment.inscribe(
        backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(childRect.left, 0.0)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
