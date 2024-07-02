import 'dart:developer';

import 'package:cryptowallet/models/graph_database_model.dart';
import 'package:dio/dio.dart';

class GraphRepository {
  final Dio dio;

  GraphRepository({
    required this.dio,
  });

  Future<List<GraphDatabase>> getGraph() async {
    try {
      final apiResponse =
          await dio.get("https://api.coinbase.com/v2/assets/prices/?base=BRL");
      return List.from(apiResponse.data["data"])
          .map(
            (graph) => GraphDatabase.fromJson(graph),
          )
          .toList();
    } catch (error, st) {
      log(
        "Um erro ocorreu ao tentar buscar os dados do Gráfico",
        error: error,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
