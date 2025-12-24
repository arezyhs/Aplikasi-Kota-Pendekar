import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';

/// Reusable section header untuk layanan
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: Icon(
            icon,
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withValues(alpha: 0.6),
            size: 20,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: AppFontWeight.bold,
              ),
        ),
      ],
    );
  }
}

/// Reusable app card untuk grid
class AppCard extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const AppCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth * 0.20,
            height: screenWidth * 0.16,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: screenWidth * 0.14,
                height: screenWidth * 0.14,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppTextSize.caption,
                fontWeight: AppFontWeight.medium,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
