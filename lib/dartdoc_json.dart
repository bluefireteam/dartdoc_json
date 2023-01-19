import 'dart:convert';
import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:args/args.dart';
import 'package:dartdoc_json/src/compilation_unit.dart';
import 'package:path/path.dart' as path;

int main(List<String> args) {
  final parser = ArgParser(usageLineLength: 80)
    ..addOption(
      'root',
      abbr: 'r',
      defaultsTo: '.',
      help: 'The path to the root folder of the package. The input file names '
          'will be resolved relative to this folder.',
    )
    ..addOption(
      'output',
      abbr: 'o',
      defaultsTo: 'out.json',
      help: 'Output file where the JSON will be written to.',
    )
    ..addFlag(
      'pretty',
      negatable: false,
      help: 'Pretty-print the output JSON file.',
    );
  final arguments = parser.parse(args);
  final root = arguments['root'] as String;
  final output = arguments['output'] as String;
  final pretty = arguments['pretty'] as bool;
  final inputs = arguments.rest;
  if (inputs.isEmpty) {
    // ignore_for_file: avoid_print
    print(
      'A command-line utility that can extract the API of dart file(s) and\n'
      'save it in JSON format.',
    );
    print('');
    print('Usage: dart run dartdoc_json.dart <input> [Parameters]');
    print('');
    print('Parameters:');
    print(parser.usage);
    return 1;
  }
  if (!Directory(root).existsSync()) {
    print('Directory `$root` does not exist');
    return 2;
  }
  final encoder =
      pretty ? const JsonEncoder.withIndent('  ') : const JsonEncoder();

  final result = <Map<String, dynamic>>[];
  for (final input in inputs) {
    final fullPath = path.canonicalize(path.join(root, input));
    if (!File(fullPath).existsSync()) {
      print('File `$fullPath` does not exist');
      return 2;
    }
    final parsed = parseFile(
      path: fullPath,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    final unit = serializeCompilationUnit(parsed.unit);
    unit['source'] = input;
    result.add(unit);
  }
  final json = encoder.convert(result);
  File(output).writeAsStringSync(json);
  return 0;
}
