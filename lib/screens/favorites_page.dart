import 'package:flutter/material.dart';

import '../view_models/coin_view_model.dart';
import '../widgets/custom_app_bar.dart';

class FavoritesPage extends StatefulWidget {
  final CoinViewModel coinViewModel;

  const FavoritesPage({
    super.key,
    required this.coinViewModel,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favoritos',
      ),
      body: Container(),
    );
  }
}
