import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/core/widgets/drawer.dart';
import 'package:breathe/core/widgets/text_area.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/journal/presentation/widgets/problem_picker_sheet.dart';
import 'package:breathe/features/journal/presentation/widgets/mood_picker_sheet.dart';
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

  String _showProblems() {
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
      await ref.read(journalRepositoryProvider).saveJounalEntry(uid, entry);
      if (mounted) context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Couldn't save your entry."),
          backgroundColor: AppColors.errorContainer,
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
          formattedDate.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        Text(
          '$weekday, $partOfDay',
          style: context.textTheme.headlineMedium?.copyWith(fontSize: 40),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('lib/assets/journal.png', fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 35, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _date(context),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.outline,
                          AppColors.outline,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.2, 0.8, 1.0],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: CustomTextArea(controller: _writtingSpace)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _pickMood,
                          child: Text(
                            _moodSelected?.title ?? 'MOOD',
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
                                ? 'PROBLEMS'
                                : _showProblems(),
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomElevatedButton(
                          label: 'SAVE',
                          onTap: () => _saveEntry(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  color: AppColors.primary,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
