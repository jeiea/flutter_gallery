import 'dart:math';

import 'package:flutter/material.dart';

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

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Flexible(child: _buildGrid())]),
    ));
  }

  Widget _buildGrid() => GridView.count(
      padding: const EdgeInsets.all(4),
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true,
      children: _buildGridTileList(100));

  List<Widget> _buildGridTileList(int count) =>
      List.generate(count, (i) => RandomImage());
}

class RandomImage extends StatefulWidget {
  final url = 'https://picsum.photos/800/800?random=${Random().nextInt(10000)}';

  @override
  _RandomImageState createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(NetworkImage(widget.url), context);
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(widget.url);
  }
}
