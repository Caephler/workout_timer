class Ticker {
  const Ticker();

  Stream<Duration> tick({required Duration period}) {
    return Stream.periodic(period, (x) => period);
  }
}
