class GraphDatabase {
  final String? base;
  final String? baseId;
  final int? unitPriceScale;
  final String? currency;
  final Prices? prices;

  GraphDatabase({
    required this.base,
    required this.baseId,
    required this.unitPriceScale,
    required this.currency,
    required this.prices,
  });

  factory GraphDatabase.fromJson(Map<String, dynamic> json) {
    return GraphDatabase(
      base: json['base'],
      baseId: json['base_id'],
      unitPriceScale: json['unit_price_scale'],
      currency: json['currency'],
      prices: json['prices'] == null ? null : Prices.fromJson(json["prices"]),
    );
  }
}

class Prices {
  final String? latest;
  final LatestPrice? latestPrice;

  Prices({
    required this.latest,
    required this.latestPrice,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      latest: json['latest'],
      latestPrice: json["latest_price"] == null
          ? null
          : LatestPrice.fromJson(json["latest_price"]),
    );
  }
}

class LatestPrice {
  final Amount? amount;
  final String? timestamp;
  final PercentChange? percentChange;

  LatestPrice({
    required this.amount,
    required this.timestamp,
    required this.percentChange,
  });

  factory LatestPrice.fromJson(Map<String, dynamic> json) {
    return LatestPrice(
      amount: json['amount'] == null ? null : Amount.fromJson(json["amount"]),
      timestamp: json['timestamp'],
      percentChange: json['percent_change'] == null
          ? null
          : PercentChange.fromJson(json["percent_change"]),
    );
  }
}

class Amount {
  final String? amount;
  final String? currency;
  final String? scale;

  Amount({
    required this.amount,
    required this.currency,
    required this.scale,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      amount: json['amount'],
      currency: json['currency'],
      scale: json['scale'],
    );
  }
}

class PercentChange {
  final double? hour;
  final double? day;
  final double? week;
  final double? month;
  final double? year;
  final double? all;

  PercentChange({
    required this.hour,
    required this.day,
    required this.week,
    required this.month,
    required this.year,
    required this.all,
  });

  factory PercentChange.fromJson(Map<String, dynamic> json) {
    return PercentChange(
      hour: json['hour'],
      day: json['day'],
      week: json['week'],
      month: json['month'],
      year: json['year'],
      all: json['all'],
    );
  }
}
