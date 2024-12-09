import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/helper/helper.dart';

class HomeProvider with ChangeNotifier {
  Connectivity connectivity = Connectivity();
  int progress = 0;
  List<String> searchHistory = [];
  List<String> bookmark = [];
  bool isConnect = false;
  bool isTheme = false;
  String url = 'https://www.google.com';
  InAppWebViewController? webController;
  Future<void> setSearch(String term) async {
    if (term.isNotEmpty && !searchHistory.contains(term)) {
      searchHistory.insert(0, term);
      await ShrHelper.shr.saveSearchHistory(searchHistory);
      notifyListeners();
    }
  }

  void getBrowserIndex() {
    checkIndex();
  }

  void checkConnection() async {
    StreamSubscription<List<ConnectivityResult>> results =
        (await Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          isConnect = false;
        } else {
          isConnect = true;
        }
        notifyListeners();
      },
    ));
  }

  Future<void> checkIndex() async {
    url = (await ShrHelper.shr.getIndex())!;
    notifyListeners();
  }

  void selectIndex(String index) {
    ShrHelper.shr.setIndex(index);
    notifyListeners();
  }

  Future<void> removeSearch(String term) async {
    searchHistory.remove(term);
    await ShrHelper.shr.saveSearchHistory(searchHistory);
    notifyListeners();
  }

  void themeChange(bool theme) {
    isTheme = theme;
    ShrHelper.shr.setTheme(theme);
    notifyListeners();
  }

  void getBookmark() async {
    bookmark = await ShrHelper.shr.getBookmark();
    notifyListeners();
  }

  void addBookmark(String value) async {
    bookmark.add(value);
    await ShrHelper.shr.setBookmark(bookmark);
    notifyListeners();
  }

  void checkTheme() async {
    bool? theme = await ShrHelper.shr.getTheme();
    isTheme = theme!;
    notifyListeners();
  }

  void setProgress(int value) {
    progress = value;
    notifyListeners();
  }
}
