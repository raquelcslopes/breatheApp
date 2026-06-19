// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String greeting(String partOfDay) {
    String _temp0 = intl.Intl.selectLogic(partOfDay, {
      'morning': 'Bom dia',
      'afternoon': 'Boa tarde',
      'evening': 'Boa noite',
      'other': 'Olá',
    });
    return '$_temp0';
  }

  @override
  String get homeSubtitle =>
      'Um espaço seguro para os teus pensamentos, sentimentos e experiências. Escreve com honestidade, reflete com calma, e sê quem és.';

  @override
  String get noRecentRecords => 'Sem registos nos últimos 7 dias';

  @override
  String errorWithDetails(String message) {
    return 'Erro: $message';
  }

  @override
  String get journalTitle => 'Diário';

  @override
  String get journalSubtitle => 'Reflete sobre o teu percurso';

  @override
  String dayLabel(String when) {
    String _temp0 = intl.Intl.selectLogic(when, {
      'today': 'Hoje',
      'yesterday': 'Ontem',
      'earlier': 'Anteriores',
      'other': 'Anteriores',
    });
    return '$_temp0';
  }

  @override
  String get checkInTitle => 'Como te sentes?';

  @override
  String get checkInSubtitle => 'Uma pausa suave para ti';

  @override
  String get checkInTitleLong => 'Como te sentes verdadeiramente?';

  @override
  String get checkInStorySubtitle =>
      'Cada entrada ajuda a contar a história do teu percurso';

  @override
  String get writeSomething => 'Escrever algo';

  @override
  String get recentEntry => 'Entrada recente';

  @override
  String get weeklyIndex => 'ÍNDICE SEMANAL';

  @override
  String get commonMood => 'HUMOR FREQUENTE';

  @override
  String moodLabel(String mood) {
    String _temp0 = intl.Intl.selectLogic(mood, {
      'okay': 'Razoável',
      'good': 'Bem',
      'low': 'Em baixo',
      'other': '$mood',
    });
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Eliminar entrada?';

  @override
  String get actionCannotBeUndone =>
      'Esta ação não pode ser anulada. Queres continuar?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get save => 'Guardar';

  @override
  String get entryDeleted => 'Entrada eliminada com sucesso';

  @override
  String get entryChanged => 'Entrada alterada com sucesso';

  @override
  String feelingMood(String mood) {
    return '$mood';
  }

  @override
  String get onMyMind => 'No que pensei neste dia: ';

  @override
  String get entryNotFound => 'Entrada não encontrada';

  @override
  String get moodPickerLabel => 'HUMOR';

  @override
  String get problemsPickerLabel => 'FATORES';

  @override
  String get couldntSaveEntry => 'Não foi possível guardar a tua entrada.';

  @override
  String problemLabel(String problem) {
    String _temp0 = intl.Intl.selectLogic(problem, {
      'sleep': 'Sono',
      'work': 'Trabalho',
      'family': 'Família',
      'health': 'Saúde',
      'grief': 'Luto',
      'finances': 'Finanças',
      'studies': 'Estudos',
      'other': 'Outro',
    });
    return '$_temp0';
  }

  @override
  String partOfDayLabel(String part) {
    String _temp0 = intl.Intl.selectLogic(part, {
      'morning': 'manhã',
      'afternoon': 'tarde',
      'evening': 'noite',
      'other': 'dia',
    });
    return '$_temp0';
  }

  @override
  String get confirm => 'Confirmar';

  @override
  String get couldntLoadJourney => 'Não foi possível carregar o teu percurso';

  @override
  String get blankPageTitle => 'Uma página em branco, só para ti';

  @override
  String get blankPageSubtitle =>
      'Sempre que te fizer sentido, escreve umas palavras sobre o teu dia. Só tu as verás.';

  @override
  String get writeFirstEntry => 'Escreve a tua primeira entrada';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get mostDays => 'Na maioria dos dias';

  @override
  String get noMoodRecorded => 'Sem humor registado';

  @override
  String get daysLogged => 'Dias registados';

  @override
  String daysLoggedValue(int count) {
    return '$count de 7 dias';
  }

  @override
  String get whatWeighedMost => 'O QUE MAIS PESOU';

  @override
  String get yourNotes => 'AS TUAS NOTAS';

  @override
  String viewAllEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ver todas as $count entradas',
      one: 'Ver 1 entrada',
    );
    return '$_temp0';
  }

  @override
  String errorLoadingContacts(String message) {
    return 'Erro ao carregar os teus contactos: $message';
  }

  @override
  String get yourPeopleTitle => 'As tuas pessoas, num só lugar';

  @override
  String get yourPeopleSubtitle =>
      'Adiciona quem te apoia — um médico, um terapeuta, um amigo em quem confias.';

  @override
  String get addSomeone => 'Adicionar alguém';

  @override
  String get trustedPersonHint =>
      'Uma delas pode ser a tua pessoa de confiança — aquela a quem recorres primeiro num momento difícil.';

  @override
  String get careTeamTitle => 'Equipa de Apoio';

  @override
  String get careTeamSubtitle => 'A tua rede de apoio, toda num só lugar';

  @override
  String get createContact => 'Criar contacto';

  @override
  String get editContactTitle => 'Editar contacto';

  @override
  String get contactCreated => 'Contacto criado com sucesso';

  @override
  String get contactChanged => 'Contacto alterado com sucesso';

  @override
  String get contactDeleted => 'Contacto eliminado com sucesso';

  @override
  String couldntSaveContact(String message) {
    return 'Não foi possível guardar o contacto: $message';
  }

  @override
  String couldntSaveChanges(String message) {
    return 'Não foi possível guardar as alterações: $message';
  }

  @override
  String get deleteContactTitle => 'Eliminar contacto?';

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldRole => 'Função';

  @override
  String get fieldPhone => 'Número de telefone';

  @override
  String get fieldEmail => 'Email';

  @override
  String get trustedPersonTitle => 'Pessoa de confiança';

  @override
  String get trustedPersonDescription => 'Primeiro contacto numa emergência';

  @override
  String get shareSummariesTitle => 'Partilhar os meus resumos';

  @override
  String get shareSummariesDescription => 'Permitir o envio de check-ins';

  @override
  String get saveChanges => 'Guardar alterações';

  @override
  String get removeFromCareTeam => 'Remover da equipa de apoio';

  @override
  String get actionCall => 'Ligar';

  @override
  String get actionMessage => 'Mensagem';

  @override
  String get actionEmail => 'Email';

  @override
  String roleLabel(String role) {
    String _temp0 = intl.Intl.selectLogic(role, {
      'psychiatrist': 'Psiquiatra',
      'psychologist': 'Psicólogo',
      'gp': 'Médico de família',
      'friend': 'Amigo',
      'family': 'Família',
      'other': '$role',
    });
    return '$_temp0';
  }

  @override
  String errorTrustedNumbers(String message) {
    return 'Erro ao obter os teus contactos de confiança: $message';
  }

  @override
  String get noTrustedPersonYet => 'Ainda não tens uma pessoa de confiança';

  @override
  String get chooseTrustedPerson =>
      'Escolhe alguém da tua equipa de apoio para contactares primeiro num momento difícil';

  @override
  String get addFromCareTeam => 'Adicionar alguém da equipa de apoio';

  @override
  String get emergencyTitle => 'EMERGÊNCIA';

  @override
  String get emergencySubtitle => 'Não tens de enfrentar isto sozinho';

  @override
  String get reachTrustedPerson => 'Contacta a tua pessoa de confiança';

  @override
  String get reachHelpLine => 'Immediate support line';

  @override
  String get orSendMessage => 'Ou envia uma mensagem';

  @override
  String get messageReadyToSend =>
      'Não sabes o que dizer? Esta mensagem está pronta a enviar';

  @override
  String get talkToSomeone => 'Fala com alguém agora';

  @override
  String get anErrorOccurred => 'Ocorreu um erro';

  @override
  String get savedAsTrustedPerson =>
      'Contacto guardado como pessoa de confiança';

  @override
  String get chooseTrustedPersonTitle => 'Escolhe a tua pessoa de confiança';

  @override
  String get trustedPersonSubtitle =>
      'Aquela que o Breathe te ajuda a contactar primeiro. Podes mudar quando quiseres.';

  @override
  String get addNewContact => 'Adicionar um novo contacto';

  @override
  String get setAsTrustedPerson => 'Definir como pessoa de confiança';

  @override
  String get noContactsToChoose => 'Ainda não tens contactos';

  @override
  String get youAreNotAlone => 'Não estás sozinha';

  @override
  String get confSubtitle => 'Alguém com quem falar, a qualquer hora';

  @override
  String get yourTrustedPerson => 'Linha de prevenção do suicídio';

  @override
  String get presetMessage =>
      'Olá, estou a passar por um momento muito difícil e bem que precisava de apoio. Podes contactar-me quando puderes?';

  @override
  String get shareMyLocation => 'Partilhar a minha localização';

  @override
  String get myCurrentLocation => 'A minha localização atual:';

  @override
  String get sendMessageTo => 'Enviar mensagem a';

  @override
  String get navHome => 'Início';

  @override
  String get navJournal => 'Diário';

  @override
  String get navJourney => 'Percurso';

  @override
  String get navCareTeam => 'Equipa';

  @override
  String get navEmergency => 'Emergência';

  @override
  String get weeklySummary => 'Sumário da Semana';

  @override
  String get sendMessage => 'Enviar mensagem';

  @override
  String get chooseRecipient => 'A quem queres enviar?';

  @override
  String get noContactsYet => 'Ainda não adicionaste ninguém à tua Care Team.';
}
