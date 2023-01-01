import 'package:flutter/cupertino.dart';
import 'package:quick_translate/model/model.dart';
import 'services.dart';

class TranslateService {
  static GoogleTranslator translator = GoogleTranslator();
  static String input = '';

  static Future<Translation> translate(BuildContext context) async {
    var translation;

    try {
      final ref = context.read<ProviderService>();
      var fromLang =
          ref.languagesCode[ref.languages.indexOf(ref.selectedValue1)];
      var toLang = ref.languagesCode[ref.languages.indexOf(ref.selectedValue2)];

      translation = translator.translate(input, from: fromLang, to: toLang);
    } catch (e) {
      print(e);
    }

    return translation;
  }
}
