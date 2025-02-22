import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/helpers/providers/single_cloth_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/features/home/ui/sub_screen/cloth_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ClothCard extends ConsumerStatefulWidget {
  const ClothCard({super.key, required this.cloth, required this.category});
  final String category;
  final Clothes cloth;

  @override
  ConsumerState<ClothCard> createState() => _ClothCardState();
}

class _ClothCardState extends ConsumerState<ClothCard> {
  @override
  void initState() {
    super.initState();
    Future(
      () {
        ref
            .watch(singleClothProvider.notifier)
            .fetchSingleCloth(widget.cloth.uID, widget.category);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ClothDetailsScreen(
              cloth: widget.cloth, category: widget.cloth.category),
        ));
      },
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(widget.cloth.imagePath.toString()),
                  fit: BoxFit.fill,
                  height: 155.h,
                  width: 165.w,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cloth.name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$${widget.cloth.price}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
