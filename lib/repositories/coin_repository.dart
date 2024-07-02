import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/coin_model.dart';

class CoinRepository {
  final Dio dio;

  CoinRepository({
    required this.dio,
  });

  Future<List<CoinModel>> getCoin() async {
    try {
      final apiResponse =
          await dio.get("https://api.coinbase.com/v2/assets/search?base=BRL");
      return List.from(apiResponse.data["data"])
          .map(
            (coin) => CoinModel.fromJson(coin),
          )
          .toList();
    } catch (error, st) {
      log(
        "Um erro ocorreu ao tentar buscar a Coinbase",
        error: error,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
