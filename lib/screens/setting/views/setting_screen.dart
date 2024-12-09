import 'package:flutter/material.dart';
import 'package:mirror_wall/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Setting'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Theme'),
            trailing: Switch(
              value: context.watch<HomeProvider>().isTheme,
              onChanged: (value) {
                context.read<HomeProvider>().themeChange(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.bookmark);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("BookMark"),
                  Icon(Icons.bookmark_add_outlined)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
