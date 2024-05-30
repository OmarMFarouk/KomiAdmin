import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
  const DrawerTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.ontap,
    required this.icon,
  });
  final String title;
  final IconData icon;
  final VoidCallback ontap;
  final bool isSelected;
  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        decoration: BoxDecoration(
            color: widget.isSelected == true ? const Color(0xFF22242E) : null,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF22242E)),
              child: Icon(
                widget.icon,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(widget.title)
          ],
        ),
      ),
    );
  }
}
