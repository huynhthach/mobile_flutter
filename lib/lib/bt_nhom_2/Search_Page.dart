import 'package:flutter/material.dart';

import 'data.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery;

  const SearchResultsPage({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: StreamBuilder<List<dynamic>>(
        stream: MyFirebaseCollection.search(searchQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              dynamic flashcard = snapshot.data![index];
              return ListTile(
                title: Text(flashcard['front']),
                subtitle: Text(flashcard['back']),
              );
            },
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter search query',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String searchQuery = _searchController.text;
                  if (searchQuery.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchResultsPage(searchQuery: searchQuery),
                      ),
                    );
                  }
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}