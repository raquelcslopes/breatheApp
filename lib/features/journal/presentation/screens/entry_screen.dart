import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/utils/capitalize.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/core/widgets/drawer.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/journal/presentation/widgets/entry_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EntryScreen extends ConsumerStatefulWidget {
  final String entryId;

  const EntryScreen({super.key, required this.entryId});

  @override
  ConsumerState<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  bool isReadOnly = true;
  final _writtingSpace = TextEditingController();
  bool _prefilled = false;

  //--------------------- FUNCTIONS -------------------

  @override
  void dispose() {
    _writtingSpace.dispose();
    super.dispose();
  }

  Future<void> _deleteEntry(String entryId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete entry?'),
          content: const Text(
            'This action cannot be undone. Do you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.errorContainer),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return;

    try {
      await ref.read(journalRepositoryProvider).deleteEntry(uid, entryId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Entry deleted successfully')),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _saveChanges(JournalEntry originalEntry) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return;

    final newEntry = JournalEntry(
      id: originalEntry.id,
      text: _writtingSpace.text,
      moodKey: originalEntry.moodKey,
      problemKeys: originalEntry.problemKeys,
      createdAt: DateTime.now(),
    );

    try {
      await ref
          .read(journalRepositoryProvider)
          .editEntry(uid, originalEntry.id, newEntry);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Entry changed succssefully')));
        context.pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _date(BuildContext context, JournalEntry entry) {
    final formattedDate = DateFormat(
      'EEEE, d MMMM, HH:mm',
      'en_US',
    ).format(entry.createdAt);

    return Text(
      formattedDate.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 12,
        color: AppColors.textMuted,
      ),
    );
  }

  Widget _title(BuildContext context, JournalEntry entry) {
    return Text(
      'Feeling ${capitalize(entry.moodKey ?? '-')}',
      style: context.textTheme.headlineMedium?.copyWith(fontSize: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(entryProvider(widget.entryId));

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
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 35, 24, 24),
                child: entryAsync.when(
                  data: (data) {
                    if (data == null) {
                      return Center(child: Text('isempty'));
                    }
                    if (!_prefilled) {
                      _writtingSpace.text = data.text;
                      _prefilled = true;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _date(context, data),
                        _title(context, data),
                        const SizedBox(height: 20),
                        Expanded(
                          child: EntryPreview(
                            entry: data,
                            isReadOnly: isReadOnly,
                            controller: _writtingSpace,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'On my mind this day: ',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: data.problemKeys.join('• '),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 0.5,
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

                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isReadOnly
                                  ? TextButton(
                                      onPressed: () => setState(() {
                                        isReadOnly = false;
                                      }),
                                      child: Text(
                                        'Edit'.toUpperCase(),
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 1.4,
                                            ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              const SizedBox(width: 20),
                              TextButton(
                                onPressed: () => _deleteEntry(widget.entryId),
                                child: Text(
                                  'Delete'.toUpperCase(),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 1.4,
                                    color: AppColors.errorContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),

                              isReadOnly
                                  ? SizedBox.shrink()
                                  : CustomElevatedButton(
                                      label: 'Save'.toUpperCase(),
                                      onTap: () => _saveChanges(data),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  error: (e, _) => Center(child: Text('Error: $e')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.primary,
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
