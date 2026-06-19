import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/core/widgets/text_area.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/journal/presentation/widgets/problem_picker_sheet.dart';
import 'package:breathe/features/journal/presentation/widgets/mood_picker_sheet.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

  String _showProblems(AppLocalizations l10n) {
    return _problemsSelected.map((p) => l10n.problemLabel(p.key)).join(', ');
  }

  Future<void> _saveEntry() async {
    final l10n = AppLocalizations.of(context)!;
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
      await ref.read(journalRepositoryProvider).saveJounalEntry(uid, entry);
      if (mounted) context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.couldntSaveEntry),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _date(BuildContext context, AppLocalizations l10n) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();

    final formattedDate = DateFormat('EEEE, d MMMM, HH:mm', locale).format(now);
    final weekday = DateFormat('EEEE', locale).format(now);

    final hour = now.hour;
    final partKey = hour < 12
        ? 'morning'
        : (hour < 18 ? 'afternoon' : 'evening');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        Text(
          '$weekday, ${l10n.partOfDayLabel(partKey)}',
          style: context.textTheme.headlineMedium?.copyWith(fontSize: 36),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(color: context.colors.surface),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _date(context, l10n),
              const SizedBox(height: 8),
              Container(
                height: 0.5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      context.colors.outline,
                      context.colors.outline,
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.2, 0.8, 1.0],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: CustomTextArea(controller: _writtingSpace)),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _pickMood,
                      child: Text(
                        _moodSelected == null
                            ? l10n.moodPickerLabel
                            : l10n.moodLabel(_moodSelected!.key),
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _pickProblem,
                      child: Text(
                        _problemsSelected.isEmpty
                            ? l10n.problemsPickerLabel
                            : _showProblems(l10n),
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomElevatedButton(
                      label: l10n.save.toUpperCase(),
                      onTap: () => _saveEntry(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
