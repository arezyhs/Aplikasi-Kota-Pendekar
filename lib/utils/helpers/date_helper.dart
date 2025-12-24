/// Helper class untuk formatting tanggal
class DateHelper {
  /// Format tanggal menjadi format relatif (misal: "2 jam lalu", "Kemarin", dll)
  ///
  /// Returns:
  /// - "X menit lalu" jika < 1 jam
  /// - "X jam lalu" jika < 1 hari
  /// - "Kemarin" jika 1 hari
  /// - "X hari lalu" jika < 7 hari
  /// - "DD MMM YYYY" jika >= 7 hari
  static String formatRelativeDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inDays == 0) {
        if (diff.inHours == 0) {
          return '${diff.inMinutes} menit lalu';
        }
        return '${diff.inHours} jam lalu';
      } else if (diff.inDays == 1) {
        return 'Kemarin';
      } else if (diff.inDays < 7) {
        return '${diff.inDays} hari lalu';
      } else {
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'Mei',
          'Jun',
          'Jul',
          'Ags',
          'Sep',
          'Okt',
          'Nov',
          'Des'
        ];
        return '${date.day} ${months[date.month - 1]} ${date.year}';
      }
    } catch (e) {
      return '';
    }
  }
}
