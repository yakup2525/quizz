// lib/widgets/option_widget.dart
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionWidget({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(optionText),
      leading: Radio(
        value: true,
        groupValue: isSelected,
        onChanged: (value) {
          onTap();
        },
      ),
      onTap: onTap,
    );
  }
}
