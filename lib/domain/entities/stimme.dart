class Stimme {
  final String id;
  final String terminId;
  final String spielvorschlagId;
  final String abgegebenVon;
  final bool istAutomatisch;    //"true" bei der automatischen Stimme beim Vorschlagen (US3), "false" bei der normalen Stimme in Abstimmung

  const Stimme({
    required this.id,
    required this.terminId,
    required this.spielvorschlagId,
    required this.abgegebenVon,
    required this.istAutomatisch,
  });
}