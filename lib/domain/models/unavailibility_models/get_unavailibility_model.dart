class GetOverrideModel {
  DataModel? data;

  GetOverrideModel({this.data});

  GetOverrideModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataModel {
  final Allots allots;
  final Blocks blocks;
  final bool isFullDayBlocked;
  final String date;

  DataModel({required this.allots, required this.blocks, required this.isFullDayBlocked, required this.date});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      allots: Allots.fromJson(json['allots']),
      blocks: Blocks.fromJson(json['blocks']),
      isFullDayBlocked: json['isFullDayBlocked'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allots': allots.toJson(),
      'blocks': blocks.toJson(),
      'isFullDayBlocked': isFullDayBlocked,
      'date': date,
    };
  }
}

class Allots {
  final Map<String, List<int>> allotMap;

  Allots({required this.allotMap});

  factory Allots.fromJson(Map<String, dynamic> json) {
    Map<String, List<int>> tempMap = {};
    json.forEach((key, value) {
      tempMap[key] = List<int>.from(value);
    });
    return Allots(allotMap: tempMap);
  }

  Map<String, dynamic> toJson() {
    return allotMap.map((key, value) => MapEntry(key, value));
  }
}

class Blocks {
  final Map<String, List<int>> blockMap;

  Blocks({required this.blockMap});

  factory Blocks.fromJson(Map<String, dynamic> json) {
    Map<String, List<int>> tempMap = {};
    json.forEach((key, value) {
      tempMap[key] = List<int>.from(value);
    });
    return Blocks(blockMap: tempMap);
  }

  Map<String, dynamic> toJson() {
    return blockMap.map((key, value) => MapEntry(key, value));
  }
}
