import 'package:etkinlikapp/features/categories/domain/services/category_service.dart';
import 'package:flutter/material.dart';

class IlkSayfa extends StatelessWidget {
  const IlkSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder(
            future: CategoryService().getCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final categories = snapshot.data!;
                return Container(
                  height: 75,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            categories[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
