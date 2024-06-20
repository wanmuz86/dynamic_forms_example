import 'package:flutter/material.dart';

class DynamicTextField extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;
  const DynamicTextField({this.initialValue, required this.onChanged, super.key});

  @override
  State<DynamicTextField> createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  var textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textEditingController.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: widget.onChanged,
      decoration: const InputDecoration(hintText: "Enter your friend's name"),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
