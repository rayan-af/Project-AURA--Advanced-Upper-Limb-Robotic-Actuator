class TelemetryModel {
  final int batteryLevel;
  final int signalStrength;
  final String connectionStatus;
  final int currentSignal;

  const TelemetryModel({
    this.batteryLevel = 0,
    this.signalStrength = 0,
    this.connectionStatus = 'status_disconnected', // Disconnected
    this.currentSignal = 0,
  });

  TelemetryModel copyWith({
    int? batteryLevel,
    int? signalStrength,
    String? connectionStatus,
    int? currentSignal,
  }) {
    return TelemetryModel(
      batteryLevel: batteryLevel ?? this.batteryLevel,
      signalStrength: signalStrength ?? this.signalStrength,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      currentSignal: currentSignal ?? this.currentSignal,
    );
  }
}
