import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/routes/routes.dart';
import 'package:mirror_wall/screens/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  PullToRefreshController? pullToRefreshController;
  late HomeProvider providerR;
  late HomeProvider providerW;
  @override
  initState() {
    context.read<HomeProvider>().checkIndex();
    context.read<HomeProvider>().checkConnection();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            onRefresh: () {
              if (defaultTargetPlatform == TargetPlatform.android) {
                context.watch<HomeProvider>().webController!.reload();
              }
            },
          );
    super.initState();
  }

  String? selectedIndex;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Browser',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () async {
              if (providerR.webController != null &&
                  await providerR.webController!.canGoBack()) {
                providerR.webController!.goBack();
              }
            },
          ),
          IconButton(
              onPressed: () {
                if (providerR.webController != null) {
                  providerR.webController!.reload();
                }
              },
              icon: const Icon(
                Icons.refresh,
              )),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
            onPressed: () async {
              if (providerR.webController != null &&
                  await providerR.webController!.canGoForward()) {
                providerR.webController!.goForward();
              }
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      title: Text(
                        "Search Engines",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      content: SizedBox(
                        height: 240,
                        width: 400,
                        child: Column(
                          children: [
                            RadioMenuButton(
                              value: 'Google',
                              groupValue: selectedIndex,
                              onChanged: (val) {
                                providerW.webController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri("https://www.google.com/"),
                                  ),
                                );
                                String url = "https://www.google.com/";
                                providerR.selectIndex(url);
                                selectedIndex = val;
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Google",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                            RadioMenuButton(
                              value: 'Bing',
                              groupValue: selectedIndex,
                              onChanged: (val) {
                                providerW.webController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri("https://www.bing.com/"),
                                  ),
                                );
                                String url = "https://www.bing.com/";
                                providerR.selectIndex(url);
                                selectedIndex = val;
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Bing",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                            RadioMenuButton(
                              value: 'Yahoo',
                              groupValue: selectedIndex,
                              onChanged: (val) {
                                providerW.webController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri("https://www.yahoo.com/"),
                                  ),
                                );
                                String url = "https://www.yahoo.com/";
                                providerR.selectIndex(url);
                                selectedIndex = val;
                                url = "https://www.yahoo.com/";
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Yahoo",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                            RadioMenuButton(
                              value: 'Duck Duck Go',
                              groupValue: selectedIndex,
                              onChanged: (val) {
                                providerW.webController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri("https://duckduckgo.com/"),
                                  ),
                                );
                                String? url = "https://duckduckgo.com/";
                                providerR.selectIndex(url);
                                selectedIndex = val;
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Duck Duck Go",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                            RadioMenuButton(
                              value: 'Brave',
                              groupValue: selectedIndex,
                              onChanged: (val) {
                                providerW.webController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri("https://brave.com/en-in/"),
                                  ),
                                );
                                selectedIndex = val;
                                String url = "https://brave.com/en-in/";
                                providerR.selectIndex(url);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Brave",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              if (val == 1) {
                Navigator.pushNamed(context, Routes.search);
              }

              if (val == 2) {
                Navigator.pushNamed(context, Routes.settings);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    "Search Engine",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.search);
                  },
                  child: Text(
                    "Search History",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.settings);
                  },
                  value: 2,
                  child: Text(
                    "Setting",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
              ];
            },
            color: Colors.black,
          ),
        ],
      ),
      body: (providerW.isConnect)
          ? Column(
              children: [
                LinearProgressIndicator(
                  value: providerW.progress / 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (val) {
                      var url = WebUri(val);
                      context.read<HomeProvider>().webController?.loadUrl(
                            urlRequest: URLRequest(
                              url: WebUri(
                                  "https://www.google.com/search?q=$val"),
                            ),
                          );
                      providerR.setSearch(val);
                      controller.clear();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.add_link),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          String? currentUrl =
                              (await providerW.webController?.getUrl())
                                  ?.toString();
                          if (currentUrl != null) {
                            providerR.addBookmark(currentUrl);
                          } else {
                            print("Bookmark is not added");
                          }
                        },
                        icon: const Icon(Icons.bookmark_add_outlined),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        "${providerW.webController == null ? providerW.url : providerW.webController?.getUrl()}",
                      ),
                    ),
                    onProgressChanged: (controller, progress) {
                      providerR.setProgress((progress));
                      providerR.setProgress((progress / 100) as int);
                      if (progress == 100) {
                        pullToRefreshController!.endRefreshing();
                      }
                    },
                    onWebViewCreated: (controller) {
                      providerW.webController = controller;
                    },
                    pullToRefreshController: pullToRefreshController,
                    onLoadStart: (controller, url) {
                      pullToRefreshController!.endRefreshing();
                    },
                    onLoadStop: (controller, url) {
                      pullToRefreshController!.endRefreshing();
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Icon(Icons.wifi_off, size: 100),
            ),
    );
  }
}
