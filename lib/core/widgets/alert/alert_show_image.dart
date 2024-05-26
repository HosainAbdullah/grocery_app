import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/core/widgets/components/horizontal_line_widget.dart';

class AlertShowImage extends StatelessWidget {
  const AlertShowImage({
    Key? key,
    required this.linkImage,
  }) : super(key: key);
  final String linkImage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      insetPadding: ResponsiveSize.defaultPadding(),
      actionsPadding: const EdgeInsets.all(10),
      actions: [
        const HorizontalLineWidget(),
        SizedBox(
          height: getScreenHeight(15),
        ),
        GestureDetector(
          child: Center(
            child: Hero(
              tag: 'imageHero',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  ResponsiveSize.defaultRadius(size: 8),
                ),
                child: CachedNetworkImage(
                  imageUrl: linkImage,
                  filterQuality: FilterQuality.low,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
