import 'package:flutter/material.dart';
import 'package:mirror_wall/routes/routes.dart';
import 'package:mirror_wall/screens/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late HomeProvider homeProviderR;
  late HomeProvider homeProviderW;
  @override
  Widget build(BuildContext context) {
    homeProviderR = context.read<HomeProvider>();
    homeProviderW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Bookmark'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: homeProviderW.bookmark.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: homeProviderW.bookmark.isEmpty
                  ? const Text('No found data')
                  : Text(homeProviderW.bookmark[index]),
              onTap: () {
                Navigator.pushNamed(context, Routes.home,
                    arguments: homeProviderW.bookmark[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
