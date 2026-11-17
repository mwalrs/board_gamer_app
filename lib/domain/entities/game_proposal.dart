class GameProposal {
  final String id;
  final String name;
  final String suggestedBy;
  final List<String> voterIds;
  final DateTime createdAt;

  const GameProposal({
    required this.id,
    required this.name,
    required this.suggestedBy,
    required this.voterIds,
    required this.createdAt,
  });
}


//Regeln(max. 2 Vorschlaege, kein leerer Name, Duplikate kommen spaeter ins Repo