import 'dart:convert';
import 'dart:ui';

enum FontSize {
   SMALL,
   MEDIUM,
   LARGE,
}

fontSizeStringToEnum (String fontSizeString) {
  switch (fontSizeString) {
    case 'FontSize.MEDIUM':
      return FontSize.MEDIUM;
    case 'FontSize.SMALL':
      return FontSize.SMALL;
    case 'FontSize.LARGE':
      return FontSize.LARGE;
  }
}

const DEFAULT_FONT_SIZE = FontSize.MEDIUM;

const DEFAULT_DAYS_TO_KEEP_FILES = "7";

const DEFAULT_LOCALE = const Locale("en", "US");

/// Defines the settings object
class Setting {
  /// days to keep files before clearing them
  String daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES;

  /// seconds to listen before stopping a recording
  String secondsSilence = "Yes";

  /// path to the wake word file
  String pathToWakeWord = "path";

  //bool to track if the app is newly intalled
  bool isFirstRun = true;

  // language of preference
  String currentLanguage = "English";

  Locale locale = DEFAULT_LOCALE;

  /// path to the wake word file
  bool enableVoiceOverText = false;

  FontSize noteFontSize = DEFAULT_FONT_SIZE;
  FontSize menuFontSize = DEFAULT_FONT_SIZE;

  /// Constructor takes all properties as params
  Setting();

  String toJson() {
    String jsonStr = """{"daysToKeepFiles": "${this.daysToKeepFiles}",
                        "secondsSilence": "${this.secondsSilence}",
                        "pathToWakeWord": "${this.pathToWakeWord}",
                        "locale": "${this.locale.toString()}",
                        "currentLanguage": "${this.currentLanguage}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText},
                        "noteFontSize": "${this.noteFontSize.toString()}",
                        "menuFontSize": "${this.noteFontSize.toString()}" }
                        """;
    
    return jsonStr;

  }

  factory Setting.fromJson(dynamic jsonObj) {
    Setting setting = Setting();
    print("extracting jsonObj $jsonObj");
    if (jsonObj != "") {
      setting.daysToKeepFiles =
          jsonObj['daysToKeepFiles'].toString();
      setting.secondsSilence = jsonObj['secondsSilence'];
      setting.pathToWakeWord = jsonObj['pathToWakeWord'];
      setting.currentLanguage = jsonObj['currentLanguage'];
      setting.locale = Locale(jsonObj['locale']);
      setting.isFirstRun = jsonObj['isFirstRun'];
      setting.enableVoiceOverText = jsonObj['enableVoiceOverText'];
      setting.noteFontSize = fontSizeStringToEnum(jsonObj['noteFontSize']);
      setting.menuFontSize = fontSizeStringToEnum(jsonObj['menuFontSize']);
    }

    return setting;
  }

  @override
  String toString() {
    return this.toJson();
  }
}
