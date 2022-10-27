import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/app_constants.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
      ),
      imageUrl: imageUrl ?? AppConstans.imagePlaceHolder,
      imageBuilder: (context, imageProvider) => Image(
        width: width,
        height: height,
        image: imageProvider,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.error),
      ),
    );
  }
}
