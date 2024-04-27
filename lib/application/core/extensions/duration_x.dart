extension DurationX on Duration {
  String toDaysHoursMinutes() {
    final minutes = inMinutes.toString();
    if (inMinutes.isNegative) {
      return '';
    }
    if (inMinutes < 60) return '${minutes}m';
    final twoDigitsMinutes = _toTwoDigits(inMinutes.remainder(60));
    final hours = inHours.toString();
    if (inHours < 24) return '${hours}h ${twoDigitsMinutes}m';
    final twoDigitsHours = _toTwoDigits(inHours.remainder(24));
    final days = inDays.toString();
    return '${days}d ${twoDigitsHours}h';
  }

  String toHoursMinutes({final bool useShorterForm = false, final bool alwaysShowMinutes = true}) {
    final twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60), alwaysShowMinutes: alwaysShowMinutes);
    if (inMinutes < 60) return '${twoDigitMinutes}m';
    final text = '${_toTwoDigits(inHours)}h $twoDigitMinutes${twoDigitMinutes.isEmpty ? '' : 'm'}';
    return useShorterForm && text.startsWith('0') ? text.substring(1) : text;
  }

  String _toTwoDigits(final int n, {final bool alwaysShowMinutes = true}) {
    if (n >= 10) return '$n';
    if (n == 0 && !alwaysShowMinutes) return '';
    return '0$n';
  }

  String get formatDurationHoursMinutes {
    final minutes = inMinutes.remainder(60);
    final hours = inHours;

    final minString = '$minutes min${minutes == 1 ? '' : 's'}';
    final hoursString = hours > 0 ? '$hours h ' : '';

    return hoursString + minString;
  }
}
