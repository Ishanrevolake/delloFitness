import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressReportScreen extends StatelessWidget {
  const ProgressReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('PROGRESS REPORT', 
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400, fontSize: 14)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final meterWidth = math.min(300.0, maxWidth - 48);
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildProgressMeter(meterWidth),
                  const SizedBox(height: 48),
                  _buildSectionHeader('Monthly Adherence'),
                  const SizedBox(height: 16),
                  _buildAdherenceCard(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Performance Gains'),
                  const SizedBox(height: 16),
                  _buildPerformanceGrid(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Lifestyle Habits'),
                  const SizedBox(height: 16),
                  _buildHabitList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12, 
          letterSpacing: 1.5, 
          color: Colors.white38, 
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }

  Widget _buildProgressMeter(double width) {
    return Column(
      children: [
        SizedBox(
          height: width * 0.6,
          width: width,
          child: CustomPaint(
            painter: _MeterPainter(progress: 0.85), // Optimal level
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('OPTIMAL', 
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, letterSpacing: 4, color: Color(0xFFCCFF00))),
                SizedBox(height: 8),
                Text('Current Level', 
                  style: TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _MeterLevel(label: 'Off-Track', color: Colors.red),
            _MeterLevel(label: 'Good', color: Colors.orange),
            _MeterLevel(label: 'Optimal', color: Color(0xFFCCFF00)),
          ],
        ),
      ],
    );
  }

  Widget _buildAdherenceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleProgress('Workouts', 0.92, const Color(0xFFCCFF00)),
          _buildCircleProgress('Nutrition', 0.85, const Color(0xFF42A5F5)),
          _buildCircleProgress('Sleep', 0.78, Colors.deepPurpleAccent),
        ],
      ),
    );
  }

  Widget _buildCircleProgress(String label, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: color.withOpacity(0.05),
            color: color,
            strokeWidth: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white54)),
        Text('${(value * 100).toInt()}%', style: const TextStyle(fontSize: 13, color: Colors.white70)),
      ],
    );
  }

  Widget _buildPerformanceGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.0,
      children: [
        _buildStatTile('Max Bench', '105 kg', '+5kg this month'),
        _buildStatTile('Avg Pace', '4:52 /km', '-10s improvement'),
        _buildStatTile('Body Fat', '14.2%', '-0.8% change'),
        _buildStatTile('Lean Mass', '68.5 kg', '+1.2kg gain'),
      ],
    );
  }

  Widget _buildStatTile(String label, String val, String trend) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(val, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 4),
              Text(trend, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHabitList() {
    return Column(
      children: [
        _buildHabitItem('Hydration Goal', '24/30 days', 0.8),
        _buildHabitItem('No Sugar Streak', '12 days', 0.4),
        _buildHabitItem('Daily Steps', '28/30 days', 0.93),
      ],
    );
  }

  Widget _buildHabitItem(String title, String status, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                Text(status, style: const TextStyle(fontSize: 11, color: Colors.white24)),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 2,
                backgroundColor: Colors.white.withOpacity(0.03),
                color: const Color(0xFFCCFF00).withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MeterPainter extends CustomPainter {
  final double progress;
  _MeterPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Background track
    paint.color = Colors.white.withOpacity(0.05);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Levels indicators (thin lines)
    final markerPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 1;
    
    for (int i = 0; i <= 4; i++) {
      final angle = math.pi + (i * math.pi / 4);
      final start = Offset(
        center.dx + (radius - 10) * math.cos(angle),
        center.dy + (radius - 10) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, markerPaint);
    }

    // Active progress
    paint.color = const Color(0xFFCCFF00);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      paint,
    );

    // Glow
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = const Color(0xFFCCFF00).withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi, math.pi * progress, false, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MeterLevel extends StatelessWidget {
  final String label;
  final Color color;
  const _MeterLevel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 2, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white24, fontWeight: FontWeight.w300)),
      ],
    );
  }
}
