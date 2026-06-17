import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: context.colors.outline,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          for (final mood in moods)
            ListTile(
              tileColor: mood.key == _current?.key
                  ? context.colors.primary.withAlpha(80)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(l10n.moodLabel(mood.key)),
              trailing: mood.key == _current?.key
                  ? Icon(Icons.check_rounded)
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
