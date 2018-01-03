import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:bmdriver/bmdriver.dart';

Future<OneStat> hello(int port, {HttpClient client}) async {
  client ??= new HttpClient();

  final stat = new OneStat()..completed = false;

  final reqWatch = new Stopwatch();

  await client
      .get('localhost', port, '/api/hello')
      .then((HttpClientRequest request) {
    reqWatch.start();
    return request.close();
  }).then((HttpClientResponse response) async {
    reqWatch.stop();

    final builder = new StringBuffer();
    await for (String a in await response.transform(UTF8.decoder)) {
      builder.write(a);
    }

    if (builder.toString() == 'hello' && response.statusCode == 200) {
      stat.completed = true;
    }
  });

  stat.time = reqWatch.elapsed;
  return stat;
}

Future<Stat> helloMany(int args) async {
  final int seconds = args >> 16;
  final int port = args & 0xFFFF;
  final watch = new Stopwatch();
  final stats = <OneStat>[];
  final HttpClient client = new HttpClient();
  watch.start();
  try {
    while (watch.elapsed.inSeconds < seconds) {
      stats.add(await hello(port, client: client));
    }
  } catch (e) {} finally {
    client.close(force: true);
  }
  watch.stop();
  return OneStat.combine(stats);
}
