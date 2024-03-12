import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animeworld/db_helper/db_helper.dart';

typedef IsEnglish = bool;

class AnimeTitleLanguageCubit extends Cubit<IsEnglish> {
  AnimeTitleLanguageCubit() : super(false) {
    _fetchAnimeTitleLanguage();
  }

  bool get isEnglish => state;

  // Fetch initial language
  Future _fetchAnimeTitleLanguage() async {
    final isEnglish = await DBHelper.instance.isEnglish;
    emit(isEnglish);
  }

  // Change Anime Title Language
  Future changeAnimeTitleLanguage({required bool isEnglish}) async {
    await DBHelper.instance.setIsEnglish(isEnglish);
    emit(isEnglish);
  }
}