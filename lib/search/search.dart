import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key, this.isToggle}) : super(key: key);

  final isToggle;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    );
  }
}
