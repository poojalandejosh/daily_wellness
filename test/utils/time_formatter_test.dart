import 'package:daily_wellness/core/utils/time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatCurrentTime returns formatted time string', () {
    final testDateTime = DateTime(2025, 7, 8, 9, 5); // 9:05 on 08/07/2025
    final result = formatCurrentTime(testDateTime);

    expect(result, '09:05 - 08/07/2025');
  });

  test('formatCurrentTime handles double digits correctly', () {
    final testDateTime = DateTime(2025, 12, 31, 23, 59);
    final result = formatCurrentTime(testDateTime);

    expect(result, '23:59 - 31/12/2025');
  });
}
