import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.obscure,
    required this.hint,
    required this.isLast,
    required this.controller,
  });
  final bool obscure;
  final String hint;
  final TextEditingController controller;
  final bool isLast;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

bool showPW = true;

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction:
          widget.isLast == true ? TextInputAction.done : TextInputAction.next,
      obscureText: widget.obscure & showPW,
      decoration: InputDecoration(
          suffixIcon: widget.obscure == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      showPW = !showPW;
                    });
                  },
                  child: showPW == true
                      ? const Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.blue,
                        ))
              : null,
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFF2A3038)),
    );
  }
}
