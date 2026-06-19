import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'{partOfDay, select, morning{Good morning} afternoon{Good afternoon} evening{Good evening} other{Hello}}'**
  String greeting(String partOfDay);

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A safe place for your thoughts, feelings, and experiences. Write honestly, reflect gently, and be yourself.'**
  String get homeSubtitle;

  /// No description provided for @noRecentRecords.
  ///
  /// In en, this message translates to:
  /// **'No records in the last 7 days'**
  String get noRecentRecords;

  /// No description provided for @errorWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithDetails(String message);

  /// No description provided for @journalTitle.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journalTitle;

  /// No description provided for @journalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reflect on your journey'**
  String get journalSubtitle;

  /// No description provided for @dayLabel.
  ///
  /// In en, this message translates to:
  /// **'{when, select, today{Today} yesterday{Yesterday} earlier{Earlier} other{Earlier}}'**
  String dayLabel(String when);

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get checkInTitle;

  /// No description provided for @checkInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A gentle pause for yourself'**
  String get checkInSubtitle;

  /// No description provided for @checkInTitleLong.
  ///
  /// In en, this message translates to:
  /// **'How are you truly feeling?'**
  String get checkInTitleLong;

  /// No description provided for @checkInStorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Each entry helps tell the story of your journey'**
  String get checkInStorySubtitle;

  /// No description provided for @writeSomething.
  ///
  /// In en, this message translates to:
  /// **'Write something'**
  String get writeSomething;

  /// No description provided for @recentEntry.
  ///
  /// In en, this message translates to:
  /// **'Recent entry'**
  String get recentEntry;

  /// No description provided for @weeklyIndex.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY INDEX'**
  String get weeklyIndex;

  /// No description provided for @commonMood.
  ///
  /// In en, this message translates to:
  /// **'COMMON MOOD'**
  String get commonMood;

  /// No description provided for @moodLabel.
  ///
  /// In en, this message translates to:
  /// **'{mood, select, okay{Okay} good{Good} low{Low} other{{mood}}}'**
  String moodLabel(String mood);

  /// No description provided for @deleteEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get deleteEntryTitle;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Do you want to continue?'**
  String get actionCannotBeUndone;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @entryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted successfully'**
  String get entryDeleted;

  /// No description provided for @entryChanged.
  ///
  /// In en, this message translates to:
  /// **'Entry changed successfully'**
  String get entryChanged;

  /// No description provided for @feelingMood.
  ///
  /// In en, this message translates to:
  /// **'Feeling {mood}'**
  String feelingMood(String mood);

  /// No description provided for @onMyMind.
  ///
  /// In en, this message translates to:
  /// **'On my mind this day: '**
  String get onMyMind;

  /// No description provided for @entryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Entry not found'**
  String get entryNotFound;

  /// No description provided for @moodPickerLabel.
  ///
  /// In en, this message translates to:
  /// **'MOOD'**
  String get moodPickerLabel;

  /// No description provided for @problemsPickerLabel.
  ///
  /// In en, this message translates to:
  /// **'PROBLEMS'**
  String get problemsPickerLabel;

  /// No description provided for @couldntSaveEntry.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save your entry.'**
  String get couldntSaveEntry;

  /// No description provided for @problemLabel.
  ///
  /// In en, this message translates to:
  /// **'{problem, select, sleep{Sleep} work{Work} family{Family} health{Health} grief{Grief} finances{Finances} studies{Studies} other{Other}}'**
  String problemLabel(String problem);

  /// No description provided for @partOfDayLabel.
  ///
  /// In en, this message translates to:
  /// **'{part, select, morning{morning} afternoon{afternoon} evening{evening} other{day}}'**
  String partOfDayLabel(String part);

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @couldntLoadJourney.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your journey'**
  String get couldntLoadJourney;

  /// No description provided for @blankPageTitle.
  ///
  /// In en, this message translates to:
  /// **'A blank page, just for you'**
  String get blankPageTitle;

  /// No description provided for @blankPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Whenever it feels right, write a few words about your day. Only you will ever see them.'**
  String get blankPageSubtitle;

  /// No description provided for @writeFirstEntry.
  ///
  /// In en, this message translates to:
  /// **'Write your first entry'**
  String get writeFirstEntry;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// No description provided for @mostDays.
  ///
  /// In en, this message translates to:
  /// **'Most days'**
  String get mostDays;

  /// No description provided for @noMoodRecorded.
  ///
  /// In en, this message translates to:
  /// **'No mood recorded'**
  String get noMoodRecorded;

  /// No description provided for @daysLogged.
  ///
  /// In en, this message translates to:
  /// **'Days logged'**
  String get daysLogged;

  /// No description provided for @daysLoggedValue.
  ///
  /// In en, this message translates to:
  /// **'{count} of 7 days'**
  String daysLoggedValue(int count);

  /// No description provided for @whatWeighedMost.
  ///
  /// In en, this message translates to:
  /// **'WHAT WEIGHED MOST'**
  String get whatWeighedMost;

  /// No description provided for @yourNotes.
  ///
  /// In en, this message translates to:
  /// **'YOUR NOTES'**
  String get yourNotes;

  /// No description provided for @viewAllEntries.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{View 1 entry} other{View all {count} entries}}'**
  String viewAllEntries(int count);

  /// No description provided for @errorLoadingContacts.
  ///
  /// In en, this message translates to:
  /// **'Error loading your contacts: {message}'**
  String errorLoadingContacts(String message);

  /// No description provided for @yourPeopleTitle.
  ///
  /// In en, this message translates to:
  /// **'Your people, in one place'**
  String get yourPeopleTitle;

  /// No description provided for @yourPeopleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add the people who support you — a doctor, a therapist, a friend you trust.'**
  String get yourPeopleSubtitle;

  /// No description provided for @addSomeone.
  ///
  /// In en, this message translates to:
  /// **'Add someone'**
  String get addSomeone;

  /// No description provided for @trustedPersonHint.
  ///
  /// In en, this message translates to:
  /// **'One of them can be your trusted person — the one you reach first in a hard moment.'**
  String get trustedPersonHint;

  /// No description provided for @careTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Care Team'**
  String get careTeamTitle;

  /// No description provided for @careTeamSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your support network, all in one place'**
  String get careTeamSubtitle;

  /// No description provided for @createContact.
  ///
  /// In en, this message translates to:
  /// **'Create contact'**
  String get createContact;

  /// No description provided for @editContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit contact'**
  String get editContactTitle;

  /// No description provided for @contactCreated.
  ///
  /// In en, this message translates to:
  /// **'Contact created successfully'**
  String get contactCreated;

  /// No description provided for @contactChanged.
  ///
  /// In en, this message translates to:
  /// **'Contact changed successfully'**
  String get contactChanged;

  /// No description provided for @contactDeleted.
  ///
  /// In en, this message translates to:
  /// **'Contact deleted successfully'**
  String get contactDeleted;

  /// No description provided for @couldntSaveContact.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the contact: {message}'**
  String couldntSaveContact(String message);

  /// No description provided for @couldntSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save changes: {message}'**
  String couldntSaveChanges(String message);

  /// No description provided for @deleteContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete contact?'**
  String get deleteContactTitle;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get fieldRole;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get fieldPhone;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @trustedPersonTitle.
  ///
  /// In en, this message translates to:
  /// **'Trusted person'**
  String get trustedPersonTitle;

  /// No description provided for @trustedPersonDescription.
  ///
  /// In en, this message translates to:
  /// **'First contact in an emergency'**
  String get trustedPersonDescription;

  /// No description provided for @shareSummariesTitle.
  ///
  /// In en, this message translates to:
  /// **'Share my summaries'**
  String get shareSummariesTitle;

  /// No description provided for @shareSummariesDescription.
  ///
  /// In en, this message translates to:
  /// **'Allow sending check-ins'**
  String get shareSummariesDescription;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @removeFromCareTeam.
  ///
  /// In en, this message translates to:
  /// **'Remove from care team'**
  String get removeFromCareTeam;

  /// No description provided for @actionCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get actionCall;

  /// No description provided for @actionMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get actionMessage;

  /// No description provided for @actionEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get actionEmail;

  /// No description provided for @roleLabel.
  ///
  /// In en, this message translates to:
  /// **'{role, select, psychiatrist{Psychiatrist} psychologist{Psychologist} gp{GP} friend{Friend} family{Family} other{{role}}}'**
  String roleLabel(String role);

  /// No description provided for @errorTrustedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Error getting your trusted numbers: {message}'**
  String errorTrustedNumbers(String message);

  /// No description provided for @noTrustedPersonYet.
  ///
  /// In en, this message translates to:
  /// **'No trusted person yet'**
  String get noTrustedPersonYet;

  /// No description provided for @chooseTrustedPerson.
  ///
  /// In en, this message translates to:
  /// **'Choose someone from your care team to reach first in a hard moment'**
  String get chooseTrustedPerson;

  /// No description provided for @addFromCareTeam.
  ///
  /// In en, this message translates to:
  /// **'Add someone from care team'**
  String get addFromCareTeam;

  /// No description provided for @emergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY'**
  String get emergencyTitle;

  /// No description provided for @emergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to face this alone'**
  String get emergencySubtitle;

  /// No description provided for @reachTrustedPerson.
  ///
  /// In en, this message translates to:
  /// **'Reach your trusted person'**
  String get reachTrustedPerson;

  /// No description provided for @reachHelpLine.
  ///
  /// In en, this message translates to:
  /// **'Immediate support line'**
  String get reachHelpLine;

  /// No description provided for @orSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Or send a message'**
  String get orSendMessage;

  /// No description provided for @messageReadyToSend.
  ///
  /// In en, this message translates to:
  /// **'Not sure what to say? This is ready to send'**
  String get messageReadyToSend;

  /// No description provided for @talkToSomeone.
  ///
  /// In en, this message translates to:
  /// **'Talk to someone now'**
  String get talkToSomeone;

  /// No description provided for @anErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error has occurred'**
  String get anErrorOccurred;

  /// No description provided for @savedAsTrustedPerson.
  ///
  /// In en, this message translates to:
  /// **'Contact saved as trusted person'**
  String get savedAsTrustedPerson;

  /// No description provided for @chooseTrustedPersonTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your trusted person'**
  String get chooseTrustedPersonTitle;

  /// No description provided for @trustedPersonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The one Breathe helps you reach first. You can change this anytime.'**
  String get trustedPersonSubtitle;

  /// No description provided for @addNewContact.
  ///
  /// In en, this message translates to:
  /// **'Add a new contact'**
  String get addNewContact;

  /// No description provided for @setAsTrustedPerson.
  ///
  /// In en, this message translates to:
  /// **'Set as trusted person'**
  String get setAsTrustedPerson;

  /// No description provided for @noContactsToChoose.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any contacts yet'**
  String get noContactsToChoose;

  /// No description provided for @youAreNotAlone.
  ///
  /// In en, this message translates to:
  /// **'You are not alone'**
  String get youAreNotAlone;

  /// No description provided for @confSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Someone to talk to, anytime'**
  String get confSubtitle;

  /// No description provided for @yourTrustedPerson.
  ///
  /// In en, this message translates to:
  /// **'Suicide prevention line'**
  String get yourTrustedPerson;

  /// No description provided for @presetMessage.
  ///
  /// In en, this message translates to:
  /// **'Hi, I\'m going through a really hard moment and could use some support. Could you reach out when you\'re able to?'**
  String get presetMessage;

  /// No description provided for @shareMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Share my location'**
  String get shareMyLocation;

  /// No description provided for @myCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'My current location:'**
  String get myCurrentLocation;

  /// No description provided for @sendMessageTo.
  ///
  /// In en, this message translates to:
  /// **'Send message to'**
  String get sendMessageTo;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navJournal;

  /// No description provided for @navJourney.
  ///
  /// In en, this message translates to:
  /// **'Journey'**
  String get navJourney;

  /// No description provided for @navCareTeam.
  ///
  /// In en, this message translates to:
  /// **'Care Team'**
  String get navCareTeam;

  /// No description provided for @navEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get navEmergency;

  /// No description provided for @weeklySummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Summary'**
  String get weeklySummary;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessage;

  /// No description provided for @chooseRecipient.
  ///
  /// In en, this message translates to:
  /// **'Who do you want to reach?'**
  String get chooseRecipient;

  /// No description provided for @noContactsYet.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added anyone to your Care Team yet.'**
  String get noContactsYet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
