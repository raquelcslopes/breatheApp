import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/text_area.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/weekly_summary/presentation/widgets/problem_picker_sheet.dart';
import 'package:breathe/features/weekly_summary/presentation/widgets/mood_picker_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/app_drawer.dart';

class NewEntryScreen extends ConsumerStatefulWidget {
  const NewEntryScreen({super.key});

  @override
  ConsumerState<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends ConsumerState<NewEntryScreen> {
  final _writtingSpace = TextEditingController();
  Moods? _moodSelected;
  List<Problems> _problemsSelected = [];

  //--------------------- FUNCTIONS ---------------------
  @override
  void dispose() {
    _writtingSpace.dispose();
    super.dispose();
  }

  Future<void> _pickMood() async {
    final mood = await MoodPickerSheet.show(context, selected: _moodSelected);
    if (mood != null) setState(() => _moodSelected = mood);
  }

  Future<void> _pickProblem() async {
    final result = await ProblemPicker.show(
      context,
      selected: _problemsSelected,
    );
    if (result != null) {
      setState(() => _problemsSelected = result);
    }
  }

  String _showProblems() {
    if (_problemsSelected.isEmpty) return "What's making it harder?";
    return _problemsSelected.map((p) => p.title).join(', ');
  }

  Future<void> _saveEntry() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final text = _writtingSpace.text.trim();

    final isEmpty =
        text.isEmpty && _moodSelected == null && _problemsSelected.isEmpty;
    if (uid == null || isEmpty) return;

    final entry = JournalEntry(
      id: '',
      text: text,
      moodKey: _moodSelected?.key,
      problemKeys: _problemsSelected.map((p) => p.key).toList(),
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(journalRepositoryProvider).saveJounalEnrtry(uid, entry);
      if (mounted) context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Couldn't save your entry."),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _date(BuildContext context) {
    final formattedDate = DateFormat(
      'EEEE, d MMMM, HH:mm',
      'en_US',
    ).format(DateTime.now());

    final now = DateTime.now();
    final hour = now.hour;
    final partOfDay = hour < 12
        ? 'morning'
        : (hour < 18 ? 'afternoon' : 'evening');
    final weekday = DateFormat('EEEE').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
        ),
        Text('$weekday, $partOfDay', style: context.textTheme.headlineMedium),
      ],
    );
  }

  Widget _saveButton() {
    return ValueListenableBuilder(
      valueListenable: _writtingSpace,
      builder: (context, value, _) {
        final hasEntry =
            _moodSelected != null ||
            _problemsSelected.isNotEmpty ||
            value.text.trim().isNotEmpty;
        return TextButton(
          onPressed: hasEntry ? _saveEntry : null,
          child: const Text('Save'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.centerRight, child: _saveButton()),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 52,
              top: 0,
              bottom: 0,
              child: Container(
                width: 1.4,
                color: AppColors.primary.withValues(alpha: 0.22),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(64, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _date(context),
                  const SizedBox(height: 10),
                  Expanded(child: CustomTextArea(controller: _writtingSpace)),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Wrap(
                      children: [
                        ActionChip(
                          avatar: Icon(
                            Icons.tag_faces_outlined,
                            color:
                                _moodSelected?.bgColor ??
                                context.colors.onSurface,
                          ),
                          label: Text(
                            _moodSelected == null
                                ? 'Add mood'
                                : 'Feeling ${_moodSelected!.title}',
                            style: TextStyle(color: _moodSelected?.bgColor),
                          ),
                          onPressed: _pickMood,
                        ),
                        const SizedBox(width: 10),
                        ActionChip(
                          avatar: Icon(
                            Icons.psychology_alt_outlined,
                            color: context.colors.onSurface,
                          ),
                          label: Text(_showProblems()),
                          onPressed: _pickProblem,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
