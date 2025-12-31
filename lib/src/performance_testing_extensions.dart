import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'advanced_gesture_extensions.dart'; // For data classes

/// Extensions for performance testing and monitoring
extension PerformanceTestingExtensions on Widget {
  /// Measure build time of the widget
  Widget measureBuildTime({
    String? label,
    void Function(Duration)? onMeasured,
    bool logToConsole = true,
  }) {
    return _BuildTimeProfiler(
      label: label,
      onMeasured: onMeasured,
      logToConsole: logToConsole,
      child: this,
    );
  }

  /// Monitor memory usage of the widget
  Widget measureMemoryUsage({
    String? label,
    void Function(MemoryUsage)? onMeasured,
    Duration interval = const Duration(seconds: 1),
  }) {
    return _MemoryProfiler(
      label: label,
      onMeasured: onMeasured,
      interval: interval,
      child: this,
    );
  }

  /// Perform stress testing on the widget
  Widget stressTest({
    int iterations = 100,
    Duration delay = const Duration(milliseconds: 16),
    void Function(StressTestResult)? onComplete,
  }) {
    return _StressTester(
      iterations: iterations,
      delay: delay,
      onComplete: onComplete,
      child: this,
    );
  }

  /// Show performance overlay
  Widget performanceOverlay({
    bool showFPS = true,
    bool showMemory = true,
    bool showBuildTime = true,
    Color? overlayColor,
  }) {
    return _PerformanceOverlay(
      showFPS: showFPS,
      showMemory: showMemory,
      showBuildTime: showBuildTime,
      overlayColor: overlayColor,
      child: this,
    );
  }

  /// Benchmark the widget performance
  Widget benchmark({
    String testName = 'widget_benchmark',
    int warmupRuns = 10,
    int measureRuns = 100,
    void Function(BenchmarkResult)? onResult,
  }) {
    return _WidgetBenchmark(
      testName: testName,
      warmupRuns: warmupRuns,
      measureRuns: measureRuns,
      onResult: onResult,
      child: this,
    );
  }
}

class _BuildTimeProfiler extends StatefulWidget {
  const _BuildTimeProfiler({
    required this.child,
    this.label,
    this.onMeasured,
    this.logToConsole = true,
  });

  final Widget child;
  final String? label;
  final void Function(Duration)? onMeasured;
  final bool logToConsole;

  @override
  State<_BuildTimeProfiler> createState() => _BuildTimeProfilerState();
}

class _BuildTimeProfilerState extends State<_BuildTimeProfiler> {
  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch()..start();

    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          stopwatch.stop();
          final duration = stopwatch.elapsed;

          if (widget.logToConsole) {
            final label = widget.label ?? 'Widget';
            developer.log('$label build time: ${duration.inMicroseconds}μs');
          }

          widget.onMeasured?.call(duration);
        });

        return widget.child;
      },
    );
  }
}

class _MemoryProfiler extends StatefulWidget {
  const _MemoryProfiler({
    required this.child,
    this.label,
    this.onMeasured,
    required this.interval,
  });

  final Widget child;
  final String? label;
  final void Function(MemoryUsage)? onMeasured;
  final Duration interval;

  @override
  State<_MemoryProfiler> createState() => _MemoryProfilerState();
}

