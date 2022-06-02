import 'package:flutter/services.dart';

class FormatHelper {
  static List<TextInputFormatter> getInputFormatter() {
    const String _searchFormatter =
        r'([A-Za-z\u0E00-\u0E7F0-9-’#_"&()@ *:,./ ]{0,5})' r"([']{0,5})";
    const int _characterLimit = 250;
    List<TextInputFormatter> _formatterList = [
      LengthLimitingTextInputFormatter(_characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(_searchFormatter),
      ),
    ];
    return _formatterList;
  }

  static List<TextInputFormatter> getMobileNumberFormatter() {
    // const String _searchFormatter =
    //     r'((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}';
    const String _searchFormatter = '^\$|^(([0-9]{0,10}))';

    const int _characterLimit = 10;
    List<TextInputFormatter> _formatterList = [
      LengthLimitingTextInputFormatter(_characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(_searchFormatter),
      ),
    ];
    return _formatterList;
  }

  static List<TextInputFormatter> getWeightFormatter() {
    const String _searchFormatter = '^\$|^(([1-9][0-9]{0,2}))(\\.[0-9]{0,2})?';
    const int _characterLimit = 6;
    List<TextInputFormatter> _formatterList = [
      LengthLimitingTextInputFormatter(_characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(_searchFormatter),
      ),
    ];
    return _formatterList;
  }

  static List<TextInputFormatter> getPassportIdFormatter() {
    const String _searchFormatter = r'([A-Za-z0-9]{0,5})';
    const int _characterLimit = 20;
    List<TextInputFormatter> _formatterList = [
      LengthLimitingTextInputFormatter(_characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(_searchFormatter),
      ),
    ];
    return _formatterList;
  }

  static List<TextInputFormatter> getNameFormatter() {
    const String _nameFormatter = r'[A-Za-z0-9-*_#()@:./ ]';
    const int _characterLimit = 50;
    List<TextInputFormatter> _formatterList = [
      LengthLimitingTextInputFormatter(_characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(_nameFormatter),
      ),
    ];
    return _formatterList;
  }
}
