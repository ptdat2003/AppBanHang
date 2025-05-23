import 'package:flutter/material.dart';
import '../widgets/all_products.dart';
import '../widgets/categories.dart';
import '../widgets/header.dart';
import '../widgets/new_in.dart';
import '../widgets/search_field.dart';
import '../widgets/top_selling.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header cố định ở trên đầu
          const Header(),
          
          // Phần nội dung có thể cuộn
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: const Column(
                children: [
                  SizedBox(height: 24,),
                  SearchField(),
                  SizedBox(height: 24,),
                  Categories(),
                  SizedBox(height: 24,),
                  TopSelling(),
                  SizedBox(height: 24,),
                  NewIn(),
                  SizedBox(height: 24,),
                  AllProducts(),
                  SizedBox(height: 24,),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 8,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }
}