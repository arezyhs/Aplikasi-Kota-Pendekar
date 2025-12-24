import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pendekar/utils/helpers/date_helper.dart';
import 'package:pendekar/constants/constant.dart';

/// Widget untuk menampilkan single news item dengan gambar, judul, author, dan tanggal
class NewsItemWidget extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsItemWidget({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = news['imageUrl'];
    final title = news['title'] ?? 'News';
    final author = news['author'] ?? 'Admin';
    final url = news['newsUrl'];
    final pubDate = news['pubDate'] ?? '';

    return InkWell(
      onTap: () => _handleTap(context, url),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author & Tanggal di paling atas
            _buildAuthorAndDate(context, author, pubDate),
            const SizedBox(height: AppSpacing.lg),
            // Gambar + Judul
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar
                _buildNewsImage(imageUrl),
                const SizedBox(width: AppSpacing.lg),
                // Judul + Icon
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: AppFontWeight.bold,
                            fontSize: AppTextSize.subtitle,
                            height: 1.3,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      const Icon(Icons.open_in_new,
                          size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorAndDate(
      BuildContext context, String author, String pubDate) {
    return Row(
      children: [
        const Icon(Icons.person, size: 14, color: Colors.grey),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            author,
            style: TextStyle(
              fontSize: AppTextSize.body,
              color: Colors.grey[600],
              fontWeight: AppFontWeight.medium,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
        const SizedBox(width: AppSpacing.xs),
        Text(
          DateHelper.formatRelativeDate(pubDate),
          style: TextStyle(
            fontSize: AppTextSize.caption,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildNewsImage(String? imageUrl) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
        ),
      );
    }
    return _buildImagePlaceholder(showBeritaIcon: true);
  }

  Widget _buildImagePlaceholder({bool showBeritaIcon = false}) {
    if (showBeritaIcon) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[100]!,
              Colors.blue[50]!,
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article, size: 36, color: Colors.blue[300]),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Berita',
              style: TextStyle(
                fontSize: AppTextSize.caption,
                color: Colors.blue[400],
                fontWeight: AppFontWeight.medium,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image),
    );
  }

  Future<void> _handleTap(BuildContext context, String? url) async {
    final messenger = ScaffoldMessenger.of(context);
    if (url != null && Uri.tryParse(url)?.isAbsolute == true) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        messenger.showSnackBar(
          const SnackBar(content: Text('Could not launch the URL.')),
        );
      }
    } else {
      messenger.showSnackBar(
        const SnackBar(content: Text('Invalid URL.')),
      );
    }
  }
}
