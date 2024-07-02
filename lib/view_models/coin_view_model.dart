import 'package:flutter/material.dart';

class CoinViewModel extends ChangeNotifier {
  // gerenciador de estado
  int currentIndex = 0;
  int indexToAcessDetails = 0;
  bool isHidden = false;
  bool isLoading = false;
  bool isSelected = false;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void setCurrentIndexDetails(int index) {
    indexToAcessDetails = index;
    notifyListeners();
  }

  /// mudar visibilidade do saldo na home
  void changeVisibility() {
    isHidden = !isHidden;
    notifyListeners();
  }

  /// ao dar refresh no mercado, sempre mostrar o CircularProgressIndicator
  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSelected() {
    isSelected = !isSelected;
    notifyListeners();
  }
}
