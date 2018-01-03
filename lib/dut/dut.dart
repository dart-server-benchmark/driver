class Dut {
  final int id;

  final String name;

  final int port;

  const Dut(this.id, this.name, this.port);

  static const Dut dartJaguarMux = const Dut(0, 'Dart Jaguar Mux', 8080);

  static const Dut dartIo = const Dut(0, 'Dart IO', 8081);

  static const Dut dartAngel = const Dut(0, 'Dart Angel', 8082);

  static const Dut dartAqueduct = const Dut(0, 'Dart IO', 8083);

  static const Dut dartShelf = const Dut(0, 'Dart Shelf', 8084);

  static const Dut dartJaguarReflect =
      const Dut(0, 'Dart Jaguar Reflect', 8085);

  static const Dut dartJaguarSrcgen =
      const Dut(0, 'Dart Jaguar Source gen', 8086);

  static const Dut golangHttp = const Dut(0, 'Golang http', 9000);

  static const Dut golangMartini = const Dut(0, 'Golang Martini', 9000);

  static const Dut golangGorilla = const Dut(0, 'Golang Gorilla', 9000);

  static const Dut jsExpress = const Dut(0, 'JS Express', 7000);
}
