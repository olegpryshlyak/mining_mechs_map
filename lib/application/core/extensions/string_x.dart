extension StringX on String {
  bool containsWithLowerCase(final String value) => toLowerCase().contains(value.toLowerCase());

  bool equalsWithLowerCase(final String value) => toLowerCase() == value.toLowerCase();

  bool equalsWithNormalized(final String value) => normalize() == value.normalize();

  bool startsWithLowerCase(final String value) => toLowerCase().startsWith(value.toLowerCase());

  String toSentenceCase() => isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : this;

  String toCamelCase() => split(' ').map((final e) => e.toSentenceCase()).join(' ');

  String? get notEmptyValueOrNull => isNotEmpty ? this : null;

  String replaceLast(final String from, final String to) =>
      isNullOrEmpty ? '' : split('').reversed.join().replaceFirst(from, to).split('').reversed.join();

  String mapScandinavianToEnglish() {
    var mappedText = this;
    _scandinavianMapping.forEach((final key, final value) {
      mappedText = mappedText.replaceAll(key, value);
    });
    return mappedText;
  }

  bool hasNSymbolsMatching(final String input, final int n) {
    final chars1 = split('');
    for (var i = 0; i < chars1.length - (n - 1); i++) {
      if (input.toLowerCase().contains(chars1.sublist(i, i + n).join().toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  String normalize() => toLowerCase().replaceAll(' ', '');
}

extension StringNullX on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool equalsWithLowerCase(final String? value) =>
      this == null || value == null ? false : this!.toLowerCase() == value.toLowerCase();
}

const _scandinavianMapping = {
  'Å': 'A',
  'Ä': 'A',
  'Ö': 'O',
  'Æ': 'A',
  'Ø': 'O',
  'Ü': 'U',
  'É': 'E',
  'È': 'E',
  'Ê': 'E',
  'Ë': 'E',
  'ß': 'ss',
  'Á': 'A',
  'À': 'A',
  'Â': 'A',
  'Ã': 'A',
  'Í': 'I',
  'Ì': 'I',
  'Î': 'I',
  'Ï': 'I',
  'Ú': 'U',
  'Ù': 'U',
  'Û': 'U',
  'Ó': 'O',
  'Ò': 'O',
  'Ô': 'O',
  'Õ': 'O',
  'Ý': 'Y',
  'Ÿ': 'Y',
  'Ç': 'C',
  'Ñ': 'N',
  'Š': 'S',
  'Ž': 'Z',
  'Ð': 'D',
  'Þ': 'TH',
  'å': 'a',
  'ä': 'a',
  'ö': 'o',
  'æ': 'ae',
  'ø': 'o',
  'ü': 'u',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ë': 'e',
  'á': 'a',
  'à': 'a',
  'â': 'a',
  'ã': 'a',
  'í': 'i',
  'ì': 'i',
  'î': 'i',
  'ï': 'i',
  'ú': 'u',
  'ù': 'u',
  'û': 'u',
  'ū': 'u',
  'ó': 'o',
  'ò': 'o',
  'ô': 'o',
  'õ': 'o',
  'ý': 'y',
  'ÿ': 'y',
  'ç': 'c',
  'ñ': 'n',
  'š': 's',
  'ž': 'z',
  'ð': 'd',
  'þ': 'th',
  '.': ' ',
  'ė': 'e',
  'ś': 's',
  'ą': 'a',
  'ș': 's',
  'ł': 'l',
  'ę': 'e',
  'Ę': 'E',
  'ā': 'a',
  'ī': 'i',
  'ş': 's',
  'Ş': 'S',
  'ż': 'z',
  'Ż': 'Z',
  'ń': 'n',
  'Ń': 'N'
};
