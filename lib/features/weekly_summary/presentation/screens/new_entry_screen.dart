import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/chips.dart';
import 'package:breathe/core/widgets/text_area.dart';
import 'package:breathe/features/weekly_summary/presentation/widgets/emotion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_drawer.dart';

class NewEntryScreen extends ConsumerStatefulWidget {
  const NewEntryScreen({super.key});

  @override
  ConsumerState<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends ConsumerState<NewEntryScreen> {
  String? _selectedMood;
  double _energy = 0.5;
  Set<String> _factorsSelected = {};

  final _writtingSpace = TextEditingController();

  //--------------------- WIDGETS ---------------------
  @override
  void dispose() {
    _writtingSpace.dispose();
    super.dispose();
  }

  //--------------------- WIDGETS ---------------------
  Widget _myAppBar() {
    final formattedDate = DateFormat(
      'EEEE, d MMMM, HH:mm',
      'en_US',
    ).format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NEW ENTRY', style: Theme.of(context).textTheme.headlineMedium),
        Text(formattedDate, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _moodsSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How are you feeling?', style: context.textTheme.labelMedium),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: moods.map((mood) {
            return EmotionCard(
              asset: mood.asset,
              mood: mood.title,
              isSelected: _selectedMood == mood.key,
              onTap: () => setState(() => _selectedMood = mood.key),
              isSelectedBgColor: mood.bgColor,
              isSelectedBorderColor: mood.borderColor,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _energySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Energy', style: context.textTheme.labelMedium),
            Text(_energyLabel(), style: context.textTheme.bodySmall),
          ],
        ),
        SizedBox(height: 15),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.sand,
            inactiveTrackColor: const Color.fromARGB(85, 151, 151, 151),
            thumbColor: Colors.white,
            trackHeight: 6,
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            value: _energy,
            onChanged: (newValue) => setState(() => _energy = newValue),
          ),
        ),
      ],
    );
  }

  String _energyLabel() {
    if (_energy < 0.33) return 'Low';
    if (_energy < 0.66) return 'Medium';
    return 'High';
  }

  Widget _factorsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What made yor day harder?', style: context.textTheme.labelMedium),
        SizedBox(height: 15),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: problemsList.map((problem) {
            final selected = _factorsSelected.contains(problem.key);

            return CustomChip(
              label: problem.title,
              isSelected: selected,
              bgColor: problem.bgColor,
              borderColor: problem.borderColor,
              icon: problem.icon,
              onTap: () => setState(() {
                if (selected) {
                  _factorsSelected.remove(problem.key);
                } else {
                  _factorsSelected.add(problem.key);
                }
              }),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _writtingTextArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you want to write about it?',
          style: context.textTheme.labelMedium,
        ),
        SizedBox(height: 15),
        CustomTextArea(
          controller: _writtingSpace,
          placeholder: "What's been on your mind?",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: _myAppBar(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              children: [
                _moodsSelector(context),
                SizedBox(height: 45),
                _energySlider(),
                SizedBox(height: 45),
                _factorsSelector(),
                SizedBox(height: 45),
                _writtingTextArea(),
                SizedBox(height: 20),
                Text(
                  "Take your time. Writing is just for you — only if it feels right.",
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
