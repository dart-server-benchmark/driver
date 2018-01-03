import 'dart:io';
import 'package:go/go.dart';
import 'package:bmdriver/bmdriver.dart';

main(List<String> arguments) async {
  final Herd<Stat, int> h = await herd<Stat, int>(helloMany, 10,
      resultEncoder: Stat.encode, resultDecoder: Stat.decode);
  List<Stat> stats = await h.execSame((10 << 16) | 8081);

  stats.forEach((s) => print(s));

  final Stat stat = Stat.combine(stats);

  print(stat);

  print('Finished!');
  exit(0);
}
