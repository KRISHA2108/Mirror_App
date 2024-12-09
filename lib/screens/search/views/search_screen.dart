import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  late HomeProvider providerW;
  late HomeProvider providerR;
  Widget build(BuildContext context) {
    providerW = context.watch<HomeProvider>();
    providerR = context.read<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Search History'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: providerW.searchHistory.length,
        itemBuilder: (context, index) {
          final history = providerW.searchHistory[index];
          return ListTile(
            title: Text(
              history,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.clear_all,
              ),
              onPressed: () {
                providerR.removeSearch(history);
              },
            ),
          );
        },
      ),
    );
  }
}