class _MemoryProfilerState extends State<_MemoryProfiler> {
  Timer? _timer;
  double _peakMemory = 0.0;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(widget.interval, (timer) {
      // Simulate memory usage measurement
      // In a real implementation, you would use dart:developer or platform channels
      final currentMemory = _getCurrentMemoryUsage();
      if (currentMemory > _peakMemory) {
        _peakMemory = currentMemory;
      }

      widget.onMeasured?.call(
        MemoryUsage(
          current: currentMemory,
          peak: _peakMemory,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  double _getCurrentMemoryUsage() {
    // Placeholder implementation
    // In production, this would use actual memory profiling APIs
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _StressTester extends StatefulWidget {
  const _StressTester({
    required this.child,
    required this.iterations,
    required this.delay,
    this.onComplete,
  });

  final Widget child;
  final int iterations;
  final Duration delay;
  final void Function(StressTestResult)? onComplete;

  @override
  State<_StressTester> createState() => _StressTesterState();
}

class _StressTesterState extends State<_StressTester> {
  int _currentIteration = 0;
  final List<double> _frameTimes = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startStressTest();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStressTest() {
    _timer = Timer.periodic(widget.delay, (timer) {
      if (_currentIteration >= widget.iterations) {
        timer.cancel();
        _completeTest();
        return;
      }

      setState(() {
        _currentIteration++;
      });

      // Measure frame time
      final frameTime =
          SchedulerBinding.instance.currentFrameTimeStamp.inMicroseconds /
          1000.0;
      _frameTimes.add(frameTime);
    });
  }

  void _completeTest() {
    if (_frameTimes.isNotEmpty) {
      final avgFPS = _frameTimes.reduce((a, b) => a + b) / _frameTimes.length;
      final minFPS = _frameTimes.reduce((a, b) => a < b ? a : b);
      final maxFPS = _frameTimes.reduce((a, b) => a > b ? a : b);

      widget.onComplete?.call(
        StressTestResult(
          averageFPS: avgFPS,
          minFPS: minFPS,
          maxFPS: maxFPS,
          totalFrames: _frameTimes.length,
          droppedFrames: _frameTimes.where((time) => time > 16.67).length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _PerformanceOverlay extends StatefulWidget {
  const _PerformanceOverlay({
    required this.child,
    required this.showFPS,
    required this.showMemory,
    required this.showBuildTime,
    this.overlayColor,
  });

  final Widget child;
  final bool showFPS;
  final bool showMemory;
  final bool showBuildTime;
  final Color? overlayColor;

  @override
  State<_PerformanceOverlay> createState() => _PerformanceOverlayState();
}

class _PerformanceOverlayState extends State<_PerformanceOverlay> {
  double _fps = 0.0;
  double _memory = 0.0;
  final Duration _buildTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _fps = _calculateFPS();
          _memory = _getCurrentMemoryUsage();
        });
      } else {
        timer.cancel();
      }
    });
  }

  double _calculateFPS() {
    // Placeholder FPS calculation
    return 60.0;
  }

  double _getCurrentMemoryUsage() {
    // Placeholder memory usage
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showFPS || widget.showMemory || widget.showBuildTime)
          Positioned(
            top: 50,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    widget.overlayColor ?? Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showFPS)
                    Text(
                      'FPS: ${_fps.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  if (widget.showMemory)
                    Text(
                      'Memory: ${_memory.toStringAsFixed(1)}MB',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  if (widget.showBuildTime)
                    Text(
                      'Build: ${_buildTime.inMicroseconds}μs',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _WidgetBenchmark extends StatefulWidget {
  const _WidgetBenchmark({
    required this.child,
    required this.testName,
    required this.warmupRuns,
    required this.measureRuns,
    this.onResult,
  });

  final Widget child;
  final String testName;
  final int warmupRuns;
  final int measureRuns;
  final void Function(BenchmarkResult)? onResult;

  @override
  State<_WidgetBenchmark> createState() => _WidgetBenchmarkState();
}

class _WidgetBenchmarkState extends State<_WidgetBenchmark> {
  final List<Duration> _buildTimes = [];
  int _currentRun = 0;
  bool _isWarming = true;

  @override
  void initState() {
    super.initState();
    _startBenchmark();
  }

  void _startBenchmark() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_isWarming && _currentRun >= widget.warmupRuns) {
        _isWarming = false;
        _currentRun = 0;
        _buildTimes.clear();
      } else if (!_isWarming && _currentRun >= widget.measureRuns) {
        timer.cancel();
        _completeBenchmark();
        return;
      }

      setState(() {
        _currentRun++;
      });

      if (!_isWarming) {
        final stopwatch = Stopwatch()..start();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          stopwatch.stop();
          _buildTimes.add(stopwatch.elapsed);
        });
      }
    });
  }

  void _completeBenchmark() {
    if (_buildTimes.isNotEmpty) {
      final totalTime = _buildTimes.fold<Duration>(
        Duration.zero,
        (prev, time) => prev + time,
      );
      final avgTime = Duration(
        microseconds: totalTime.inMicroseconds ~/ _buildTimes.length,
      );
      final minTime = _buildTimes.reduce((a, b) => a < b ? a : b);
      final maxTime = _buildTimes.reduce((a, b) => a > b ? a : b);

      widget.onResult?.call(
        BenchmarkResult(
          testName: widget.testName,
          averageBuildTime: avgTime,
          minBuildTime: minTime,
          maxBuildTime: maxTime,
          totalRuns: _buildTimes.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
