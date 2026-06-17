// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String greeting(String partOfDay) {
    String _temp0 = intl.Intl.selectLogic(partOfDay, {
      'morning': 'Good morning',
      'afternoon': 'Good afternoon',
      'evening': 'Good evening',
      'other': 'Hello',
    });
    return '$_temp0';
  }

  @override
  String get homeSubtitle =>
      'A safe place for your thoughts, feelings, and experiences. Write honestly, reflect gently, and be yourself.';

  @override
  String get noRecentRecords => 'No records in the last 7 days';

  @override
  String errorWithDetails(String message) {
    return 'Error: $message';
  }

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalSubtitle => 'Reflect on your journey';

  @override
  String dayLabel(String when) {
    String _temp0 = intl.Intl.selectLogic(when, {
      'today': 'Today',
      'yesterday': 'Yesterday',
      'earlier': 'Earlier',
      'other': 'Earlier',
    });
    return '$_temp0';
  }

  @override
  String get checkInTitle => 'How are you feeling?';

  @override
  String get checkInSubtitle => 'A gentle pause for yourself';

  @override
  String get checkInTitleLong => 'How are you truly feeling?';

  @override
  String get checkInStorySubtitle =>
      'Each entry helps tell the story of your journey';

  @override
  String get writeSomething => 'Write something';

  @override
  String get recentEntry => 'Recent entry';

  @override
  String get weeklyIndex => 'WEEKLY INDEX';

  @override
  String get commonMood => 'COMMON MOOD';

  @override
  String moodLabel(String mood) {
    String _temp0 = intl.Intl.selectLogic(mood, {
      'okay': 'Okay',
      'good': 'Good',
      'low': 'Low',
      'other': '$mood',
    });
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Delete entry?';

  @override
  String get actionCannotBeUndone =>
      'This action cannot be undone. Do you want to continue?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get entryDeleted => 'Entry deleted successfully';

  @override
  String get entryChanged => 'Entry changed successfully';

  @override
  String feelingMood(String mood) {
    return 'Feeling $mood';
  }

  @override
  String get onMyMind => 'On my mind this day: ';

  @override
  String get entryNotFound => 'Entry not found';

  @override
  String get moodPickerLabel => 'MOOD';

  @override
  String get problemsPickerLabel => 'PROBLEMS';

  @override
  String get couldntSaveEntry => 'Couldn\'t save your entry.';

  @override
  String problemLabel(String problem) {
    String _temp0 = intl.Intl.selectLogic(problem, {
      'sleep': 'Sleep',
      'work': 'Work',
      'family': 'Family',
      'health': 'Health',
      'grief': 'Grief',
      'finances': 'Finances',
      'studies': 'Studies',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String partOfDayLabel(String part) {
    String _temp0 = intl.Intl.selectLogic(part, {
      'morning': 'morning',
      'afternoon': 'afternoon',
      'evening': 'evening',
      'other': 'day',
    });
    return '$_temp0';
  }

  @override
  String get confirm => 'Confirm';

  @override
  String get couldntLoadJourney => 'Couldn\'t load your journey';

  @override
  String get blankPageTitle => 'A blank page, just for you';

  @override
  String get blankPageSubtitle =>
      'Whenever it feels right, write a few words about your day. Only you will ever see them.';

  @override
  String get writeFirstEntry => 'Write your first entry';

  @override
  String get thisWeek => 'This week';

  @override
  String get mostDays => 'Most days';

  @override
  String get noMoodRecorded => 'No mood recorded';

  @override
  String get daysLogged => 'Days logged';

  @override
  String daysLoggedValue(int count) {
    return '$count of 7 days';
  }

  @override
  String get whatWeighedMost => 'WHAT WEIGHED MOST';

  @override
  String get yourNotes => 'YOUR NOTES';

  @override
  String viewAllEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'View all $count entries',
      one: 'View 1 entry',
    );
    return '$_temp0';
  }

  @override
  String errorLoadingContacts(String message) {
    return 'Error loading your contacts: $message';
  }

  @override
  String get yourPeopleTitle => 'Your people, in one place';

  @override
  String get yourPeopleSubtitle =>
      'Add the people who support you — a doctor, a therapist, a friend you trust.';

  @override
  String get addSomeone => 'Add someone';

  @override
  String get trustedPersonHint =>
      'One of them can be your trusted person — the one you reach first in a hard moment.';

  @override
  String get careTeamTitle => 'Care Team';

  @override
  String get careTeamSubtitle => 'Your support network, all in one place';

  @override
  String get createContact => 'Create contact';

  @override
  String get editContactTitle => 'Edit contact';

  @override
  String get contactCreated => 'Contact created successfully';

  @override
  String get contactChanged => 'Contact changed successfully';

  @override
  String get contactDeleted => 'Contact deleted successfully';

  @override
  String couldntSaveContact(String message) {
    return 'Couldn\'t save the contact: $message';
  }

  @override
  String couldntSaveChanges(String message) {
    return 'Couldn\'t save changes: $message';
  }

  @override
  String get deleteContactTitle => 'Delete contact?';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldRole => 'Role';

  @override
  String get fieldPhone => 'Phone number';

  @override
  String get fieldEmail => 'Email';

  @override
  String get trustedPersonTitle => 'Trusted person';

  @override
  String get trustedPersonDescription => 'First contact in an emergency';

  @override
  String get shareSummariesTitle => 'Share my summaries';

  @override
  String get shareSummariesDescription => 'Allow sending check-ins';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get removeFromCareTeam => 'Remove from care team';

  @override
  String get actionCall => 'Call';

  @override
  String get actionMessage => 'Message';

  @override
  String get actionEmail => 'Email';

  @override
  String roleLabel(String role) {
    String _temp0 = intl.Intl.selectLogic(role, {
      'psychiatrist': 'Psychiatrist',
      'psychologist': 'Psychologist',
      'gp': 'GP',
      'friend': 'Friend',
      'family': 'Family',
      'other': '$role',
    });
    return '$_temp0';
  }

  @override
  String errorTrustedNumbers(String message) {
    return 'Error getting your trusted numbers: $message';
  }

  @override
  String get noTrustedPersonYet => 'No trusted person yet';

  @override
  String get chooseTrustedPerson =>
      'Choose someone from your care team to reach first in a hard moment';

  @override
  String get addFromCareTeam => 'Add someone from care team';

  @override
  String get emergencyTitle => 'EMERGENCY';

  @override
  String get emergencySubtitle => 'You don\'t have to face this alone';

  @override
  String get reachTrustedPerson => 'Reach your trusted person';

  @override
  String get orSendMessage => 'Or send a message';

  @override
  String get messageReadyToSend =>
      'Not sure what to say? This is ready to send';

  @override
  String get talkToSomeone => 'Talk to someone now';

  @override
  String get anErrorOccurred => 'An error has occurred';

  @override
  String get savedAsTrustedPerson => 'Contact saved as trusted person';

  @override
  String get chooseTrustedPersonTitle => 'Choose your trusted person';

  @override
  String get trustedPersonSubtitle =>
      'The one Breathe helps you reach first. You can change this anytime.';

  @override
  String get addNewContact => 'Add a new contact';

  @override
  String get setAsTrustedPerson => 'Set as trusted person';

  @override
  String get noContactsToChoose => 'You don\'t have any contacts yet';

  @override
  String get youAreNotAlone => 'You are not alone';

  @override
  String didntPickUp(String name) {
    return 'If $name didn\'t pick up — that\'s okay. Someone is ready to talk with you right now.';
  }

  @override
  String tryAgain(String name) {
    return 'Try $name again';
  }

  @override
  String callContact(String name) {
    return 'Call $name';
  }

  @override
  String get yourTrustedPerson => 'Your trusted person';

  @override
  String get presetMessage =>
      'Hi, I\'m going through a really hard moment and could use some support. Could you reach out when you\'re able to?';

  @override
  String get shareMyLocation => 'Share my location';

  @override
  String get myCurrentLocation => 'My current location:';

  @override
  String sendMessageTo(String name) {
    return 'Send message to $name';
  }
}
