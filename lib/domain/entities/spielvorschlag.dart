class Spielvorschlag {
  final String id;
  final String terminId;
  final String spielName;
  final String vorgeschlagenVon;

  const Spielvorschlag({
    required this.id,
    required this.terminId,
    required this.spielName,
    required this.vorgeschlagenVon,
  });
}


//Regeln(max. 2 Vorschlaege, kein leerer Name, Duplikate kommen spaeter ins Repo