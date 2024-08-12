import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;

  Product(this.name, this.description);
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> _products = [
    Product("Product 1", "Description for Product 1"),
    Product("Product 2", "Description for Product 2"),
    Product("Product 3", "Description for Product 3"),
    // Add more products as needed
  ];

  List<Product> _searchResults = [
    // Add more products as needed
  ];

  @override
  void initState() {
    super.initState();
    _searchResults.addAll(_products);
  }

  void _performSearch(String query) {
    _searchResults.clear();
    if (query.isEmpty) {
      _searchResults.addAll(_products);
    } else {
      _searchResults.addAll(_products.where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase())));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(_searchResults, _performSearch),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_searchResults[index].name),
            subtitle: Text(_searchResults[index].description),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Product> searchList;
  final Function(String) onSearch;

  CustomSearchDelegate(this.searchList, this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the results based on the search query
    return Center(
      child: Text('Search Results for: ${query.trim()}'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    // You can fetch suggestions from your data source here
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchList[index].name),
          subtitle: Text(searchList[index].description),
          onTap: () {
            query = searchList[index].name;
            onSearch(query);
            close(context, query);
          },
        );
      },
    );
  }
}
