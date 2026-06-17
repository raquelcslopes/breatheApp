import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProblemPicker extends StatefulWidget {
  final List<Problems>? selected;
  const ProblemPicker({super.key, this.selected});

  static Future<List<Problems>?> show(
    BuildContext context, {
    List<Problems>? selected,
  }) {
    return showModalBottomSheet<List<Problems>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => ProblemPicker(selected: selected),
    );
  }

  @override
  State<ProblemPicker> createState() => _ProblemPickerState();
}

class _ProblemPickerState extends State<ProblemPicker> {
  late List<Problems> _current;

  @override
  void initState() {
    super.initState();
    _current = [...?widget.selected];
  }

  Widget _problemTile(Problems problem) {
    final l10n = AppLocalizations.of(context)!;
    final isSelected = _current.any((p) => p.key == problem.key);
    return ListTile(
      tileColor: isSelected ? context.colors.primary.withAlpha(80) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(l10n.problemLabel(problem.key)), // <-- era problem.key
      trailing: isSelected ? const Icon(Icons.check_rounded) : null,
      onTap: () => setState(() {
        if (isSelected) {
          _current.removeWhere((p) => p.key == problem.key);
        } else {
          _current.add(problem);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
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
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  for (final problem in problemsList) _problemTile(problem),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _current),
                child: Text(l10n.confirm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
