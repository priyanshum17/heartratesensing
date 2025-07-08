import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

/// -------------------------------------------------------------
///  IMU RECORDER 100 Hz (acc, gyro, mag)  ➜  CSV + AirDrop share
/// -------------------------------------------------------------
/// Minimal edits: keeps existing UI but now
///   • Samples every 10 ms (≈100 Hz) via Timer
///   • Builds CSV in‑memory with columns:
///     time,acc_x,acc_y,acc_z,gyro_x,gyro_y,gyro_z,mag_x,mag_y,mag_z
///   • Shares the CSV through the native share sheet (AirDrop works)
/// -------------------------------------------------------------
void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'IMU Data Recording',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _recording = false;
  final List<StreamSubscription<dynamic>> _subs = [];

  // live sensor caches
  double? ax, ay, az, gx, gy, gz, mx, my, mz;
  late Timer _timer; // 10 ms sampler

  // recent lines for on‑screen list & full CSV lines
  final List<String> _recent = [];
  final List<String> _csv = [
    'time,acc_x,acc_y,acc_z,gyro_x,gyro_y,gyro_z,mag_x,mag_y,mag_z'
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('IMU Data Recorder @ 10 Hz')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            SwitchListTile.adaptive(
              title: Text(_recording ? 'Recording…' : 'Not recording'),
              value: _recording,
              onChanged: (v) => v ? _start() : _stop(),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share CSV'),
              onPressed: _exportCsv,
            ),
            const SizedBox(height: 12),
            const Divider(),
            Expanded(
              child: _recent.isEmpty
                  ? const Center(child: Text('No data yet'))
                  : ListView.builder(
                      itemCount: _recent.length,
                      itemBuilder: (_, i) => Text(_recent[i]),
                    ),
            ),
          ]),
        ),
      );

  void _start() {
    if (_recording) return;
    setState(() => _recording = true);

    // subscribe to raw sensor streams only (no DB)…
    _subs
      ..add(accelerometerEvents.listen((e) => (ax = e.x, ay = e.y, az = e.z)))
      ..add(gyroscopeEvents.listen((e) => (gx = e.x, gy = e.y, gz = e.z)))
      ..add(magnetometerEvents.listen((e) => (mx = e.x, my = e.y, mz = e.z)));

    // sample every 10 ms → 100 Hz
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _sample());
  }

  void _stop() {
    for (final s in _subs) s.cancel();
    _subs.clear();
    _timer.cancel();
    setState(() => _recording = false);
  }

  void _sample() {
    final t = DateTime.now().millisecondsSinceEpoch;
    // if any sensor hasn't produced a value yet, skip this tick
    if ([ax, ay, az, gx, gy, gz, mx, my, mz].any((v) => v == null)) return;

    final line =
        '$t,${ax!.toStringAsFixed(4)},${ay!.toStringAsFixed(4)},${az!.toStringAsFixed(4)},${gx!.toStringAsFixed(4)},${gy!.toStringAsFixed(4)},${gz!.toStringAsFixed(4)},${mx!.toStringAsFixed(4)},${my!.toStringAsFixed(4)},${mz!.toStringAsFixed(4)}';
    _csv.add(line);

    setState(() {
      _recent.insert(0, line);
      if (_recent.length > 100) _recent.removeLast();
    });
  }

  Future<void> _exportCsv() async {
    if (_csv.length == 1) return; // no data
    final tmp = await getTemporaryDirectory();
    final file = File(path.join(tmp.path, 'imu_10hz_${DateTime.now().millisecondsSinceEpoch}.csv'));
    await file.writeAsString(_csv.join('\n'));
    await Share.shareXFiles([XFile(file.path)], text: 'IMU 10 Hz data');
  }

  @override
  void dispose() {
    if (_recording) _stop();
    super.dispose();
  }
}
