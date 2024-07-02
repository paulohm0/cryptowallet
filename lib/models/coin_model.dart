class CoinModel {
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.slug,
    required this.color,
    required this.imageUrl,
    required this.listed,
    required this.description,
    required this.exponent,
    required this.unitPriceScale,
    required this.transactionUnitPriceScale,
    required this.addressRegex,
    required this.resourceUrls,
    required this.base,
    required this.currency,
    required this.rank,
    required this.marketCap,
    required this.percentChange,
    required this.launchedAt,
    required this.latest,
    required this.latestPrice,
    required this.circulatingSupply,
    required this.volume24H,
  });

  final String? id;
  final String symbol;
  final String name;
  final String? slug;
  final String? color;
  final String imageUrl;
  final bool? listed;
  final String? description;
  final int? exponent;
  final int? unitPriceScale;
  final int? transactionUnitPriceScale;
  final String? addressRegex;
  final List<ResourceUrl> resourceUrls;
  final String? base;
  final String? currency;
  final int? rank;
  final String? marketCap;
  final double percentChange;
  final String? launchedAt;
  final String? latest;
  final LatestPrice? latestPrice;
  final String? circulatingSupply;
  final String? volume24H;

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json["id"],
      symbol: json["symbol"] ?? '-',
      name: json["name"] ?? '-',
      slug: json["slug"],
      color: json["color"],
      imageUrl: json["image_url"] ?? '',
      listed: json["listed"],
      description: json["description"] ?? 'Cripto Sem Descrição',
      exponent: json["exponent"],
      unitPriceScale: json["unit_price_scale"],
      transactionUnitPriceScale: json["transaction_unit_price_scale"],
      addressRegex: json["address_regex"],
      resourceUrls: json["resource_urls"] == null
          ? []
          : List<ResourceUrl>.from(json["resource_urls"]
              .map((resource) => ResourceUrl.fromJson(resource))),
      base: json["base"],
      currency: json["currency"],
      rank: json["rank"],
      marketCap: json["market_cap"],
      percentChange: json["percent_change"] ?? 0.0,
      launchedAt: json["launched_at"],
      latest: json["latest"],
      latestPrice: json["latest_price"] == null
          ? null
          : LatestPrice.fromJson(json["latest_price"]),
      circulatingSupply: json["circulating_supply"],
      volume24H: json["volume_24h"],
    );
  }
}

/// Detalha o preço mais recente e a variação percentual recente da moeda.
class LatestPrice {
  final Amount? amount;
  final DateTime? timestamp;
  final PercentChange? percentChange;

  LatestPrice({
    required this.amount,
    required this.timestamp,
    required this.percentChange,
  });

  factory LatestPrice.fromJson(Map<String, dynamic> json) {
    return LatestPrice(
      amount: json["amount"] == null ? null : Amount.fromJson(json["amount"]),
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
      percentChange: json["percent_change"] == null
          ? null
          : PercentChange.fromJson(json["percent_change"]),
    );
  }
}

/// Detalha um valor monetário específico.
class Amount {
  final String amount;
  final String? currency;
  final String? scale;

  Amount({
    required this.amount,
    required this.currency,
    required this.scale,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      amount: json["amount"] ?? '',
      currency: json["currency"],
      scale: json["scale"],
    );
  }
}

/// Descreve as variações percentuais do preço da moeda em vários períodos.
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
      hour: (json["hour"] as num?)?.toDouble(),
      day: (json["day"] as num?)?.toDouble(),
      week: (json["week"] as num?)?.toDouble(),
      month: (json["month"] as num?)?.toDouble(),
      year: (json["year"] as num?)?.toDouble(),
      all: (json["all"] as num?)?.toDouble(),
    );
  }
}

/// Armazena informações sobre URLs de recursos relacionados à moeda.
class ResourceUrl {
  final String? type;
  final String? iconUrl;
  final String? title;
  final String? link;

  ResourceUrl({
    required this.type,
    required this.iconUrl,
    required this.title,
    required this.link,
  });

  factory ResourceUrl.fromJson(Map<String, dynamic> json) {
    return ResourceUrl(
      type: json["type"],
      iconUrl: json["icon_url"],
      title: json["title"],
      link: json["link"],
    );
  }
}
