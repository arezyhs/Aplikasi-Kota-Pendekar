import 'package:flutter/widgets.dart';

/// Notification untuk switch tab di BottomNavigationBar
class SwitchTabNotification extends Notification {
  final int index;
  const SwitchTabNotification(this.index);
}
