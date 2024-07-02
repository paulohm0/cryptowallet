import 'dart:ui';

import 'package:cryptowallet/repositories/coin_repository.dart';
import 'package:cryptowallet/repositories/translator_repository.dart';
import 'package:cryptowallet/view_models/coin_view_model.dart';
import 'package:cryptowallet/widgets/coin_graph.dart';
import 'package:cryptowallet/widgets/market_crypto_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

import '../models/coin_model.dart';
import '../models/graph_database_model.dart';
import '../repositories/graph_repository.dart';
import '../widgets/custom_app_bar.dart';

class MarketPlace extends StatefulWidget {
  final CoinViewModel coinViewModel;

  const MarketPlace({
    super.key,
    required this.coinViewModel,
  });

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final CoinRepository coinRepository = CoinRepository(dio: Dio());
  final GraphRepository graphRepository = GraphRepository(dio: Dio());
  List<GraphDatabase> graph = [];
  List<CoinModel> coins = [];
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final List<int> selectedIndices = [];
  final translator = GoogleTranslator();
  final TranslatorRepository translatorRepository =
      TranslatorRepository(translator: GoogleTranslator());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initScreen();
    });
  }

  Future<void> initScreen() async {
    widget.coinViewModel.changeLoading();
    coins = await coinRepository.getCoin();
    widget.coinViewModel.changeLoading();
    graph = await graphRepository.getGraph();
  }

  /// limpar selecao de moedas no mercado
  void clearSelection() {
    setState(() {
      selectedIndices.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clearSelection();
      },
      child: ListenableBuilder(
        listenable: widget.coinViewModel,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                title: widget.coinViewModel.isSelected ? 'Detalhes' : 'Mercado',
                actions: widget.coinViewModel.isSelected
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.coinViewModel.isSelected = false;
                          });
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            body: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async => await initScreen(),
                child: widget.coinViewModel.isLoading
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 400),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    : SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              //  Flexible deve ocupar o menor espaço necessário dentro da Column
                              child: !widget.coinViewModel.isSelected
                                  ? MarketCryptoList(
                                      selectedIndices: selectedIndices,
                                      formatCurrency: formatCurrency,
                                      coinRepository: coinRepository,
                                      coins: coins,
                                      coinViewModel: widget.coinViewModel,
                                    )
                                  : Container(
                                      padding: const EdgeInsets.only(
                                          left: 24, right: 24, top: 16),
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              coins[widget.coinViewModel
                                                      .indexToAcessDetails]
                                                  .name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(
                                              coins[widget.coinViewModel
                                                      .indexToAcessDetails]
                                                  .symbol,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(
                                              formatCurrency.format(
                                                double.tryParse(
                                                  coins[widget.coinViewModel
                                                              .indexToAcessDetails]
                                                          .latestPrice
                                                          ?.amount
                                                          ?.amount ??
                                                      '',
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                            TextButton(
                                              child: const Text(
                                                'Descrição',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return BackdropFilter(
                                                      // widget para deixar o fundo do alertDialog com blur
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 5.0,
                                                          sigmaY: 5.0),
                                                      child: AlertDialog(
                                                        backgroundColor:
                                                            Colors.white10,
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              FutureBuilder(
                                                                future:
                                                                    translatorRepository
                                                                        .translate(
                                                                  coins[widget.coinViewModel
                                                                              .indexToAcessDetails]
                                                                          .description ??
                                                                      '',
                                                                  from: 'en',
                                                                  to: 'pt',
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .connectionState !=
                                                                      ConnectionState
                                                                          .done) {
                                                                    return const CircularProgressIndicator(
                                                                      color: Colors
                                                                          .yellowAccent,
                                                                    );
                                                                  }
                                                                  return Text(
                                                                    snapshot.data ??
                                                                        'Sem Descrição',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            MarketplaceGraph(
                                              graph: graph,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
