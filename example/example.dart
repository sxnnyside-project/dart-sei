import 'package:dart_sei/dart_sei.dart';

void main() {
  print('=== Sxnnyside Eloquent Icons (SEI) - Pure Dart ===\n');

  // 1. Direct enum usage
  print('--- 1. Outline Icon SVG ---');
  final homeSvg = SeiIcons.home.toSvg(size: 24, color: '#b575ff');
  print(homeSvg);
  print('');

  // 2. Filled icon usage
  print('--- 2. Filled Icon SVG ---');
  final heartFilledSvg = SeiIconsFilled.heart.toSvg(size: 24, color: '#ff2d55');
  print(heartFilledSvg);
  print('');

  // 3. Data URI (for HTML / CSS background-image)
  print('--- 3. Data URI ---');
  final dataUri = SeiIcons.star.toDataUri(color: '#ffd700');
  print(dataUri);
  print('');

  // 4. Dynamic lookup by name
  print('--- 4. Lookup by name ---');
  final iconData = Sei.byName('arrow-right');
  if (iconData != null) {
    print('Found icon: ${iconData.name} (${iconData.style.name})');
  }
  print('');

  // 5. Search icons
  print('--- 5. Search icons ("chart") ---');
  final searchResults = Sei.search('chart');
  for (final icon in searchResults) {
    print(' • ${icon.name} [${icon.style.name}]');
  }
  print('\nTotal outline icons: ${Sei.outlineCount}');
  print('Total filled icons: ${Sei.filledCount}');
}
