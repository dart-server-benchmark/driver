part of stat;

/// Statistics of a single request
class OneStat {
  bool completed;

  Duration time;

  OneStat({this.completed, this.time});

  factory OneStat.fromMap(Map<String, dynamic> map) =>
      new OneStat(completed: map['completed'], time: map['time']);

  Map<String, dynamic> get toMap => {
    'completed': completed,
    'time': time,
  };

  static Stat combine(List<OneStat> singles) {
    final it = new Iterex<OneStat>(singles);

    final Duration time = it.addDuration((stat) => stat.time);
    final int failed = it.count((OneStat stat) => !stat.completed);
    final Duration longest = Array.max(singles, (OneStat stat) => stat.time);
    return new Stat(
        time: time,
        requests: singles.length,
        failed: failed,
        longest: longest);
  }

  String toString() {
    final table = new Table(['Parameter', 'Value'])
      ..row(['Completed', 'true'])
      ..row(['Time', prettySeconds(time)]);
    return table.toString();
  }

  static String manyTable(List<OneStat> stats) {
    final table = new Table(['#', 'Time', 'Completed']);

    for (int i = 0; i < stats.length; i++) {
      table.row([
        '${i+1}',
        prettySeconds(stats[i].time),
        stats[i].completed.toString()
      ]);
    }

    return table.toString();
  }
}