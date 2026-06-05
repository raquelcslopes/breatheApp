import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/text_area.dart';
import 'package:breathe/features/weekly_summary/presentation/widgets/problem_picker_sheet.dart';
import 'package:breathe/features/weekly_summary/presentation/widgets/mood_picker_sheet.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: SizedBox.shrink(),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _date(context),
                const SizedBox(height: 10),
                CustomTextArea(controller: _writtingSpace),
                Wrap(
                  children: [
                    ActionChip(
                      avatar: Icon(
                        Icons.tag_faces_outlined,
                        color: _moodSelected?.bgColor ?? AppColors.forest,
                      ),
                      label: Text(
                        _moodSelected == null
                            ? 'Add mood'
                            : 'Feeling ${_moodSelected!.title}',
                        style: TextStyle(
                          color: _moodSelected?.bgColor ?? AppColors.forest,
                        ),
                      ),
                      onPressed: _pickMood,
                    ),
                    const SizedBox(width: 10),
                    ActionChip(
                      avatar: Icon(Icons.psychology_alt_outlined),
                      label: Text(_showProblems()),
                      onPressed: _pickProblem,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
