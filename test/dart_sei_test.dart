import 'package:dart_sei/dart_sei.dart';
import 'package:test/test.dart';

void main() {
  group('SeiIcons enum', () {
    test('contains 142 outline icons', () {
      expect(SeiIcons.values.length, equals(142));
      expect(Sei.outlineCount, equals(142));
    });

    test('generates valid outline SVG', () {
      final svg = SeiIcons.home.toSvg();
      expect(svg, startsWith('<svg xmlns="http://www.w3.org/2000/svg"'));
      expect(svg, contains('viewBox="0 0 24 24"'));
      expect(svg, contains('fill="none"'));
      expect(svg, contains('stroke="currentColor"'));
      expect(svg, contains('stroke-width="2"'));
      expect(svg, endsWith('</svg>'));
    });

    test('respects custom size, color, strokeWidth, and class', () {
      final svg = SeiIcons.heart.toSvg(
        size: 32.0,
        color: '#ff0055',
        strokeWidth: 1.5,
        className: 'icon-heart custom',
        attributes: {'aria-hidden': 'true', 'id': 'hero-heart'},
      );
      expect(svg, contains('width="32"'));
      expect(svg, contains('height="32"'));
      expect(svg, contains('stroke="#ff0055"'));
      expect(svg, contains('stroke-width="1.5"'));
      expect(svg, contains('class="icon-heart custom"'));
      expect(svg, contains('aria-hidden="true"'));
      expect(svg, contains('id="hero-heart"'));
    });

    test('generates data URI', () {
      final uri = SeiIcons.star.toDataUri(color: '#ff0000');
      expect(uri, startsWith('data:image/svg+xml;utf8,'));
      expect(uri, contains('%23ff0000'));

      final base64Uri = SeiIcons.star.toDataUri(base64Encode: true);
      expect(base64Uri, startsWith('data:image/svg+xml;base64,'));
    });
  });

  group('SeiIconsFilled enum', () {
    test('contains 23 filled icons', () {
      expect(SeiIconsFilled.values.length, equals(23));
      expect(Sei.filledCount, equals(23));
    });

    test('generates valid filled SVG', () {
      final svg = SeiIconsFilled.heart.toSvg();
      expect(svg, startsWith('<svg xmlns="http://www.w3.org/2000/svg"'));
      expect(svg, contains('fill="currentColor"'));
      expect(svg, isNot(contains('stroke="currentColor"')));
      expect(svg, endsWith('</svg>'));
    });
  });

  group('Sei facade', () {
    test('Sei.byName returns matching icon data', () {
      final home = Sei.byName('home');
      expect(home, isNotNull);
      expect(home!.name, equals('home'));
      expect(home.style, equals(SeiStyle.outline));

      final filledHeart = Sei.byName('heart', style: SeiStyle.filled);
      expect(filledHeart, isNotNull);
      expect(filledHeart!.name, equals('heart'));
      expect(filledHeart.style, equals(SeiStyle.filled));

      final unknown = Sei.byName('non-existent-icon');
      expect(unknown, isNull);
    });

    test('Sei.svgByName generates SVG correctly', () {
      final svg = Sei.svgByName('arrow-right', size: 16);
      expect(svg, contains('width="16"'));
      expect(svg, contains('height="16"'));

      expect(() => Sei.svgByName('unknown-icon'), throwsArgumentError);
    });

    test('Sei.search finds icons by substring', () {
      final searchResults = Sei.search('chart');
      expect(searchResults.length, greaterThanOrEqualTo(3));
      expect(searchResults.any((i) => i.name == 'chart-bar'), isTrue);
      expect(searchResults.any((i) => i.name == 'chart-line'), isTrue);
      expect(searchResults.any((i) => i.name == 'chart-pie'), isTrue);
    });

    test('Sei.all returns all icons', () {
      final all = Sei.all();
      expect(all.length, equals(142 + 23));
    });
  });
}
