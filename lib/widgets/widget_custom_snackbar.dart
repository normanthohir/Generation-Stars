import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    required SnackbarType type,
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final theme = Theme.of(context);
    late Color backgroundColor;
    late IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackbarType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info;
        break;
    }

    showTopSnackBar(
      overlay.context,
      Material(
        color: backgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showTopSnackBar(BuildContext context, Widget child) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    OverlayEntry? entry; // Declare entry here

    entry = OverlayEntry(
      // Initialize entry here
      builder: (context) => TopSnackBar(
        child: child,
        onDismissed: () =>
            entry?.remove(), // Use entry?.remove() to avoid null safety issues
      ),
    );

    overlay.insert(entry);
    Future.delayed(
        const Duration(seconds: 3),
        () =>
            entry?.remove()); // Use entry?.remove() to avoid null safety issues
  }
}

class TopSnackBar extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;

  const TopSnackBar({
    super.key,
    required this.child,
    required this.onDismissed,
  });

  @override
  State<TopSnackBar> createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), widget.onDismissed);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -100 + 100 * value),
          child: child,
        );
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.up,
        onDismissed: (_) => widget.onDismissed(),
        child: widget.child,
      ),
    );
  }
}
