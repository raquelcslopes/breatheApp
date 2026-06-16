import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MoodPickerSheet extends StatefulWidget {
  final Moods? selected;
  const MoodPickerSheet({super.key, this.selected});

  static Future<Moods?> show(BuildContext context, {Moods? selected}) {
    return showModalBottomSheet<Moods>(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => MoodPickerSheet(selected: selected),
    );
  }

  @override
  State<MoodPickerSheet> createState() => _MoodPickerSheetState();
}

class _MoodPickerSheetState extends State<MoodPickerSheet> {
  Moods? _current;

  @override
  void initState() {
    super.initState();
    _current = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.outline,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          for (final mood in moods)
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: CircleAvatar(radius: 9),
              title: Text(mood.title),
              trailing: mood.key == _current?.key
                  ? const Icon(Icons.check_rounded, color: AppColors.background)
                  : null,
              onTap: () {
                setState(() => _current = mood);
                Navigator.pop(context, _current);
              },
            ),
        ],
      ),
    );
  }
}
