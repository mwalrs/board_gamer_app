enum Cuisine {
  italian('italian', 'Italienisch', '🍕'),
  asian('asian', 'Asiatisch', '🥢'),
  sushi('sushi', 'Sushi', '🍣'),
  burger('burger', 'Burger & Pommes', '🍔'),
  doener('doener', 'Döner / Türkisch', '🥙'),
  indian('indian', 'Indisch', '🍛'),
  greek('greek', 'Griechisch', '🥗');

  final String key;
  final String displayName;
  final String icon;

  const Cuisine(this.key, this.displayName, this.icon);
  
  // translate Firestore String to matching enum
  // no case sensitive, fallback for unknown values = italian
  static Cuisine fromKey(String? key) {
    if (key == null) return Cuisine.italian;
    return Cuisine.values.firstWhere(
          (c) => c.key.toLowerCase() == key.toLowerCase(),
      orElse: () => Cuisine.italian,
    );
  }
}