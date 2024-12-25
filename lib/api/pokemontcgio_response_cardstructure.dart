class PokemonTCGIOResponseCardStructure {
  String? id;
  String? name;
  String? supertype;
  List<String>? subtypes;
  String? hp;
  List<String>? types;
  String? evolvesFrom;
  List<Map<String, dynamic>>? attacks;
  List<Map<String, dynamic>>? weaknesses;
  List<Map<String, dynamic>>? resistances;
  List<String>? retreatCost;
  int? convertedRetreatCost;
  Map<String, dynamic>? set;
  String? number;
  String? artist;
  String? rarity;
  String? flavorText;
  List<int>? nationalPokedexNumbers;
  Map<String, dynamic>? legalities;
  Map<String, dynamic>? images;
  Map<String, dynamic>? tcgplayer;
  Map<String, dynamic>? cardmarket;

  PokemonTCGIOResponseCardStructure(Map<String, dynamic> rawResponse) {
    id = rawResponse['id'];
    name = rawResponse['name'];
    supertype = rawResponse['supertype'];
    subtypes = rawResponse['subtypes']?.cast<String>();
    hp = rawResponse['hp'];
    types = rawResponse['types']?.cast<String>();
    evolvesFrom = rawResponse['evolvesFrom'];
    attacks = rawResponse['attacks']?.cast<Map<String, dynamic>>();
    weaknesses = rawResponse['weaknesses']?.cast<Map<String, dynamic>>();
    resistances = rawResponse['resistances']?.cast<Map<String, dynamic>>();
    retreatCost = rawResponse['retreatCost']?.cast<String>();
    convertedRetreatCost = rawResponse['convertedRetreatCost'];
    set = rawResponse['set'];
    number = rawResponse['number'];
    artist = rawResponse['artist'];
    rarity = rawResponse['rarity'];
    flavorText = rawResponse['flavorText'];
    nationalPokedexNumbers = rawResponse['nationalPokedexNumbers']?.cast<int>();
    legalities = rawResponse['legalities'];
    images = rawResponse['images'];
    tcgplayer = rawResponse['tcgplayer'];
    cardmarket = rawResponse['cardmarket'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'supertype': supertype,
      'subtypes': subtypes,
      'hp': hp,
      'types': types,
      'evolvesFrom': evolvesFrom,
      'attacks': attacks,
      'weaknesses': weaknesses,
      'resistances': resistances,
      'retreatCost': retreatCost,
      'convertedRetreatCost': convertedRetreatCost,
      'set': set,
      'number': number,
      'artist': artist,
      'rarity': rarity,
      'flavorText': flavorText,
      'nationalPokedexNumbers': nationalPokedexNumbers,
      'legalities': legalities,
      'images': images,
      'tcgplayer': tcgplayer,
      'cardmarket': cardmarket,
    };
  }
}

