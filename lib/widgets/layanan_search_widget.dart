import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';

class LayananSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final String searchText;
  final int resultCount;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const LayananSearchWidget({
    Key? key,
    required this.controller,
    required this.searchText,
    required this.resultCount,
    required this.onChanged,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasQuery = searchText.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSpacing.md),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Cari aplikasi layanan...',
              hintStyle: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withAlpha(128),
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              suffixIcon: hasQuery
                  ? IconButton(
                      icon: Icon(
                        Icons.clear_rounded,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withAlpha(128),
                      ),
                      onPressed: onClear,
                    )
                  : null,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md, horizontal: AppSpacing.sm),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
          ),
        ),

        // Search Results Counter
        if (hasQuery) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Ditemukan $resultCount aplikasi',
                style: TextStyle(
                  fontSize: AppTextSize.caption,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withAlpha(153),
                  fontWeight: AppFontWeight.medium,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
