class CurrentPriceModel {
  Time? time;
  String? disclaimer;
  String? chartName;
  Bpi? bpi;

  CurrentPriceModel({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  factory CurrentPriceModel.fromJson(Map<String, dynamic> json) {
    return CurrentPriceModel(
      time: json['time'] != null ? Time.fromJson(json['time']) : Time(),
      disclaimer: json['disclaimer'],
      chartName: json['chartName'],
      bpi: json['bpi'] != null ? Bpi.fromJson(json['bpi']) : Bpi(),
    );
  }

  Map<String, dynamic> toJson() => {
        "time": time?.toJson(),
        "disclaimer": disclaimer,
        "chartName": chartName,
        "bpi": bpi?.toJson(),
      };
}

class Bpi {
  Country? usd;
  Country? gbp;
  Country? eur;

  Bpi({
    this.usd,
    this.gbp,
    this.eur,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) {
    return Bpi(
      usd: json['USD'] != null ? Country.fromJson(json['USD']) : Country(),
      gbp: json['GBP'] != null ? Country.fromJson(json['GBP']) : Country(),
      eur: json['EUR'] != null ? Country.fromJson(json['EUR']) : Country(),
    );
  }

  Map<String, dynamic> toJson() => {
        "USD": usd?.toJson(),
        "GBP": gbp?.toJson(),
        "EUR": eur?.toJson(),
      };
}

class Country {
  String? code;
  String? symbol;
  String? rate;
  String? description;
  double? rateFloat;

  Country({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      symbol: json['symbol'],
      rate: json['rate'],
      description: json['description'],
      rateFloat: json['rate_float'],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "description": description,
        "rate_float": rateFloat,
      };
}

class Time {
  String? updated;
  String? updatedIso;
  String? updateduk;

  Time({
    this.updated,
    this.updatedIso,
    this.updateduk,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      updated: json['updated'],
      updatedIso: json['updatedISO'],
      updateduk: json['updateduk'],
    );
  }

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "updatedISO": updatedIso,
        "updateduk": updateduk,
      };
}

class HistoryModel {
  List<CurrentPriceModel>? list;

  HistoryModel({this.list});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      list: List<CurrentPriceModel>.from(
          json["historyPrice"].map((x) => HistoryModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "historyPrice": List<CurrentPriceModel>.from(list!.map((x) => x.toJson())),
      };
}
