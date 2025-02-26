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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.amber.withAlpha((0.3 * 255).toInt())
                  : Colors.black.withAlpha((0.6 * 255).toInt()),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? Colors.amber
                    : Colors.grey.withAlpha((0.3 * 255).toInt()),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.amber : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.amber : Colors.white,
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
