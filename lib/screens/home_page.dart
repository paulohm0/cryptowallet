import 'package:cryptowallet/screens/favorites_page.dart';
import 'package:cryptowallet/screens/marketplace.dart';
import 'package:cryptowallet/view_models/coin_view_model.dart';
import 'package:cryptowallet/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final String name = 'Rafael';
  final int percent = 10;
  final double currentBalance = 84566.48;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final coinViewModel = CoinViewModel();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: coinViewModel,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    // ele vai acessar de acordo com o index um child por vez
                    index: coinViewModel.currentIndex,
                    children: [
                      // cada child do IndexedStack() representa um indice para o coinViewModel
                      HomeWidget(
                        // index = 0
                        name: name,
                        currentBalance: currentBalance,
                        formatCurrency: formatCurrency,
                        percent: percent,
                        coinViewModel: coinViewModel,
                      ),
                      FavoritesPage(
                        coinViewModel: coinViewModel,
                      ), // index = 1
                      MarketPlace(
                        coinViewModel: coinViewModel,
                      ), // index = 2
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: coinViewModel.currentIndex,
            onTap: coinViewModel.setCurrentIndex,
          ),
        );
      },
    );
  }
}
