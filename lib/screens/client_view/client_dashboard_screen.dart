import 'package:flutter/material.dart';
import '../../services/mock_data_service.dart';
import '../../models/fitness_models.dart';
import 'client_workout_plan_screen.dart';
import 'stat_detail_screen.dart';

class ClientDashboardScreen extends StatefulWidget {
  const ClientDashboardScreen({super.key});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  final List<DailyTask> _dailyTasks = [
    DailyTask(title: 'Complete Monday Workout'),
    DailyTask(title: 'Meet Calorie Goal'),
    DailyTask(title: 'Hit Step Goal (10k)'),
    DailyTask(title: 'Morning Mobility Flow'),
  ];

  double get _completionRate {
    if (_dailyTasks.isEmpty) return 0;
    final completed = _dailyTasks.where((t) => t.isCompleted).length;
    return completed / _dailyTasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('ALFA FITNESS', 
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400, fontSize: 13)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none_outlined, size: 20), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildTodaysWorkoutCard(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('DAILY STATS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white38, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildStatsGrid(),
              const SizedBox(height: 12),
              _buildAdditionalStatsGrid(),
              const SizedBox(height: 24),
              _buildWeeklyProgressCard(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text("COACH'S TIP", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white38, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildCoachTip(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('RECENTLY COMPLETED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white38, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildRecentlyCompleted(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sunday, 15 March',
                style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 11, fontWeight: FontWeight.w300),
              ),
              const Text(
                'Welcome, John!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: const Icon(Icons.person_outline, color: Color(0xFFCCFF00), size: 18),
        ),
      ],
    );
  }

  Widget _buildTodaysWorkoutCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFCCFF00).withOpacity(0.15), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFF00),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('TODAY', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 10)),
              ),
              const Spacer(),
              const Text('45-60 min', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 8),
          const Text('Upper Body Power', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          const Text('Focus: Strength & Explosiveness', 
            style: TextStyle(color: Colors.white38, fontSize: 11)),
          const SizedBox(height: 20),
          // Progress Indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progress', style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 10)),
                  const Text('4/8 exercises', style: TextStyle(color: Color(0xFFCCFF00), fontSize: 10, fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.white.withOpacity(0.05),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFCCFF00)),
                  minHeight: 4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientWorkoutPlanScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCFF00),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('GO TO WORKOUT', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1.0, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Steps', '8,432', Icons.directions_walk, Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Calories', '1,240', Icons.local_fire_department, Colors.orange)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.03),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatDetailScreen(
                  title: title,
                  value: value,
                  icon: icon,
                  color: color,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: color, size: 20),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white10, size: 10),
                  ],
                ),
                const SizedBox(height: 12),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: -0.5)),
                Text(title, style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 10, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalStatsGrid() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Sleep', '7h 45m', Icons.bedtime_outlined, Colors.deepPurpleAccent)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Active', '42 min', Icons.timer_outlined, const Color(0xFFCCFF00))),
      ],
    );
  }

  Widget _buildWeeklyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Workout Streak', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white70)),
              Text('${(_completionRate * 100).toInt()}%', 
                style: const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.w300)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
              final isDone = day == 'M' || day == 'T' || day == 'W';
              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? const Color(0xFFCCFF00) : Colors.transparent,
                      border: Border.all(color: isDone ? const Color(0xFFCCFF00) : Colors.white10),
                    ),
                    child: isDone ? const Icon(Icons.check, size: 16, color: Colors.black) : null,
                  ),
                  const SizedBox(height: 8),
                  Text(day, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCoachTip() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFCCFF00).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFCCFF00),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.lightbulb_outline, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pro Tip', style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.w400, fontSize: 11)),
                SizedBox(height: 4),
                Text(
                  'Focus on eccentric control during your Lat Pulldowns today for better muscle fiber engagement.',
                  style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyCompleted() {
    return Column(
      children: [
        _buildRecentItem('Bench Press', '4 sets • 80kg', '2h ago'),
        _buildRecentItem('Protein Shake', '350 kcal • 30g P', '4h ago'),
      ],
    );
  }

  Widget _buildRecentItem(String title, String subtitle, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Color(0xFFCCFF00), size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 11)),
        ],
      ),
    );
  }
}
