import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
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
      backgroundColor: AppColors.surface,
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
              color: AppColors.borderSoft,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          for (final problem in problemsList)
            Builder(
              builder: (_) {
                final isSelected = _current.any((p) => p.key == problem.key);
                return ListTile(
                  tileColor: isSelected ? problem.bgColor : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(problem.title),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded, color: AppColors.forest)
                      : null,
                  onTap: () => setState(() {
                    if (isSelected) {
                      _current.removeWhere((p) => p.key == problem.key);
                    } else {
                      _current.add(problem);
                    }
                  }),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, _current),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
