import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/features/home/ui/sub_screen/Admin/best_selling_screen.dart';
import 'package:searchfield/searchfield.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:mobileproject/core/helpers/providers/all_clothes_provider.dart';
import 'package:mobileproject/core/helpers/providers/privileges_provider.dart';
import 'package:mobileproject/core/models/clothes.dart';
import 'package:mobileproject/features/home/ui/sub_screen/Admin/add_cloth.dart';
import 'package:mobileproject/features/home/ui/sub_screen/clothes_screen.dart';
import 'package:mobileproject/features/home/ui/widgets/cloth_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  late Clothes searchedCloth;
  var isSearching = false;
  late stt.SpeechToText _speech;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    Future(
      () {
        ref.watch(allClothesProvider.notifier).getAllProducts();
        final currentUser = ref.watch(privilegesProvider).valueOrNull!;
        isAdmin = currentUser.isAdmin;
      },
    );
  }

  void _itemFound(Clothes cloth) {
    searchedCloth = cloth;
    setState(() {
      isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clothesData = ref.watch(allClothesProvider);
    //----------------Search by Barcode----------------------------
    Future<String?> onTabBarCode() async {
      try {
        // Await the barcode scanner to get the scanned data
        String scannedName = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);

        // Check if the user canceled the scan
        if (scannedName == '-1') {
          return "canceled";
        }

        final clothes = clothesData.valueOrNull;
        if (clothes == null) {
          return null;
        }

        final matchedCloth = clothes.firstWhere(
          (cloth) => cloth.name.toLowerCase() == scannedName.toLowerCase(),
        );

        return matchedCloth.name;
      } catch (e) {
        return null;
      }
    }

    //--------------------Search by Voice-----------------

    Future<String?> searchByVoice() async {
      try {
        // Initialize the speech-to-text engine
        bool available = await _speech.initialize(
          onStatus: (status) {
            print('Speech Status: $status');
          },
          onError: (error) {
            print('Speech Error: $error');
          },
        );
        if (!available) {
          print('Speech recognition not available');
          return null;
        }

        String? finalRecognizedWords;

        // Start listening
        _speech.listen(
          onResult: (result) {
            // Update the recognized words but do not complete until status is 'done'
            finalRecognizedWords = result.recognizedWords;
            print('Recognized Words: $finalRecognizedWords');
          },
          localeId: 'en_US', // Adjust this to match your language
        );

        // Wait until the speech recognition status changes to 'done' or timeout occurs
        await Future.delayed(
            const Duration(seconds: 5)); // Set a maximum listening time
        _speech.stop();

        if (finalRecognizedWords == null || finalRecognizedWords!.isEmpty) {
          print('No valid input captured');
          return null;
        }

        print('Captured Voice Input: $finalRecognizedWords');

        // Search for the matching cloth
        final clothes = clothesData.valueOrNull;
        if (clothes == null) {
          print('Clothes data is null');
          return null;
        }

        final matchedCloth = clothes.firstWhere(
          (cloth) =>
              cloth.name.toLowerCase() == finalRecognizedWords!.toLowerCase(),
        );

        return matchedCloth.name;
      } catch (e) {
        print('Error in searchByVoice: $e');
        return null;
      }
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Discover',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            if (isAdmin)
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const AddCloth(),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.black,
                ),
              ),IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const BestSelling(),
                  );
                },
                icon: const Icon(
                  Icons.pie_chart_outline,
                  size: 40,
                  color: Colors.black,
                ),
              ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: clothesData.when(
                      data: (clothesList) {
                        // Convert List<Clothes> to List<SearchFieldListItem<Clothes>>
                        final suggestions = clothesList
                            .map((clothes) => SearchFieldListItem<Clothes>(
                                  clothes
                                      .name, // Use a property of `Clothes` for display
                                  item:
                                      clothes, // Attach the original `Clothes` object
                                ))
                            .toList();

                        return SearchField<Clothes>(
                          searchInputDecoration: SearchInputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                //Use the search Icon button to search for the name scanned----
                                final clothes = clothesData.valueOrNull;
                                final cloth = clothes!.firstWhere(
                                  (cloth) =>
                                      cloth.name.toLowerCase() ==
                                      _searchController.text.toLowerCase(),
                                );
                                _itemFound(cloth);
                              },
                              icon: const Icon(
                                  Icons.search_outlined), //Search Icon
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                String? searchedByVoice = await searchByVoice();
                                print(
                                    '--------------$searchedByVoice--------------');
                                if (searchedByVoice == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "This product is not availaible!"),
                                      duration: Durations.extralong4,
                                    ),
                                  );
                                  _searchController.text = '';
                                } else {
                                  setState(() {
                                    _searchController.text =
                                        searchedByVoice.toString();
                                  });
                                }
                              },
                              icon: const Icon(
                                  Icons.mic_outlined), //Search by voice Icon
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1.w,
                                color: const Color.fromARGB(255, 211, 211, 211),
                              ),
                            ),
                            hintText: "Search for Clothes",
                          ),
                          suggestions: suggestions,
                          controller: _searchController,
                          onSuggestionTap: (val) {
                            for (var cloth in suggestions) {
                              val == cloth ? _itemFound(val.item!) : null;
                            }
                          },
                        );
                      },
                      loading: () => Container(),
                      error: (error, stackTrace) =>
                          Center(child: Text('Error: $error')),
                    ),
                  ),
                  IconButton(
                    //------------------Scanner button----------------
                    onPressed: () async {
                      String? searchedByBarcode = await onTabBarCode();
                      if (searchedByBarcode == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("This product is not availaible!"),
                            duration: Durations.extralong4,
                          ),
                        );
                        _searchController.text = '';
                      } else if (searchedByBarcode == "canceled") {
                        _searchController.text = '';
                      } else {
                        setState(() {
                          _searchController.text = searchedByBarcode.toString();
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner_outlined,
                      size: 38,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if (isSearching)
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 250,
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 10,
                    ),
                    children: [
                      ClothCard(
                        cloth: searchedCloth,
                        category: searchedCloth.category,
                      )
                    ],
                  ),
                ),
              //----------------------------------------------------------normal page without searching
              if (!isSearching)
                TabBar(
                  enableFeedback: true,
                  labelPadding: const EdgeInsets.all(0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  dividerHeight: 0,
                  tabs: const [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Men",
                    ),
                    Tab(
                      text: "Women",
                    ),
                    Tab(
                      text: "Kids",
                    ),
                  ],
                ),
              if (!isSearching)
                const Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: ClothesScreen(collection: 'all')),
                      Center(child: ClothesScreen(collection: 'men')),
                      Center(child: ClothesScreen(collection: 'women')),
                      Center(child: ClothesScreen(collection: 'kids')),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
