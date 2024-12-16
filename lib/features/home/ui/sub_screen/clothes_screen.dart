import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileproject/core/helpers/providers/clothes_provider.dart';
import 'package:mobileproject/features/home/ui/widgets/cloth_card.dart';

class ClothesScreen extends ConsumerStatefulWidget {
  const ClothesScreen({super.key, required this.collection});
  final String collection;

  @override
  ConsumerState<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends ConsumerState<ClothesScreen> {
  @override
  void initState() {
    Future(
      () async {
        if (widget.collection == "all") {
          ref.read(clothesProvider.notifier).getAllProducts();
        } else {
          ref.read(clothesProvider.notifier).getClothes(widget.collection);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clothesData = ref.watch(clothesProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: clothesData.when(
        data: (clothesData) {
          // Data is loaded, display the grid
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 250,
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 10, // Vertical spacing
            ),
            itemCount: clothesData.length,
            itemBuilder: (context, index) {
              return ClothCard(
                  cloth: clothesData[index], category: widget.collection);
            },
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator()), // Show loading spinner
        error: (error, stackTrace) =>
            Center(child: Text('Error: $error')), // Handle error state
      ),
    );
  }
}
