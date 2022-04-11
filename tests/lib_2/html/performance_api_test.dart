// @dart = 2.9
import 'dart:html';

import 'package:expect/minitest.dart';

main() {
  group('supported', () {
    test('supported', () {
      expect(Performance.supported, true);
    });
  });

  group('performance', () {
    test('PerformanceApi', () {
      // Check that code below will not throw exceptions if supported.
      var expectation = Performance.supported ? returnsNormally : throws;
      expect(() {
        var requestStart = window.performance.timing.requestStart;
        var responseStart = window.performance.timing.responseStart;
        var responseEnd = window.performance.timing.responseEnd;

        var loading = window.performance.timing.domLoading;
        var loadedStart = window.performance.timing.domContentLoadedEventStart;
        var loadedEnd = window.performance.timing.domContentLoadedEventEnd;
        var complete = window.performance.timing.domComplete;

        var loadEventStart = window.performance.timing.loadEventStart;
      }, expectation);
    });
    test('markAndMeasure', () {
      window.performance.mark('mark1');
      window.performance.mark('mark2', {'detail': 'metadata'});
      window.performance.measure('measure1');
      window.performance.measure('measure2', 'mark1');
      window.performance.measure('measure3', 'mark1', 'mark2');
    });
  });
}
