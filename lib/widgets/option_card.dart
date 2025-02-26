import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blueGrey[800] : null,
      child: ListTile(title: Text(option), onTap: onTap),
    );
  }
}
