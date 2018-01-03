import 'dart:io';
import 'package:bmdriver/bmdriver.dart';

main(List<String> arguments) async {
  final stat = await helloMany((10 << 16) | 8081);
  print(stat);

  print('Finished!');
  exit(0);
}
