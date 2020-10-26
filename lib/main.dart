import 'package:flutter/material.dart';
import 'package:flutter_gallery/hooks/use_pager.dart';
import 'package:flutter_gallery/hooks/use_string_provider.dart';
import 'package:flutter_gallery/tab_navigation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestPage(),
    );
  }
}

class TestPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useStringProvider();
    final pager = usePager(provider);
    return TabNavigation(
        tabIndex: 0,
        body: PagedListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(),
          pagingController: pager,
          builderDelegate: PagedChildBuilderDelegate<String>(
              itemBuilder: (context, item, index) => Text(item)),
        ));
  }
}
