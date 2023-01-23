import 'dart:convert';
import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:args/args.dart';
import 'package:dartdoc_json/dartdoc_json.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) {
  exitCode = 0;
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
    stdout.writeln(
      'A command-line utility that can extract the API of dart file(s) and\n'
      'save it in JSON format.',
    );
    stdout.writeln();
    stdout.writeln('Usage: dart run dartdoc_json.dart <input> [Parameters]');
    stdout.writeln();
    stdout.writeln('Parameters:');
    stdout.writeln(parser.usage);
    exitCode = 1;
    return;
  }
  if (!Directory(root).existsSync()) {
    stderr.writeln('Directory `$root` does not exist');
    exitCode = 2;
    return;
  }
  final encoder =
      pretty ? const JsonEncoder.withIndent('  ') : const JsonEncoder();

  final result = <Map<String, dynamic>>[];
  for (final input in inputs) {
    final fullPath = path.canonicalize(path.join(root, input));
    if (!File(fullPath).existsSync()) {
      stderr.writeln('File `$fullPath` does not exist');
      exitCode = 2;
      return;
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
}
