import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LazyLoadListView extends StatefulWidget {
  const LazyLoadListView({super.key});

  @override
  _LazyLoadListViewState createState() => _LazyLoadListViewState();
}

class _LazyLoadListViewState extends State<LazyLoadListView> {
  // Initialize variables
  List<dynamic> comments = [];
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    fetchData();
    // Add listener to the scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the end of the list, load more data
        fetchData();
      }
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?_page=$currentPage&_limit=20'));

    if (response.statusCode == 200) {
      setState(() {
        // Decode and add new data to the list
        comments.addAll(jsonDecode(response.body));
        currentPage++;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
      comments.clear(); // Clear the existing list
      currentPage = 1; // Reset page number
    });
    await fetchData(); // Fetch new data
    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Load ListView with Refresh'),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: comments.length + 1, // Add 1 for the loading indicator
          itemBuilder: (context, index) {
            if (index == comments.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final comment = comments[index];
            return ListTile(
              title: Text(comment['name']),
              subtitle: Text(comment['email']),
              // Add more ListTile properties as needed
            );
          },
        ),
      ),
    );
  }
}
