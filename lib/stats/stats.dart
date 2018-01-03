library stat;

import 'package:duration/duration.dart';
import 'package:text_table/text_table.dart';

import '../utils/array.dart';

part 'one.dart';

/// Summary statistics of multiple requests
class Stat {
  /// Total time of all the requests combined.
  Duration time = new Duration();

  /// Number of total requests sent.
  int requests = 0;

  /// Number of requests failed.
  int failed = 0;

  /// Mean time per single request.
  Duration get timePerReq =>
      new Duration(microseconds: time.inMicroseconds ~/ requests);

  /// Duration of longest request.
  Duration longest = new Duration();

  Stat({this.time, this.requests: 0, this.failed, this.longest});

  factory Stat.fromMap(Map<String, dynamic> map) => new Stat(
      time: map['totalTime'],
      requests: map['requests'],
      failed: map['failed'],
      longest: map['longest']);

  Map<String, dynamic> get toMap => {
        'totalTime': time,
        'requests': requests,
        'failed': failed,
        'longest': longest,
      };

  String toString() {
    final tab = table(['Parameter', 'Value']);

    tab.row(['Time', prettyDuration(time)]);
    tab.row(['Requests', requests.toString()]);
    if (failed != 0) tab.row(['Failed', failed.toString()]);

    tab.row(['Longest', prettySeconds(longest)]);
    tab.row(['Time/req', prettySeconds(timePerReq)]);

    return tab.toString();
  }

  static Stat combine(List<Stat> ind) {
    final Duration time = Array.addDuration(
      ind,
      (Stat stat) => stat.time,
    );
    final int requests = Array.add(
      ind,
      (Stat stat) => stat.requests,
    );
    final int failed = Array.add(
      ind,
      (Stat stat) => stat.failed,
    );
    final Duration longest = Array.max(ind, (Stat stat) => stat.longest);
    return new Stat(
        time: time, requests: requests, failed: failed, longest: longest);
  }

  static Map<String, dynamic> encode(Stat s) => s.toMap;

  static Stat decode(Map m) => new Stat.fromMap(m);
}
