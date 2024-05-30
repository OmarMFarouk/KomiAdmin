import 'package:flutter/material.dart';

class MySearch extends StatelessWidget {
  const MySearch({
    super.key,
    required this.searchCont,
    required this.onChanged,
  });

  final TextEditingController searchCont;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFF191C24),
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.deepPurple.shade600,
              ),
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent),
          controller: searchCont,
          onChanged: (value) {
            onChanged();
          },
        ));
  }
}
