import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class ProviderService extends ChangeNotifier {
  String selectedValue1 = '한국어';
  String selectedValue2 = '영어';

  List<String> languages = [
    '한국어',
    '영어',
    '일본어',
    '중국어(간체)',
    '중국어(번체)',
    '스페인어',
    '독일어',
    '러시아어',
    '베트남어',
    '힌디어',
    '태국어',
    '프랑스어',
    '포르투갈어',
    '이탈리아어',
  ];

  List<String> languagesCode = [
    'ko',
    'en',
    'ja',
    'zh-cn',
    'zh-tw',
    'es',
    'de',
    'ru',
    'vi',
    'hi',
    'th',
    'fr',
    'pt',
    'it',
  ];
}
