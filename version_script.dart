import 'dart:io';
import 'package:version/version.dart';

void main() {
  // Read the current version from pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  final pubspecContent = pubspecFile.readAsStringSync();
  
  // Corrected the regular expression to allow for pre-release and build versions
  final versionMatch = RegExp(r'version: (\d+\.\d+\.\d+.*)').firstMatch(pubspecContent);

  if (versionMatch != null) {
    final currentVersion = Version.parse(versionMatch.group(1)!);

    // Increment the version
    final newVersion = currentVersion.nextPatch;

    // Update pubspec.yaml with the new version
    final newPubspecContent = pubspecContent.replaceFirst(
      versionMatch.group(0)!,
      'version: $newVersion',
    );
    pubspecFile.writeAsStringSync(newPubspecContent);

    print('Version bumped to $newVersion');
  } else {
    print('Error: Unable to find current version in pubspec.yaml');
  }
}
