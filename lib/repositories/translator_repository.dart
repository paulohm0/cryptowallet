import 'package:translator/translator.dart';

class TranslatorRepository {
  final GoogleTranslator translator;

  TranslatorRepository({
    required this.translator,
  });

  Future<String> translate(String sourceText,
      {String from = 'auto', String to = 'en'}) async {
    if (sourceText.isEmpty) {
      return 'Cripto Sem Descrição';
    } else {
      try {
        final translation =
            await translator.translate(sourceText, from: from, to: to);
        return translation.text;
      } catch (e) {
        return 'Um erro ocorreu ao tentar buscar GoogleTranslate';
      }
    }
  }
}
