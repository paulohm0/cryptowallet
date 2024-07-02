import 'package:cryptowallet/view_models/coin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  final String name;
  final double currentBalance;
  final NumberFormat formatCurrency;
  final int percent;
  final CoinViewModel coinViewModel;

  const HomeWidget({
    super.key,
    required this.name,
    required this.currentBalance,
    required this.formatCurrency,
    required this.percent,
    required this.coinViewModel,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 50),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/imageprofile.png'),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Olá ${widget.name}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 15, bottom: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF252629).withOpacity(.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saldo Atual',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    ListenableBuilder(
                        listenable: widget.coinViewModel,
                        builder: (context, child) {
                          return Row(
                            children: [
                              Expanded(
                                child: AnimatedOpacity(
                                  opacity:
                                      widget.coinViewModel.isHidden ? 0.0 : 1.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: widget.coinViewModel.isHidden
                                      ? const SizedBox.shrink()
                                      : Row(
                                          children: [
                                            Text(
                                              widget.formatCurrency.format(
                                                  widget.currentBalance),
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.yellowAccent,
                                              size: 16,
                                            ),
                                            Text(
                                              '${widget.percent}%',
                                              style: const TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              Transform.scale(
                                scale: 0.6,
                                child: IconButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    icon: Icon(
                                      widget.coinViewModel.isHidden
                                          ? Icons.visibility_off
                                          : Icons.remove_red_eye_rounded,
                                      color: widget.coinViewModel.isHidden
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                    iconSize: 45,
                                    onPressed: () {
                                      widget.coinViewModel.changeVisibility();
                                    }),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 173,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    widget.coinViewModel.setCurrentIndex(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellowAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Depositar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 45,
                width: 173,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Sacar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              top: 5,
              right: 16,
            ),
            child: Row(
              children: [
                const Text(
                  'Seu Portifólio',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.coinViewModel.setCurrentIndex(2);
                  },
                  child: const Text(
                    'Mercado',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            height: 450,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  width: 200,
                  height: 90,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF252629).withOpacity(.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
