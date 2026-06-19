import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/core/widgets/drawer.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/journal/presentation/widgets/entry_preview.dart';
import 'package:breathe/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.deleteEntryTitle),
          content: Text(l10n.actionCannotBeUndone),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                l10n.delete,
                style: const TextStyle(color: AppColors.errorContainer),
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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.entryDeleted)));

      context.pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorWithDetails(e.toString()))),
      );
    }
  }

  Future<void> _saveChanges(JournalEntry originalEntry) async {
    final l10n = AppLocalizations.of(context)!;
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
        ).showSnackBar(SnackBar(content: Text(l10n.entryChanged)));
        context.pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorWithDetails(e.toString()))),
      );
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _date(BuildContext context, JournalEntry entry) {
    final locale = Localizations.localeOf(context).toString();
    final formattedDate = DateFormat(
      'EEEE, d MMMM, HH:mm',
      locale,
    ).format(entry.createdAt);

    return Text(
      formattedDate.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 12,
        color: context.colors.surfaceDim,
      ),
    );
  }

  Widget _title(
    BuildContext context,
    JournalEntry entry,
    AppLocalizations l10n,
  ) {
    final moodKey = entry.moodKey;
    final mood = moodKey == null ? '-' : l10n.moodLabel(moodKey);
    return Text(
      l10n.feelingMood(mood),
      style: context.textTheme.headlineMedium?.copyWith(fontSize: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entryAsync = ref.watch(entryProvider(widget.entryId));

    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: context.colors.surface),
            ),
          ),

          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 35, 24, 24),
              child: entryAsync.when(
                data: (data) {
                  if (data == null) {
                    return Center(child: Text(l10n.entryNotFound));
                  }
                  if (!_prefilled) {
                    _writtingSpace.text = data.text;
                    _prefilled = true;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _date(context, data),
                      _title(context, data, l10n),
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
                          text: l10n.onMyMind,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.surfaceDim,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: data.problemKeys.join('  •  '),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colors.surfaceDim,
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
                                      l10n.edit.toUpperCase(),
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 1.4,
                                          ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () => _deleteEntry(widget.entryId),
                              child: Text(
                                l10n.delete.toUpperCase(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 1.4,
                                  color: AppColors.errorContainer,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),

                            isReadOnly
                                ? const SizedBox.shrink()
                                : CustomElevatedButton(
                                    label: l10n.save.toUpperCase(),
                                    onTap: () => _saveChanges(data),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                error: (e, _) =>
                    Center(child: Text(l10n.errorWithDetails(e.toString()))),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
