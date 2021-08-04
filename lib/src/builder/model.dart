import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import '/src/generator/model.dart';

Builder odooProviderModelBuilder(BuilderOptions options) =>
    SharedPartBuilder([OdooProviderModelGenerator()], 'provider');
