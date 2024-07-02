import 'package:cryptowallet/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/coin_model.dart';
import '../view_models/coin_view_model.dart';

class MarketCryptoList extends StatefulWidget {
  final List<int> selectedIndices;
  final NumberFormat formatCurrency;
  final List<CoinModel> coins;
  final CoinRepository coinRepository;
  final CoinViewModel coinViewModel;

  const MarketCryptoList({
    super.key,
    required this.selectedIndices,
    required this.formatCurrency,
    required this.coinRepository,
    required this.coins,
    required this.coinViewModel,
  });

  @override
  State<MarketCryptoList> createState() => _MarketCryptoListState();
}

class _MarketCryptoListState extends State<MarketCryptoList> {
  /// armazenar as moedas selecionadas no mercado
  void toggleSelection(int index) {
    setState(() {
      if (widget.selectedIndices.contains(index)) {
        widget.selectedIndices.remove(index);
      } else {
        widget.selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 810,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.coins.length,
            itemBuilder: (context, index) {
              final coin = widget.coins[index];
              final isSelected = widget.selectedIndices.contains(index);
              return GestureDetector(
                onTap: () {
                  widget.coinViewModel.changeSelected();
                  widget.coinViewModel.setCurrentIndexDetails(index);
                },
                onLongPress: () {
                  toggleSelection(index);
                },
                child: Container(
                  margin: const EdgeInsets.all(1),
                  width: 200,
                  height: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          coin.imageUrl.isEmpty
                              ? const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                )
                              : Image.network(
                                  coin.imageUrl,
                                  height: 40,
                                  width: 40,
                                ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coin.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                coin.symbol,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.formatCurrency.format(double.tryParse(
                                coin.latestPrice?.amount?.amount ?? '')),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              Icon(
                                size: 15,
                                coin.percentChange < 0
                                    ? Icons.arrow_downward_sharp
                                    : Icons.arrow_upward,
                                color: coin.percentChange < 0
                                    ? Colors.red.withOpacity(.8)
                                    : Colors.green.withOpacity(.8),
                              ),
                              Text(
                                '${(coin.percentChange * 100).toStringAsFixed(4)}%',
                                style: const TextStyle(color: Colors.white38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
