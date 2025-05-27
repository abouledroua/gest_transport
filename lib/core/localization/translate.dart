import 'package:get/get.dart';

import 'translations/ar.dart';
import 'translations/en.dart';
import 'translations/fr.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {"en": enTr(), "ar": arTr(), "fr": frTr()};
}
