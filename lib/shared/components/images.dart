//----------------------------------------------- CachedNetworkImage------------------------------------------------------------
import 'package:alefakaltawinea_animals_app/shared/components/utlite.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cachedNetworkImageDefault(
    {@required url, double height = 120.0, double width = 120.0}) {
  return Container(
    height: height,
    width: width,
    decoration: boxDecoration(radius: 10,color: whiteColor),
    child: CachedNetworkImage(
      imageUrl: "$url",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(border_radius_sm),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
              ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: (Colors.grey[300])!,
        highlightColor: (Colors.grey[100])!,
        child: Container(
          decoration: boxDecoration(radius: 10,color: whiteColor),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.image,
        size: 40,
        color: Colors.grey,
      ),
    ),
  );
}
Widget assetImageDefault({image,height = 30.0}){
  return Image.asset(image , height: height,);
}