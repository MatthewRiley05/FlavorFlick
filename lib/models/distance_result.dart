class DistanceResult {
  final double meters;
  const DistanceResult(this.meters);

  String get pretty =>
      meters < 1000 ? '${meters.round()} m'
                    : '${(meters / 1000).toStringAsFixed(1)} km';
}
