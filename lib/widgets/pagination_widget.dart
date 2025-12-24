import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';

/// Reusable pagination widget with page numbers and navigation controls
class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm, horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPreviousButton(),
          const SizedBox(width: AppSpacing.xs),
          ..._buildPageNumbers(context),
          const SizedBox(width: AppSpacing.xs),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
      icon: const Icon(Icons.chevron_left, size: 20),
      color: currentPage > 1 ? Colors.blue : Colors.grey,
    );
  }

  Widget _buildNextButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      onPressed: currentPage < totalPages
          ? () => onPageChanged(currentPage + 1)
          : null,
      icon: const Icon(Icons.chevron_right, size: 20),
      color: currentPage < totalPages ? Colors.blue : Colors.grey,
    );
  }

  List<Widget> _buildPageNumbers(BuildContext context) {
    List<Widget> pages = [];
    int start = (currentPage - 2).clamp(1, totalPages);
    int end = (currentPage + 2).clamp(1, totalPages);

    // Adjust range if near start or end
    if (currentPage <= 3) {
      start = 1;
      end = 5.clamp(1, totalPages);
    } else if (currentPage >= totalPages - 2) {
      start = (totalPages - 4).clamp(1, totalPages);
      end = totalPages;
    }

    for (int i = start; i <= end; i++) {
      pages.add(_buildPageNumber(context, i));
    }
    return pages;
  }

  Widget _buildPageNumber(BuildContext context, int pageNumber) {
    final isCurrentPage = pageNumber == currentPage;

    return GestureDetector(
      onTap: () => onPageChanged(pageNumber),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        constraints: const BoxConstraints(
          minWidth: 28,
          minHeight: 28,
        ),
        decoration: BoxDecoration(
          color: isCurrentPage ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isCurrentPage ? Colors.blue : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            '$pageNumber',
            style: TextStyle(
              fontSize: AppTextSize.body,
              color: isCurrentPage
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight:
                  isCurrentPage ? AppFontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
