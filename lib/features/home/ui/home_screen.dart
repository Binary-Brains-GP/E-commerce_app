import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileproject/core/widgets/app_text_field.dart';
import 'package:mobileproject/features/home/ui/sub_screen/clothes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _searchController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 35,
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
                    child: AppTextField(
                      errorOccurance: false,
                      controller: _searchController,
                      hintText: "Search for clothes...",
                      isSecuredField: false,
                      usePrefixIcon: true,
                      prefixIcon: Icons.search_outlined,
                      useSuffixIcon: true,
                      suffixIcon: Icons.mic_outlined,
                      validator: (p0) {
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
