import 'package:flutter/material.dart';
import 'package:mobileproject/core/theming/styles.dart';
import 'package:mobileproject/features/account/data/list_of_questions.dart';
import 'package:mobileproject/features/account/widgets/horizontal_text_with_scroll.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {

  TextEditingController _searchController = TextEditingController();
  String selectedCategory = "General"; // Default category
  void initState() {
    super.initState();
    _filterFAQs(); // Initial filtering
    _searchController.addListener(() {
      _filterFAQs();
    });
  }
  String _filterFAQs() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredFAQs = faqs
          .where((faq) =>
      (faq['category'] == selectedCategory) && // Filter by category
          (faq['question']!.toLowerCase().contains(query) ||
              faq['answer']!.toLowerCase().contains(query))) // Search query
          .toList();
    });
    return _searchController.text.toLowerCase();
  }
  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      _filterFAQs(); // Re-filter the FAQs based on the new category
    });
  }

  List<Map<String, String>> filteredFAQs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "FAGs",
          style: MyTextStyle.font22BlackSemiBold,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            HorizontalTextScroller(
              onCategorySelected: _onCategorySelected,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0,right: 0,left: 0,bottom: 0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.black45,),
                  hintText: "Search for questions...",
                  hintStyle: TextStyle(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFAQs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Card(color: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          filteredFAQs[index]['question']!,
                          style: MyTextStyle.font18BlackSemiBold
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              filteredFAQs[index]['answer']!,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
